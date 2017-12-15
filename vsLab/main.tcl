package provide VsLab 1.3

###################################################################################################
## VsLab allow to dock one or a group of ligands into a target protein using autodock and VMD    ##
###################################################################################################
##
## version 1.3 L
## Last revision SET 2011 - Nuno Sousa Cerqueira
##
## Faculdade de Ciencias, Universidade do Porto - Portugal
##
## email: nscerque@fc.up.pt
##


namespace eval VsLab:: {
        namespace export vsLab

        #### Read Packages

		## Lib
                package require Gui_AutoDock            1.0
                package require Gui_AutoGrid            1.0
                package require Gui_Sasa                1.0
		package require Gui_About               1.0
                package require Gui_inputFile           1.0
        	package require AutoDock                1.0

                ## Other
		package require sqlite
                package require tablelist


        #### Variables Program

		variable img1 ""
                variable debug                          "YES"
                variable topGui                         ".vslab"
		variable boxLine 			1
                variable arrayLigandPath                ""
                variable arrayligandName                ""
                variable ligandPath                     ""
                variable database                       ""
                variable grid_fileName                  ""
                variable grid_size                      ""
                variable grid_center                    ""
                variable grid_spacing                   0.375
                variable X                              0
                variable Y                              0
                variable Z                              0
                variable W                              0
                variable H                              0
                variable D                              0
                variable gridSample                     "none"
                variable dock_fileName                  ""
                variable ga_set                         "GA"
                variable ga_run                         10
                variable ga_num_evals                   2500000
                variable ga_num_generations             27000
                variable ga_pop_size                    150
                variable dockSample                     "none"
		variable sizemol			"{0 0 0 } {0 0 0}"
		variable database			""
		variable lCharge			0

#		ttk::style configure TNotebook -background green

}


proc VsLab::vslab {} {

	if {[winfo exists $::VsLab::topGui]} {wm deiconify $::VsLab::topGui;  return $::VsLab::topGui}
	#### variable reset
	variable ::VsLab::database	""

	#### startGui
      	VsLab::startGui
	return $::VsLab::topGui
}


proc VsLab::startGui {} {
#
#  name: Start Gui

	## Images

set logo {
R0lGODlhaQAaAMZxAAAAAAICAg8PDhERERcXFxkZGR8gHyAgHyIiIR5FMDw+Oz5APEFBQUBDP0lN
RyRaN0lOSElRRypdOSZfNy9fO1NaUFRbUVtlV1xnWDx0QFxoWVRwTkJ4Q11xVWJwXDmBPWNyXVx2
U2NzXWV1XjuGPTKLO2d5X2h5X1aBTWl8YFqDUHR5cUqLQ2p/YGqAYGuBYGaFWmyDYG2GYG2HYHmC
d3qDeG6LYG+MYG6NX26OXm6QXW6RXW6SXG2TW26TXG6UW22WWWyXWG2XWWuYVjqqNT2pNzqqNmyY
V2qZVTyqNT+pNzyqNj2qNkCpOGmaVEanPEGpOGqaVESoOkGpOWibUkWoOkWoO0OpOWecUkeoO0Sp
OkqnPmadUEioPEunPlSkQk6mQFKlQWWeT1CmQE2nP16hSVOlQmGgS1akRFyiR2SfTl+hSVqjRVek
RGKgTGSgTWKhS////////////////////////////////////////////////////////////yH+
GkNyZWF0ZWQgd2l0aCBHSU1QIG9uIGEgTWFjACwAAAAAaQAaAAAH/oAAgoOEhYaHhCs1NIwMiI+Q
kZKTlIUmZ5iZmmcmgyJXT6FaREAIlaeoqZQ7RF42MaxEsrI7gzNEV7JNTVBpqr/Av6wVgxiztLZE
TxYAC2xEWsyTCHBwC8HYpztuhW7HtYK3y+GyL4IQ0oPM6AgWWtGFFhDZ9IU7VIVU38njCGm4F3Ic
e2PKiZIsRIp0wZWLSIoFb47lqFdvh5cBgxQcIwIOgDg0ZXD1ysGECEhZZQCElHXFDJpQIDWgQfml
CJMZFLNZJCAIg7d95GaNKkXECrgYXq5ACKlUkIVQzNxVESFIDK6clETsmHFt0AIeLQBo3IiM3JMe
JyxcczcOwNNl/iFTOoXqUVYyIlgltVkia8o8ACaIxAggAAfZsnW1pLAgbYGSJ1QBaHgSLa46uiKa
EOkqEG/eRy6KHOtiYYToGIIOHOY4aAgRI1IoE8GCYAuuGCnAECGjkohcAAiUBZmhYRebFDamKAHy
+dGZ1bJiGOhQQB/ZjlaPPTFpYUqSWU0tD0ojWvALzbPQmGp+CAlZLM+IqNiQAMXPjR11EGnCDMEY
IkosgIAMP/iQwnopDPHDDBaYgkAKM8TgwQw6DIHEDFQtoMEMxHUFAAQMLgChCKZYwKEGgzx4oAgc
phNPebKc0YwsJFDAwQMlHNaRONJE1MQ1MShxRX9ANPEdEVBs/iENBGSMguSQHk3BF4BTmAMAHNA0
UdIVYbjG0htOXXGFFOARdEhgWSixxnomXAGDBB9kEIEgCggxy47K9JADG0ooAWZd4+zwGBlOsFEF
EVMggAAZRIQxxhu5xKABFFBcgcUbUwDIzEomkXEFemV4egVVTymBS6hQNIHTIe14OAgPLEzQQCF2
shbUMUqIYQqPwREBxnoxPAFFCpNaEYQgDyIQhix/WXAoF70RQVWvUC6gWS1PEcGGgyyhwkoIhoyF
51kz9EDGLszxmO2qHx4qhDgoEoISIbmEEe0gM/0277qDrOStYIcgxiOyDQHK2HbsQoDQgsq4CMC8
g4xir7+C+Yj3sG9uIdyvXdoAbIjADRN8FY8Q5PInADFY0UQKKUBhBWrApVAyLutZoBm0FPemL8bZ
6gqcLFv824YhIID8BEhlfFpEDwb3pkUaMzih2RUILJBpE07kcMUSHCoBBRg59JALf/dWjLEg+27n
aw9gVMruKogB4IAXiKVg6iypOrErkswsQAYUeJMhTWZ3i4biG3dTmYLZnuk8SNqylITLyZXEQkQb
McACFHAxcMihCB6CCLMgItygxg0kErJADFEc8ZA6M2Dxw+uCbBiZZMQNAuE82fYQAxeoq3LBDsQX
b/wOF7DXHL/KN/+ZBYC/7fz02SDQ+XrUZ698IAA7}


	## Check if the window exists
	if {[winfo exists $VsLab::topGui]} {wm deiconify $VsLab::topGui ;return}
	toplevel $VsLab::topGui

	## Title of the windows
	wm title $VsLab::topGui " Virtual Screening Lab v1.3" ;# titulo da pagina
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
	grid [ttk::button $VsLab::topGui.f2.exit  -text "Reset" -command {VsLab::reset}] -in $VsLab::topGui.f2  -row 0 -column 0 -sticky e
	grid [ttk::button $VsLab::topGui.f2.reset -text "Exit" -command {wm withdraw $VsLab::topGui}] -in $VsLab::topGui.f2  -padx 15 -pady 5 -row 0 -column 1  -sticky e

########## Configure weights

	grid columnconfigure $VsLab::topGui     0 -weight 1
	grid rowconfigure $VsLab::topGui        1 -weight 1

	grid columnconfigure $VsLab::topGui.f1  0 -weight 1
	grid columnconfigure $VsLab::topGui.f2  0 -weight 1


}

proc VsLab::reset {} {



	set frame $VsLab::topGui.nb1.f1
	set input $VsLab::topGui.nb1.f2.nb2.f1
	set dock  $VsLab::topGui.nb1.f2.nb2.f2
	set grid  $VsLab::topGui.nb1.f2.nb2.f3

	set  $VsLab::database	""

	# save inputFile
	$VsLab::topGui.nb1.f2.fb.bSave configure -state normal

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

	## change the toplevel molecules
	$input.f1.lb configure -text [molinfo top get name]

	## update box values
	default %W


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
	grid [ttk::label $frame.lLig -text "Docked Solutions :" ] -in $frame -row 1 -column 0 -sticky w -padx 10 -pady 10

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
				0 "Unbound System Energy"       center
                          	0 "File Name"       	left} \
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
	grid [ttk::button $frame.fb.bSee -text "See Solution" -command {VsLab::ShowSolution} ] -in $frame.fb -row 1 -column 0 -sticky w

	## button highlight AS
	grid [ttk::button $frame.fb.bAS -text "Highlight ActiveSite" -command {VsLab::buildGuiSasa .sasa}] -in $frame.fb -row 1 -column 1 -sticky w



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

	grid [ttk::notebook $frame.nb2] -in $frame -row 1 -column 0  -pady 10 -sticky news
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
	grid rowconfigure     $frame     1 -weight 1
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
				mol addfile $Path/$Protein type pdb

				$input.f2.f21.lb1 insert end [file tail $Ligand]
				set VsLab::arrayLigandPath [linsert $VsLab::arrayLigandPath end "$Path/$Ligand"]

				## Search for the table with the ligands
				set LigandName "T_[file rootname [file tail $Ligand]]"
				if {[opendb eval {select count(*) from sqlite_master where name=$LigandName}]==1} {
					opendb eval "SELECT * FROM $LigandName" {$frame.ftb.tb insert end "[file rootname [file tail $Ligand]] $Cluster $Energy $ki $E1 $E2 $E3 $E4 $PDB "}

				}
			}
		}


		opendb close

		## get protein values
		set VsLab::sizemol [box_molecule_size]
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
                set VsLab::lCharge           $lCharge


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

		#.vslab.nb1.f2.nb2.f1.f2.f22.bt3 configure -state readonly

	}




}


proc VsLab::ShowSolution {} {

	set topLayer	[molinfo top]
	set frame 	$VsLab::topGui.nb1.f1
	set Path [file root $VsLab::database]
	set selection [$frame.ftb.tb get [$frame.ftb.tb curselection]]
	if {[llength [$frame.ftb.tb curselection]]==1} {set selection "{$selection}"}
	foreach a $selection  {

		# Creates a new layer for the drawing if it does not exists

		set nameLayer ""
		foreach x [molinfo list] {set nameLayer [linsert $nameLayer end [molinfo $x get name]]}
		if {[lsearch $nameLayer [file tail [lindex $a 3]]]==-1} {
				mol new "$Path/[lindex $a 8]" type pdb
				set repr "CPK"
				mol modstyle 0 top $repr
		}
	}

	## update toplayer
	mol top $topLayer
}




##### RUN Application
#	VsLab::vsLab
