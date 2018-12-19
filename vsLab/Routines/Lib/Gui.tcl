package provide GuiVsLab 1.0

proc VsLab::startGui {} {
#  
#  name: Start Gui
	
	## Images

set logo {
R0lGODlheAAeAMZsAAAAAAICAgQEBA8PDhkZGRsbGyAgHyIiIRMoIhcyJyssKys+Mjw+Oz5APD9B
PURKQyRaN0lOSExSSlNaUFRbUSdxOlhhVDxvQFxnWEFyQlxoWUl3Rkh4RTV/PEx3SGNyXUN/QmNz
XUWAQzOMOmh5Xz6JPjKOOjuNPWl8YGqAYGuBYGyDYG2EYG2HYDifOG6LYG+MYG6OXm6PXm6RXW6S
XG2TW26TW26UW22VWm2WWWyXWG2XWWuYVjqqNT2pN2yYVzyqNT+pNzyqNj2qNkCpOGmaVEanPEGp
OGqaVESoOkGpOWibUkWoOkOpOWecUkeoO0SpOkqnPmadUEunPlSkQk6mQFSkQ2edUVKlQWWeT1Wk
Q0qoPFijRVCmQE2nP16hSWGgS1akREuoPVyiR2SfTlqjRVekRGKgTGChSmafTmSgTWKhS///////
/////////////////////////////////////////////////////////////////////////yH+
GkNyZWF0ZWQgd2l0aCBHSU1QIG9uIGEgTWFjACH5BAEKAH8ALAAAAAB4AB4AAAf+gH8Ag4SFhoeI
iYqFAY2Oj5CRkpOPi5aXmIQNFJydnp4NmaKjpKWmhjFNU6usratNMaeys7SlMz09OxMTGGe4v7gz
tcPExYO3O4UGvsA9woQHLVi4VCiEFGtbPUpjIYQkPWor0z05ByFh206hg1VNKE64WLHGw7cMhhjN
ztBjQapGehyxFiOIQCNQBNYYhOOXkIBHkvQAYuRIjyYHBgXEdWRKDx9q6tW6dWjCvmcACjZBE0JD
kR4hKBC5GDNEkx5BNABoiGuFBom4eFAY0+SdRlxlNNi8SEHkrFsG8p0kRC4CNAA3ehjxNihEwBs7
teoE0EKrNQAaArY4GoYQCo/+a52eurXC0JKpg3AlOfQFV8ZBDWZ+CWukKVmthimoPTp4kOIeZOTO
5ScAAIMd+/jl7eGFbw8i7ABQ8Bi5YeFBZU+LXgwgYOPVPWRIVmQ10T0AKzL/Qjnms+EGKyLA0Fp3
EA8jRKyZNpw6MeuAUGrzaJJ8tqEDNnD2ABMaQIQ0UhxIKOBRt2YAKBL2cKKmx5AWDXAxKVOjjMco
GZejRuz4+S8nZQSEkXWFgNGMF39pgMsSgwxghnnnAVCEQRwpoVMISszEkRe10cDUfkckZlFcG1n0
mRKGESgahcCwMIgYCxJiAYQoOdYCGTegENoBKMhABgxcDRJBC2cBEM0Kf+H+1kJtAYWBwg9IoJCk
ii9A+AuDFBwwAI2FaPBFEYt0d4oPPVihYiJVWtnDFRFAkMEBXBLSEBQpFhJfObTgosSZiFDA4i8u
AqBhBxuIkAAIcTLE3yEUWCQFLQa1xechBgKDIGpA9HACAhxcgIAJZyxxVzM16ocICkvS4tqkh2D3
C3eFpKDEFZ6W4IEChBiA2W6FmKaDF9usURsAYTShwjXZbNNNIdGQUw1bTijRAxZFAtCAE1FsI0WK
OfQQQw3ZNtHCAStkG0UMU1oiZiEzuFDBAgQcckswvV7Uw0MzEWFYQo0VdFBCRyxkpD8ACWTNRj1A
4REUcSn40RMBETGWFr/+dJSwREFEHNJIPYzwACIGlFfqLytQcFwPja0qE00ULJVTSv+w5BJMrX3U
DQrSNmHkTU3EhAIuOgNAcQ9JhIAzyRokRMSwssyryKgjGzEWAOoxhpVWQXrVA1hVXVVzGH/11YNo
R6zUwtkUH2HV0GHjUlsMiz6Fy9P0yhl3X2rXPJjYSQaGMgB6IbLqIGIfllmIQs9NuOKHqSb32IlA
Xa/jfOsNQF+gXUMa4JwJ/vfiY6vAmRRnl17c0IQUvp/jTePyAci82g3FMxEAbfVwRhQHwHHV9aYv
YMFZDrpoCWWRCOrDr17nZD2YEZUhu0bIkw9eTJdEECT+fed89d2XUXqZuLDn3lqDX644FQl3EUML
a/QwxiDImw9548ubMm/zExDCwKh1D+LhZ79oghP+cpM1dCVDFeMQISZUMQsBoICEaB/kIuAF9eDC
B8YDABcYp7rDII4W98PFFJbwIFIVYkgxacEXYFAnVA2LRz4CEqNulCN2uJAQQ6pWCG6EhBZoIEE+
xCGRNNECJNViE59IIifWxaomOvGJ9QgEADs=}

	
	## Check if the window exists
	if {[winfo exists $VsLab::topGui]} {wm deiconify $VsLab::topGui ;return}
	toplevel $VsLab::topGui
	
	## Title of the windows
	wm title $VsLab::topGui " Virtual Screening Lab $VsLab::version" ;# titulo da pagina
	#wm geometry $VsLab::topGui 400x59 0
	
	
########## Frame 1
	grid [frame $VsLab::topGui.f1 -bg black] -row 0 -column 0 -sticky news
	image create photo VsLab::img1 -data $logo
	grid [label $VsLab::topGui.f1.logo -bg black -image VsLab::img1 ] -row 0 -column 0 -sticky e
	
	
	
	
########## Notebook
	grid [ttk::notebook $VsLab::topGui.nb1] -row 1 -column 0 -sticky news
	ttk::frame $VsLab::topGui.nb1.f1
	ttk::frame $VsLab::topGui.nb1.f2
	ttk::frame $VsLab::topGui.nb1.f3
	
	$VsLab::topGui.nb1 add $VsLab::topGui.nb1.f1 -text "Output" -sticky news
	$VsLab::topGui.nb1 add $VsLab::topGui.nb1.f2 -text "Input"  -sticky news
	$VsLab::topGui.nb1 add $VsLab::topGui.nb1.f3 -text "About"  -sticky news


	
		## Build Output
		set frame $VsLab::topGui.nb1.f1
		VsLab::buildOutputFrame $frame
	
		## Build Input
		set frame $VsLab::topGui.nb1.f2
		VsLab::buildInputFrame $frame
	
	
		## Build About
		set frame $VsLab::topGui.nb1.f3
		VsLab::About $frame
	
########## Exit button
	grid [ttk::frame $VsLab::topGui.f2] -row 2 -column 0 -sticky news
	#grid [ttk::progressbar $VsLab::topGui.f2.pb -maximum $::VsLab::progressMax] -in $VsLab::topGui.f2 -row 0 -column 0 -padx 10 -pady 5 -sticky ew
	grid [ttk::button $VsLab::topGui.f2.exit  -text "Reset" -command {VsLab::reset}] -in $VsLab::topGui.f2  -row 0 -column 1 -sticky e
	grid [ttk::button $VsLab::topGui.f2.reset -text "Exit" -command {wm withdraw $VsLab::topGui}] -in $VsLab::topGui.f2  -padx 15 -pady 5 -row 0 -column 2  -sticky e

########## Last Frame
	grid [ttk::frame $VsLab::topGui.f3 -relief sunken ] -row 3 -column 0 -sticky news
	grid [ttk::label $VsLab::topGui.f3.label -relief groove -width 30  -textvariable VsLab::progressMessage] -in $VsLab::topGui.f3  -row 0 -column 0 -sticky w
	grid [ttk::progressbar $VsLab::topGui.f3.pb -maximum $::VsLab::progressMax] -in $VsLab::topGui.f3 -row 0 -column 1 -sticky ews


########## Configure weights	
	
	grid columnconfigure $VsLab::topGui     0 -weight 1
	grid rowconfigure $VsLab::topGui        1 -weight 1
	
	grid columnconfigure $VsLab::topGui.f1  0 -weight 1
	grid columnconfigure $VsLab::topGui.f2  0 -weight 1

	grid rowconfigure $VsLab::topGui.f2        0 -weight 1

	grid columnconfigure $VsLab::topGui.f3  1 -weight 1

}

proc VsLab::reset {} {
	

	
	set frame $VsLab::topGui.nb1.f1
	set input $VsLab::topGui.nb1.f2.nb2.f1
	set dock  $VsLab::topGui.nb1.f2.nb2.f2
	set grid  $VsLab::topGui.nb1.f2.nb2.f3
	
	set  $VsLab::database	""
	
	$frame.fProt.eProt delete 0 end
	# save inputFile
	$VsLab::topGui.nb1.f2.fb.bSave configure -state normal

  	# Inactivate Run
        $VsLab::topGui.nb1.f2.fb.bRun configure -state normal
	
	# clean table of results
	$frame.ftb.tb delete 0 end
	
	# frame files
	$input.f2.f22.bt1 configure -state normal
	$input.f2.f22.bt2 configure -state normal
	$input.f2.f22.bt3 configure -state normal
	
	# frame autodock
	$dock.f1.cb1 configure -state normal
	$dock.f1.sb1 configure -state normal
	$dock.f2.lf1.ent1 configure -state normal
	$dock.f2.lf1.ent2 configure -state normal
	$dock.f2.lf1.ent3 configure -state normal
	$dock.f3.ent1 configure -state normal
	$dock.f3.bt1 configure -state normal
		

	# frame autogrid
	$grid.f1.scaleW configure -state normal;$grid.f1.scaleH configure -state normal;$grid.f1.scaleD configure -state normal
	$grid.f1.scaleX configure -state normal;$grid.f1.scaleY configure -state normal;$grid.f1.scaleZ configure -state normal
	$grid.f1.sp0 configure -state normal
	$grid.f2.bAS configure -state normal
	$grid.f3.ent1 configure -state normal
	$grid.f3.bt1 configure -state normal

        $grid.f1.f0.entSel5 configure -state normal
        $grid.f1.f0.btSel5 configure -state normal



	
	## change the toplevel molecules
	$input.f1.lb configure -text [molinfo top get name]

	## update box values
	#default %W

	
}

proc VsLab::buildOutputFrame {frame} {
	
########## Protein

	## Frame
	grid [ttk::frame $frame.fProt] -in $frame -row 0 -column 0  -padx 10 -sticky news -pady 10
	
		## Label
		grid [ttk::label $frame.fProt.lProt -text "File :" ] -in $frame.fProt -row 0 -column 0
	
		## Entry
		grid [entry $frame.fProt.eProt  ] -in $frame.fProt -row 0 -column 1 -sticky we -padx 10
	
		## Button Load
		grid [ttk::button $frame.fProt.bProt -text "Load " -width 6 -command {VsLab::OpenFile}] -in $frame.fProt -row 0 -column 2 -padx 10
	
	
	
########## Ligand List
	
	## Label
	grid [ttk::label $frame.lLig -text "AutoDock Solutions :" ] -in $frame -row 1 -column 0 -sticky w -padx 10 -pady 10
	
	## Frame
	grid [ttk::frame $frame.ftb ] -in $frame -row 2 -column 0  -padx 10 -sticky news
	
	
	## TableList
		
	option add *Tablelist.activeStyle       frame
	option add *Tablelist.background        gray98
	option add *Tablelist.stripeBackground  #e0e8f0
	#option add *Tablelist.setGrid           yes
	option add *Tablelist.movableColumns    yes
	option add *Tablelist.labelCommand      tablelist::sortByColumn
		
		
    	tablelist::tablelist $frame.ftb.tb \
		-columns {	0 "Ligand"	left
				0 "Cluster"	center	
				0 "Score"	center
                          	0 "Ki (M)"      	center                
				0 "Intermolecular Energy"	center
				0 "Total Internal Energy"       center
				0 "Torsional Free Energy"       center
				0 "Unbound System Energy"       center} \
                -yscrollcommand [list $frame.ftb.scr1 set] -xscrollcommand [list $frame.ftb.scr2 set] \
                -showseparators 0 -labelrelief groove  -labelbd 1 -selectbackground blue -selectforeground white\
                -foreground black -background white -selectmode extended
					

	$frame.ftb.tb columnconfigure 0 -sortmode dictionary 
        $frame.ftb.tb columnconfigure 1 -sortmode real		
	$frame.ftb.tb columnconfigure 2 -sortmode real  	
        $frame.ftb.tb columnconfigure 3 -sortmode dictionary 
#	$frame.ftb.tb columnconfigure 1 -bg blue


                
       	
	grid $frame.ftb.tb -in $frame.ftb -row 0 -column 0 -sticky news
		

	## Scrool_Bar V
      	scrollbar $frame.ftb.scr1 -orient vertical -command [list $frame.ftb.tb  yview]
      	grid $frame.ftb.scr1 -in $frame.ftb -row 0 -column 1  -sticky ns


	## Scrool_Bar H
      	scrollbar $frame.ftb.scr2 -orient horizontal -command [list $frame.ftb.tb xview]
      	grid $frame.ftb.scr2 -in $frame.ftb -row 1 -column 0 -sticky ew

		
	
########## Button Options
	
	## Frame
	grid [ttk::frame $frame.fb] -in $frame -row 3 -column 0 -sticky ew -padx 10 -pady 10
	
	## button see output
	grid [ttk::button $frame.fb.bSee -text "See Solution" -command {VsLab::ShowSolution see} ] -in $frame.fb -row 1 -column 0 -sticky w 

	## button highlight AS
	grid [ttk::button $frame.fb.bAS -text "Highlight ActiveSite" -command {VsLab::buildGuiSasa .sasa}] -in $frame.fb -row 1 -column 1 -sticky w 	

	## button Export
        grid [ttk::button $frame.fb.bAS1 -text "Generate Complex" -command {VsLab::ShowSolution export}] -in $frame.fb -row 1 -column 2 -sticky w


	
	
	
########## Configure weights	
	
	grid columnconfigure  $frame.ftb 0 -weight 1
        grid columnconfigure  $frame     0 -weight 1
	
	grid rowconfigure     $frame  	 2 -weight 1
	grid rowconfigure     $frame.ftb 0 -weight 1
 	
 	grid columnconfigure  $frame.fProt.eProt   1 -weight 1
	grid columnconfigure  $frame.fProt  	   1 -weight 1
	
	
########## Bindings
}



proc VsLab::buildInputFrame {frame} {
	
	## Protein List
	set ProteinList ""
	foreach x [molinfo list] {set ProteinList [linsert $ProteinList end [molinfo $x get name]]}
	
	
########## Label	
#	grid [ttk::label $frame.lInput -text "Input Files required to run VsLab"] -in $frame -row 0 -column 0 -sticky ew -pady 10
	
########## Notebook Input
	
	grid [ttk::notebook $frame.nb2] -in $frame -row 0 -column 0  -pady 10 -sticky news
	ttk::frame $frame.nb2.f1
	ttk::frame $frame.nb2.f2
	ttk::frame $frame.nb2.f3
	
	$frame.nb2 add $frame.nb2.f1 -text "Files" -sticky news
	$frame.nb2 add $frame.nb2.f2 -text "AutoDock"  -sticky news
	$frame.nb2 add $frame.nb2.f3 -text "AutoGrid"  -sticky news
	
	
	## Build Files
	set frameInp $frame.nb2.f1
	VsLab::buildFilesFrame $frameInp $ProteinList
	
	## Build AutoDock
	set frameInp $frame.nb2.f2
	VsLab::buildAutoDockFrame $frameInp
	
	## Build AutoGrid
	set frameInp $frame.nb2.f3
	VsLab::buildAutoGridFrame $frameInp	
	
	
	
########## Button Options
	
	## Frame
	grid [ttk::frame $frame.fb] -in $frame  -column 0 -row 2 -padx 5 -pady 10
	
	## button see output
	grid [ttk::button $frame.fb.bSave -text "Save Input File" -command {VsLab::create_inputFile}] -in $frame.fb -row 0 -column 0 -sticky e

	## button see output
	grid [ttk::button $frame.fb.bRun -text "Run" -command {VsLab::Run $::VsLab::database} ] -in $frame.fb -row 0 -column 1 -sticky e -padx 10

	## button highlight AS
	#grid [ttk::button $frame.fb.bAS -text "Highlight ActiveSite" ] -in $frame.fb -row 0 -column 2 -sticky e	

	
########## Configure weights	

	grid rowconfigure     $frame     0 -weight 1
        grid columnconfigure  $frame     0 -weight 1

########## Bindings
	bind .vslab.nb1  <<NotebookTabChanged>> {
		
		if { [molinfo top] == -1  && [%W tab [%W select] -text]=="Input"}  { tk_messageBox -message "Load Some Protein in the vmd main window first..." -type ok -title "Warning"}
	}
	
######### Default View
	default %W 
	gridpointtest 0; gridpointvalue $VsLab::grid_spacing

}



proc VsLab::OpenFile {} {

	set frame $VsLab::topGui.nb1.f1
	set input $VsLab::topGui.nb1.f2.nb2.f1
	set dock  $VsLab::topGui.nb1.f2.nb2.f2
	set grid  $VsLab::topGui.nb1.f2.nb2.f3
	
########## Select File
	set types { {{database Files}   {*.vsLab}   }
                  {{All Files}    *       } }

	set VsLab::database [tk_getOpenFile -filetypes $types]
	  
	if {$VsLab::database!= ""} {
		
		## set path
		set Path [file dirname $VsLab::database]
		## clean table and listbox
		$frame.ftb.tb delete 0 end
		$input.f2.f21.lb1 delete 0 end

      		## Open database and fill the table with the results
		sqlite3 opendb $VsLab::database
		
		## Search for the input table
		 set VsLab::arrayLigandPath ""
		if {[opendb eval {select count(*) from sqlite_master where name="input"}]==1} {

			opendb eval "SELECT * FROM input" {
				
				
				## Load the protein File

				set VsLab::proteinPath $Path/$Protein
				mol addfile $VsLab::proteinPath type pdb
				
				$input.f2.f21.lb1 insert end [file tail $Ligand]
				set VsLab::arrayLigandPath [linsert $VsLab::arrayLigandPath end "$Path/$Ligand"]

				## Search for the table with the ligands
				set LigandName "T_[file rootname [file tail $Ligand]]"

				## change ligName

				regsub -all "\\-" $LigandName "_" LigandName

				if {[opendb eval {select count(*) from sqlite_master where name=$LigandName}]==1} {
					opendb eval "SELECT * FROM $LigandName" {$frame.ftb.tb insert end "[file rootname $PDB] $Cluster $Energy $ki $E1 $E2 $E3 $E4"}
					
				}
			}
		}


		opendb close 

		## get protein values
		set topLayer [molinfo top]
		set VsLab::sizemol [box_molecule_size [atomselect $topLayer all]]
		box_update_dimension
		box_update_center
		
		## Create global variables
		set VsLab::grid_spacing		$grid_spacing
		
		set VsLab::X 			[lindex $grid_center 0]
		set VsLab::Y 			[lindex $grid_center 1]
		set VsLab::Z 			[lindex $grid_center 2]
		
		set VsLab::W 			[expr [lindex $grid_size 0] * $grid_spacing]
		set VsLab::H 			[expr [lindex $grid_size 1] * $grid_spacing]
		set VsLab::D 			[expr [lindex $grid_size 2] * $grid_spacing]
		set VsLab::grid_center  	$grid_center
		set VsLab::grid_selection       "all"
		set VsLab::grid_selection	$grid_selection
		
	    	set VsLab::gridSample		$gridSample
       	 	set VsLab::ga_set      	 	$ga_set
		
			set dockList "GA LGA"
			if {$ga_set=="GA"}  {set sel [lindex $dockList 0]} else  {set sel [lindex $dockList 1]}
			$dock.f1.cb1 set $sel
		
		
		#default 0
		
        	set VsLab::ga_run    		$ga_run
        	set VsLab::ga_num_evals		$ga_num_evals
        	set VsLab::ga_num_generations	$ga_num_generations
        	set VsLab::ga_pop_size		$ga_pop_size
        	set VsLab::dockSample		$dockSample


                # set charge ligands button

		if {$lCharge==0} {set VsLab::lCharge0 0; set VsLab::lCharge1 0}
		if {$lCharge==1} {set VsLab::lCharge0 1; set VsLab::lCharge1 0}
		if {$lCharge==2} {set VsLab::lCharge0 0; set VsLab::lCharge1 1}
		if {$lCharge==3} {set VsLab::lCharge0 1; set VsLab::lCharge1 1}


		# redraw the box
		box_draw yellow lixo 

		
		# Insert the name of the protein
		$frame.fProt.eProt delete 0 end	
		$frame.fProt.eProt insert 0 [file tail $VsLab::database]	
		$input.f1.lb configure -text [file tail $VsLab::database]
	
		# Inactivate some buttons
	
			# save inputFile
			$VsLab::topGui.nb1.f2.fb.bSave configure -state disabled
		#	$VsLab::topGui.nb1.f3.cb configure -state disabled
		
			# frame files
			$input.f2.f22.bt1 configure -state disabled
			$input.f2.f22.bt2 configure -state disabled
			$input.f2.f22.bt3 configure -state disabled
		
			# frame autodock
			$dock.f1.cb1 configure -state disabled
			$dock.f1.sb1 configure -state disabled
			$dock.f2.lf1.ent1 configure -state disabled
			$dock.f2.lf1.ent2 configure -state disabled
			$dock.f2.lf1.ent3 configure -state disabled
			$dock.f3.ent1 configure -state disabled
			$dock.f3.bt1 configure -state disabled
		

			# frame autogrid
			$grid.f1.scaleW configure -state disabled;$grid.f1.scaleH configure -state disabled;$grid.f1.scaleD configure -state disabled
			$grid.f1.scaleX configure -state disabled;$grid.f1.scaleY configure -state disabled; $grid.f1.scaleZ configure -state disabled
			$grid.f1.sp0 configure -state disabled
			$grid.f2.bAS configure -state disabled
			$grid.f3.ent1 configure -state disabled
			$grid.f3.bt1 configure -state disabled
			$grid.f1.f0.entSel5 configure -state disabled
			$grid.f1.f0.btSel5 configure -state disabled
		
		#.vslab.nb1.f2.nb2.f1.f2.f22.bt3 configure -state readonly
		
	}

	
	
	
}


proc VsLab::ShowSolution {option} {
	
	set topLayer	[molinfo top]
	set topLayerID [molinfo top get id]
	set frame 	$VsLab::topGui.nb1.f1
	set Path [file root $VsLab::database]
	set selection [lindex [$frame.ftb.tb get [$frame.ftb.tb curselection]] 0]
	set selection [$frame.ftb.tb get [$frame.ftb.tb curselection]]
	if {[llength [$frame.ftb.tb curselection]]==1} {set selection "{$selection}"}

	## Just one selection now

	foreach a $selection  {

		# Creates a new layer for the drawing if it does not exists
		set nameLayer ""
		foreach x [molinfo list] {set nameLayer [linsert $nameLayer end [molinfo $x get name]]}


			set searchLigand [lsearch $nameLayer [file tail [lindex $a 0]]]
			if {$searchLigand==-1} {

				## rename molecule
				mol new $Path/[lindex $a 0].pdb type pdb
				mol rename [molinfo top] "[lindex $a 0]"
				update

                	}

		set nameLayer ""; set IDLayer ""
               	foreach x [molinfo list] {set nameLayer [linsert $nameLayer end [molinfo $x get name]]}
		foreach x [molinfo list] {set IDLayer [linsert $IDLayer end [molinfo $x get id]]}

			set searchComplex [lsearch $nameLayer "Complex_P:[file tail [lindex $a 0]]"]
			set searchLigand [lsearch $nameLayer [file tail [lindex $a 0]]]
			if {$searchComplex==-1 && $searchLigand!=-1 && $option=="export" } {

				#qual é o mol id do posição searchligand
			 	TopoTools::mergemols "[lindex $IDLayer $searchLigand] $topLayerID"

				## rename Complex
				mol rename [molinfo top] "Complex_P:[lindex $a 0]"	
				update
			}

	}

        ## update toplayer
        mol top $topLayer
        update


}


proc VsLab::SaveComplex {} {




foreach a $selection  {

     # Creates a new layer for the drawing if it does not exists
	set topLayer    [molinfo top]


	set selection [$frame.ftb.tb get [$frame.ftb.tb curselection]]
        if {[llength [$frame.ftb.tb curselection]]==1} {set selection "{$selection}"}


	set nameLayer ""
	foreach x [molinfo list] {set nameLayer [linsert $nameLayer end [molinfo $x get name]]}

	set search [lsearch $nameLayer [file tail [lindex $a 3]]]
	if {$search==-1} {

            ## rename molecule
               mol new $Path/[lindex $a 8] type pdb
               mol rename [molinfo top] "[lindex $a 8]"
               update

               ## update toplayer
               mol top $topLayer
               update


	} else {


	puts $search

	#TopoTools::mergemols "[mol new $Path/[lindex $a 8] type pdb]  $topLayer


       ## update toplayer
       mol top $topLayer

	}
}

}




##### RUN Application
#	VsLab::VsLab    

