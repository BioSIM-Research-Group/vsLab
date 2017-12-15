package provide Gui_Sasa 1.0


proc VsLab::buildGuiSasa {sasa} {

	if {[winfo exists $sasa]} {destroy $sasa ;return ""}
	toplevel $sasa
	
	# Title of the window
	wm title $sasa "Highlight Activesite" ;# titulo da pagina
#	wm geometry $sasa 360x100; update
	

	
########## Frame 1
        grid [ttk::frame $sasa.f1 ] -in $sasa -row 0 -column 0 -sticky news -ipady 5

########## Frame 2
	
	grid [ttk::frame $sasa.f2 ] -in $sasa -row 1 -column 0 -sticky news -ipady 5
	
	
		# Parameters
		grid [ttk::label $sasa.f2.lbSel1 -text "Parameters      : "] -in $sasa.f2 -row 0 -column 0 -padx 5 
	
		# Box Parameteres
	
		grid [ttk::label $sasa.f2.lbRad -text "Radius: " ] -in $sasa.f2 -row 0 -column 1 -padx 5 -sticky w 
		grid [spinbox $sasa.f2.sp1 -width 4 -from 0 -to 10 -increment 0.05 -command {}] -in $sasa.f2 -row 0 -column 2 -padx 5
	
		$sasa.f2.sp1 set 1.4
	
		grid [ttk::label $sasa.f2.lbRes -text "Points: " ] -in $sasa.f2 -row 0 -column 3 -padx 5 -sticky w 
		grid [spinbox $sasa.f2.sp2 -width 4 -from 1 -to 5000 -increment 10 -command {}] -in $sasa.f2 -row 0 -column 4 -padx 5
	
		$sasa.f2.sp2 set 50	
	
########## Frame 3
	grid [ttk::frame $sasa.f3] -in $sasa -row 2 -column 0 -sticky news  -ipady 5
		
		# Representation
		grid [ttk::label $sasa.f3.lbSel1 -text "Representation : "] -in $sasa.f3 -row 0 -column 0 -padx 5 
  	
		set rep "Off VdW Surface"
		grid [ttk::combobox $sasa.f3.cb1 -values $rep -width 8 -state readonly] -in $sasa.f3 -row 0 -column 1  -padx 5
		$sasa.f3.cb1  set [lindex $rep 2]
	
	    				
		grid [ttk::label $sasa.f3.lbSel -text "colored by : " ] -in $sasa.f3 -row 0 -column 2  -padx 5

		set repN "Name ResName ResType Index Pos Beta"
		grid [ttk::combobox $sasa.f3.cb2 -values $repN -width 8 -state readonly ] -in $sasa.f3 -row 0 -column 3  -padx 5
		$sasa.f3.cb2  set [lindex $repN 0]
	
				
########## Frame 4
      	grid [ttk::frame $sasa.f4 ] -row 3 -column 0 -sticky news -ipady 5
	grid [ttk::button $sasa.f4.box3 -text "Show" -command {VsLab::ShowSasa}] -in $sasa.f4  -row 0 -column 0 -sticky e
	grid [ttk::button $sasa.f4.box2 -text "Exit" -command {destroy .sasa}] -in $sasa.f4  -row 0 -column 1  -sticky e 
	

	
	
########## Bindings	
	bind $sasa.f3.cb2 <<ComboboxSelected>> {
			set nameLayer ""
			foreach x [molinfo list] {set nameLayer [linsert $nameLayer end [molinfo $x get name]]}
			if {[lsearch $nameLayer "SASA"]!=-1} {set mol [molinfo index [lsearch $nameLayer "SASA"]]}
			mol modcolor 0 $mol [.sasa.f3.cb2 get]
	}

}



proc box_aminoColor {name} {
	
	set color green 
	set hydrophobic "ALA ILE LEU MET PHE PRO VAL" 
	if {[lsearch $hydrophobic $name]!=-1} {set color blue}
	
	set charge_pos "ARG HIS LYS"modifycmd
	if {[lsearch $charge_pos $name]!=-1} {set color cyan}
	
	set charge_neg "ASP GLU"
	if {[lsearch $charge_neg $name]!=-1} {set color red}
	
	set others "ASN CYS GLN GLY SER THR TRP TYR"
	if {[lsearch $others $name]!=-1} {set color green}
	
return $color
}


proc VsLab::ShowSasa {} {

	set topLayer [molinfo top]
	set selection ""; # list with the selected atoms
	set safeArea 0; # selects ta little bit outside
	set nameLayer ""

	## put computer to think
	.sasa configure -cursor watch; update
	
	# Create or see if exists the layer for the sasa
	foreach x [molinfo list] {set nameLayer [linsert $nameLayer end [molinfo $x get name]]}
	if {[lsearch $nameLayer "SASA"]!=-1} {set sasaLayer [molinfo index [lsearch $nameLayer "SASA"]]; mol delete $sasaLayer}	
	
	
	
	set allsel [atomselect $topLayer  "all and not atomicnumber 1"]
	set pointsMem ""; set pointsName ""; set sasaValues ""; set idValues ""
	
	#### If the box is used ####
	# Get the atoms that are within the box and their sasa
	foreach xyz [$allsel get {x y z}] index [$allsel get resid] name [$allsel get resname] id [$allsel get resid] {
	
		set x_coord [lindex $xyz 0]
		set y_coord [lindex $xyz 1]
		set z_coord [lindex $xyz 2]
		
		if {($x_coord >= [ expr $VsLab::X - ( $VsLab::W/2 + $safeArea)] && $x_coord <= [ expr $VsLab::X + ( $VsLab::W/2 + $safeArea)]) && \
		    ($y_coord >= [ expr $VsLab::Y - ( $VsLab::H/2 + $safeArea)] && $y_coord <= [ expr $VsLab::Y + ( $VsLab::H/2 + $safeArea)]) && \
		    ($z_coord >= [ expr $VsLab::Z - ( $VsLab::D/2 + $safeArea)] && $z_coord <= [ expr $VsLab::Z + ( $VsLab::D/2 + $safeArea)]) } {
				
				# calculate sasa
				set sel [atomselect $topLayer "resid $index"]	
				set sasa [measure sasa [.sasa.f2.sp1 get] $allsel -restrict $sel -points pts -samples [.sasa.f2.sp2 get]  ]
				
				## see what points are withing the box
				if {$sasa>=0 && [lsearch $selection $index]==-1} {
					set selection "$selection $index"
					foreach pt $pts {
						if {([lindex $pt 0] >= [ expr $VsLab::X - ( $VsLab::W/2 + $safeArea)] && [lindex $pt 0] <= [ expr $VsLab::X + ( $VsLab::W/2 + $safeArea)]) && \
						    ([lindex $pt 1] >= [ expr $VsLab::Y - ( $VsLab::H/2 + $safeArea)] && [lindex $pt 1] <= [ expr $VsLab::Y + ( $VsLab::H/2 + $safeArea)]) && \
						    ([lindex $pt 2] >= [ expr $VsLab::Z - ( $VsLab::D/2 + $safeArea)] && [lindex $pt 2] <= [ expr $VsLab::Z + ( $VsLab::D/2 + $safeArea)]) } {
							
							set pointsMem  [linsert $pointsMem end $pt]
							set pointsName [linsert $pointsName end $name]
							set sasaValues [linsert $sasaValues end $sasa]
							set idValues   [linsert $idValues end $id]
							
						}
					} 
				}
				
		}
	}; # foreach
	
	
	set mol [mol new atoms [llength $pointsMem]]
	mol rename top "SASA"
	animate dup $mol
	set sel [atomselect $mol all]
	set num 1;set list ""
	foreach point $pointsMem name $pointsName sasa $sasaValues id $idValues {
		set list [lappend list " 1 H H $name A [format %7.3f [lindex $point 0]] [format %7.3f [lindex $point 1]] [format %7.3f [lindex $point 2]] $sasa"]
		incr num
	}

	$sel set {radius element name resname chain x y z beta } $list
	
	## Load the data in layer
	mol addrep [molinfo top]
	
	set repr "points"
	if {[.sasa.f3.cb1 get]=="VdW"} {set repr "VDW 0.400000 8.000000"}
	if {[.sasa.f3.cb1 get]=="Surface"} {set repr "surf 1.400000 0.00000"}
	
	mol modstyle 0 $mol $repr
	mol modcolor 0 $mol [.sasa.f3.cb2 get]
	
	#update
	::TopoTools::adddefaultrep [molinfo top]
	mol top $topLayer
	

.sasa configure -cursor {}; update

}


