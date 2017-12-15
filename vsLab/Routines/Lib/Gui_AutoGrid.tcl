package provide Gui_AutoGrid 1.0


proc VsLab::buildAutoGridFrame {grid} {	
	
########## Frame 1

	## LabelFrame
	grid [ttk::labelframe $grid.f1 -text "Docking Area :"] -row 0 -column 0 -sticky news -pady 10 -padx 10

			
	## Box Parameteres
	grid [ttk::label $grid.f1.lbDim -text "Box Dimensions: "] -in $grid.f1 -row 0 -column 0 -padx 5 -pady 10 -sticky w

	grid [ttk::label $grid.f1.lbDimW -text "Width: "] -in $grid.f1 	-row 0 -column 1 -padx 10	
	scale $grid.f1.scaleW -orient horizontal -length 150 -from 0 -to 100 -showvalue 0 -command {gridpointtest} -variable VsLab::W -resolution 0.01
    	grid $grid.f1.scaleW -in $grid.f1 -row 0 -column 2 -sticky ew
	grid [ttk::label $grid.f1.lbDimWT -width 5 -textvariable VsLab::W] -in $grid.f1 -row 0 -column 3 -padx 5
	
	grid [ttk::label $grid.f1.lbDimH -text "Height: "] -in $grid.f1 	-row 1 -column 1  -padx 10	
	scale $grid.f1.scaleH -orient horizontal -length 150 -from 0 -to 100 -showvalue 0 -command {gridpointtest} -variable VsLab::H -resolution 0.01
    	grid $grid.f1.scaleH -in $grid.f1 -row 1 -column 2 -sticky ew
	grid [ttk::label $grid.f1.lbDimHT -width 5 -textvariable VsLab::H] -in $grid.f1 -row 1 -column 3 -padx 5
	
	grid [ttk::label $grid.f1.lbDimD -text "Depth: "] -in $grid.f1 	-row 2 -column 1  -padx 10	
	scale $grid.f1.scaleD -orient horizontal -length 150 -from 0 -to 100 -showvalue 0 -command {gridpointtest} -variable VsLab::D -resolution 0.01
    	grid $grid.f1.scaleD -in $grid.f1 -row 2 -column 2 -sticky ew
	grid [ttk::label $grid.f1.lbDimDT -width 5 -textvariable VsLab::D] -in $grid.f1 -row 2 -column 3 -padx 5 -pady 5
	
		
	## Box Center
	grid [ttk::label $grid.f1.lbCent -text "Box Center: "] -in $grid.f1 -row 3 -column 0  -padx 10 -pady 10 -sticky w

	grid [ttk::label $grid.f1.lbX -text "X: "] -in $grid.f1 	-row 3 -column 1	-padx 10
	scale $grid.f1.scaleX -orient horizontal -length 150 -from 0 -to 100 -showvalue 0 -command {box_draw yellow} -variable VsLab::X -resolution 0.01
    	grid $grid.f1.scaleX -in $grid.f1 -row 3 -column 2 -sticky ew
	grid [ttk::label $grid.f1.lbDimXT -width 5 -textvariable VsLab::X] -in $grid.f1 -row 3 -column 3 -padx 5
	
	
	grid [ttk::label $grid.f1.lbY -text "Y: "] -in $grid.f1 	-row 4 -column 1	 -padx 10
	scale $grid.f1.scaleY -orient horizontal -length 150 -from 0 -to 100 -showvalue 0 -command {box_draw yellow} -variable VsLab::Y -resolution 0.01
    	grid $grid.f1.scaleY -in $grid.f1 -row 4 -column 2 -sticky ew
	grid [ttk::label $grid.f1.lbDimYT -width 5 -textvariable VsLab::Y] -in $grid.f1 -row 4 -column 3 -padx 5

	
	grid [ttk::label $grid.f1.lbZ -text "Z: "] -in $grid.f1 	-row 5 -column 1	 -padx 10
	scale $grid.f1.scaleZ -orient horizontal -length 150 -from 0 -to 100 -showvalue 0 -command {box_draw yellow} -variable VsLab::Z -resolution 0.01
    	grid $grid.f1.scaleZ -in $grid.f1 -row 5 -column 2 -sticky ew
	grid [ttk::label $grid.f1.lbDimZT -width 5 -textvariable VsLab::Z] -in $grid.f1 -row 5 -column 3 -padx 5 -pady 5

	
	
	grid [ttk::label $grid.f1.lbSel4 -text "Points Spacing : "] -in $grid.f1 -row 6 -column 0 -padx 10 -pady 20 -sticky w
	grid [spinbox $grid.f1.sp0  -width 5  -from 0 -to 1 -validate all -increment 0.005 -state readonly  -textvariable VsLab::grid_spacing -command {set VsLab::grid_spacing [$VsLab::topGui.nb1.f2.nb2.f3.f1.sp0 get];gridpointvalue $VsLab::grid_spacing} ] -in $grid.f1 -row 6 -column 1		
	$grid.f1.sp0 set $VsLab::grid_spacing
	
	

	
	## Frame 1,1
	
	grid [ttk::frame $grid.f1.f1] -in $grid.f1 -row 7 -column 0 -columnspan 4 -sticky news -pady 5 -padx 10
	
		grid [ttk::label $grid.f1.f1.lbCPt -text "Number of grid points at X, Y and Z: "] -in $grid.f1.f1 -row 0 -column 0	-sticky w
		grid [ttk::label $grid.f1.f1.lbCP1 -text "(0,0,0)"] -in $grid.f1.f1 -row 0 -column 1	
	
	
########## Frame 2

	## LabelFrame
	grid [ttk::frame $grid.f2] -row 1 -column 0 -sticky news -pady 10 -padx 10 
		
	grid [ttk::label $grid.f2.lbSel5 -text "Toggle line on/off : "] -in $grid.f2 -row 0 -column 0
    	grid [ttk::checkbutton $grid.f2.chk -variable VsLab::boxLine  -command {box_draw yellow lixo}] -in $grid.f2 -row 0 -column 1

	
	grid [ttk::button $grid.f2.bAS -text "Highlight ActiveSite" -command {VsLab::buildGuiSasa .sasa} ] -in $grid.f2 -row 0 -column 2 -sticky e -padx 20
	
	
########## Frame 3
 	grid [ttk::frame $grid.f3 ] -row 2 -column 0  -pady 10 -sticky ew -pady 10

    		## Label
    		grid [ttk::label $grid.f3.lb1 -text "Sample Input File :" ] -in $grid.f3 -row 0 -column 0 -padx 10

    		## entry
    		grid [ttk::entry $grid.f3.ent1  ] -in $grid.f3 -row 0 -column 1 -padx 5 -sticky ew

  		## button
    		grid [ttk::button $grid.f3.bt1 -text "Open" -width 5 -command {openGridFile}] -in $grid.f3 -row 0 -column 2 -padx 10

	
########## Configure weights	
	grid columnconfigure  $grid     	0 -weight 1
	grid columnconfigure  $grid.f1     	2 -weight 1
	grid columnconfigure  $grid.f3     	1 -weight 1


	#default
}


proc gridpointtest {value} {
	
	## change the grid points values taking in account the equation
	 # size=spacing*gridpoints
	 #
	set grid $VsLab::topGui.nb1.f2.nb2.f3
	set gridpointW [expr ( [$grid.f1.scaleW get]/ [$grid.f1.sp0 get]) ]
	set gridpointH [expr ( [$grid.f1.scaleH get]/ [$grid.f1.sp0 get]) ]
	set gridpointD [expr ( [$grid.f1.scaleD get]/ [$grid.f1.sp0 get]) ]
		
	if {$gridpointW>=126 } {$grid.f1.scaleW set [expr 126*[$grid.f1.sp0 get]]; set $VsLab::W [expr $gridpointW*[$grid.f1.sp0 get]]}
	if {$gridpointH>=126 } {$grid.f1.scaleH set [expr 126*[$grid.f1.sp0 get]]; set $VsLab::H [expr $gridpointH*[$grid.f1.sp0 get]]}
	if {$gridpointD>=126 } {$grid.f1.scaleD set [expr 126*[$grid.f1.sp0 get]]; set $VsLab::D [expr $gridpointD*[$grid.f1.sp0 get]]}

	$grid.f1.f1.lbCP1 configure -text "([format %2.0f $gridpointW], [format %2.0f $gridpointH], [format %2.0f $gridpointD])"
	box_update_center; box_draw yellow 0	
}

proc gridpointvalue {grid_spacing} {
	set grid $VsLab::topGui.nb1.f2.nb2.f3
				
	set gridpointW [expr ( [$grid.f1.scaleW get]/ [$grid.f1.sp0 get]) ]
	set gridpointH [expr ( [$grid.f1.scaleH get]/ [$grid.f1.sp0 get]) ]
	set gridpointD [expr ( [$grid.f1.scaleD get]/ [$grid.f1.sp0 get]) ]
		
	if {$gridpointW>=126 } {$grid.f1.sp0 set [format %5.3f [expr [$grid.f1.scaleW get]*1/126]];return  }
	if {$gridpointH>=126 } {$grid.f1.sp0 set [format %5.3f [expr [$grid.f1.scaleH get]*1/126]];return  }
	if {$gridpointD>=126 } {$grid.f1.sp0 set [format %5.3f [expr [$grid.f1.scaleD get]*1/126]];return  }
		
	$grid.f1.f1.lbCP1 configure -text "([format %2.0f $gridpointW], [format %2.0f $gridpointH], [format %2.0f $gridpointD])"
	box_update_center; box_draw yellow 0
}


proc default {option} {
	set input .vslab.nb1.f2.nb2.f1
	set topLayer [molinfo top]
	
	
	## See if a protein exists as toplevel
	

	set frame $VsLab::topGui.nb1.f1
	
	if { $topLayer!= -1 &&  [$frame.fProt.eProt get]== ""   } {

		## put the name of the topmolecule
		$input.f1.lb configure -text [molinfo top get name] 
		
		## turn selected molecule top
		mol top $topLayer
		## retrieve the dimensions of the molecule	
    		set selection [atomselect $topLayer all] 
		set VsLab::sizemol [box_molecule_size]
		 
		## Putting scales values in the maximum
		set VsLab::W [expr (( [lindex  [lindex $VsLab::sizemol 1] 0] - [lindex  [lindex $VsLab::sizemol 0] 0] ))]
		set VsLab::H [expr (( [lindex  [lindex $VsLab::sizemol 1] 1] - [lindex  [lindex $VsLab::sizemol 0] 1] ))]
		set VsLab::D [expr (( [lindex  [lindex $VsLab::sizemol 1] 2] - [lindex  [lindex $VsLab::sizemol 0] 2] ))]

		set VsLab::X [expr [lindex  [lindex $VsLab::sizemol 0] 0] + ( $VsLab::W /2)]
		set VsLab::Y [expr [lindex  [lindex $VsLab::sizemol 0] 1] + ( $VsLab::H /2)]
		set VsLab::Z [expr [lindex  [lindex $VsLab::sizemol 0] 2] + ( $VsLab::D /2)]
		
		## Update box dimensions
		box_update_dimension	
		
		## Update box center
		box_update_center

		## scale and grid points
		#gridpointtest 0; gridpointvalue $VsLab::grid_spacing
		
		## drawbox
		box_draw yellow lixo 
		
	}
	## drawbox
		box_draw yellow lixo 
		
	update
}


proc openGridFile {} {
	set grid .vslab.nb1.f2.nb2.f3
        set types {{{"Coordinate Files"}    {*.gpf}}
                    {"All files"             *     }}
        set VsLab::gridSample [tk_getOpenFile -filetypes $types ]
        set VsLab::gridSampleName [file tail $VsLab::gridSample]
	$grid.f3.ent1 delete 0 end
        $grid.f3.ent1 insert end $VsLab::gridSampleName
}


proc box_molecule_size {} {
	
	set input .vslab.nb1.f2.nb2.f1
	
	set topLayer [molinfo top]
	
	set selection [atomselect $topLayer "all and not atomicnumber 1"]
	set sx [$selection get x]; set sy [$selection get y]; set sz [$selection get z]
	set minx [lindex $sx 0]; set miny [lindex $sy 0]; set minz [lindex $sz 0]
	set maxx $minx; set maxy $miny; set maxz $minz
	
	
	foreach x $sx y $sy z $sz {
		if {$x < $minx} {set minx [format %4.1f $x]} else {if {$x > $maxx} {set maxx [format %4.1f $x]}}
		if {$y < $miny} {set miny [format %4.1f $y]} else {if {$y > $maxy} {set maxy [format %4.1f $y]}}
		if {$z < $minz} {set minz [format %4.1f $z]} else {if {$z > $maxz} {set maxz [format %4.1f $z]}}
	}
	## increase the radius by 5 angstroms to see all asa
	#set val 5
	set val 0
	return [list [list [expr $minx-$val] [expr $miny-$val] [expr $minz-$val]] [list [expr $maxx+$val] [expr $maxy +$val] [expr $maxz+$val]]]
}

proc box_update_center {} {
	set grid .vslab.nb1.f2.nb2.f3
	
	# Update the values of the box center
	$grid.f1.scaleX configure  -from [expr [lindex  [lindex $VsLab::sizemol 0] 0] + $VsLab::W/2]
	$grid.f1.scaleX configure  -to   [expr [lindex  [lindex $VsLab::sizemol 1] 0] - $VsLab::W/2]
	$grid.f1.scaleY configure  -from [expr [lindex  [lindex $VsLab::sizemol 0] 1] + $VsLab::H/2]
	$grid.f1.scaleY configure  -to   [expr [lindex  [lindex $VsLab::sizemol 1] 1] - $VsLab::H/2]
	$grid.f1.scaleZ configure  -from [expr [lindex  [lindex $VsLab::sizemol 0] 2] + $VsLab::D/2]
	$grid.f1.scaleZ configure  -to   [expr [lindex  [lindex $VsLab::sizemol 1] 2] - $VsLab::D/2]	

}

proc box_update_dimension {} {

	set grid .vslab.nb1.f2.nb2.f3
	variable VsLab::sizemol
	
	# Update the values of the box dimension
	$grid.f1.scaleW configure  -from 0
	$grid.f1.scaleW configure  -to   [expr ((([lindex  [lindex $VsLab::sizemol 1] 0]- [lindex  [lindex $VsLab::sizemol 0] 0])))]
	$grid.f1.scaleH configure  -from 0
	$grid.f1.scaleH configure  -to   [expr ((([lindex  [lindex $VsLab::sizemol 1] 1]- [lindex  [lindex $VsLab::sizemol 0] 1])))]
	$grid.f1.scaleD configure  -from 0
	$grid.f1.scaleD configure  -to   [expr ((([lindex  [lindex $VsLab::sizemol 1] 2]- [lindex  [lindex $VsLab::sizemol 0] 2])))]	
}

proc box_draw {color lixo} {
# Draw the box around the molecule 	
# @ color - color of the box
# @ boxvariance - the box will be a littel bigger taking in account this variable
# @ lixo : as scales mandam o valor no fim

	# Global variables
	set grid  .vslab.nb1.f2.nb2.f3
	set input .vslab.nb1.f2.nb2.f1
	
	variable VsLab::boxLine
#	variable VsLab::grid_spacing

	global boxLayer

	## retrieve the index of the combobox
	set topLayer [molinfo top]
	if {$topLayer != -1} {
		
		set boxVariance 1; set nameLayer ""

		# Create or see if exists the layer for the box
		foreach x [molinfo list] {set nameLayer [linsert $nameLayer end [molinfo $x get name]]}
	
		if {[lsearch $nameLayer "Box"]==-1} {
			# save orientation and zoom parameters
	 		   set viewpoints [molinfo $topLayer get {center_matrix rotate_matrix scale_matrix global_matrix}]
	
			# Creates a new layer for the drawing
			mol load graphics "Box"; set boxLayer [molinfo top]

			# restore orientation and zoom of the new layer
    			molinfo $boxLayer set {center_matrix rotate_matrix scale_matrix global_matrix} $viewpoints
		} else {set boxLayer [molinfo index [lsearch $nameLayer "Box"]]}

	
		# Delete all graphics
		graphics $boxLayer delete all
		set width 2
		if {$VsLab::boxLine!=0} {

			# Obtain center of the molecule
			set center "[$grid.f1.scaleX get] [$grid.f1.scaleY get] [$grid.f1.scaleZ get]"
		
			# Obtain dimension of the molecule
			set boxW [expr [$grid.f1.scaleW get]* $boxVariance /2]
			set boxH [expr [$grid.f1.scaleH get]* $boxVariance /2]
			set boxD [expr [$grid.f1.scaleD get]* $boxVariance /2]	

			graphics $boxLayer color $color

			# Draw the Box
			graphics $boxLayer line "[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]+($boxD)]" \
					     	"[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]+($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]+($boxD)]" \
					     	"[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]+($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]-($boxD)]" \
					     	"[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]+($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]-($boxD)]" \
					     	"[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]+($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]-($boxD)]" \
					     	"[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]-($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]+($boxD)]" \
					     	"[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]+($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]+($boxD)]" \
					     	"[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]-($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]+($boxD)]" \
					     	"[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]-($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]-($boxD)]" \
					     	"[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]-($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]+($boxD)]" \
					     	"[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]+($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]+($boxH)] [expr [lindex $center 2]-($boxD)]" \
					     	"[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]-($boxD)]" width $width
			graphics $boxLayer line "[expr [lindex $center 0]-($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]-($boxD)]" \
					     	"[expr [lindex $center 0]+($boxW)] [expr [lindex $center 1]-($boxH)] [expr [lindex $center 2]-($boxD)]" width $width
		}

	mol top $topLayer
		update
	}
	
}



