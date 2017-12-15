package provide Gui_AutoDock 1.0

proc VsLab::buildAutoDockFrame {dock}  {

########## Frame 1
	grid [ttk::frame $dock.f1 ]  -pady 10 -padx 10 -row 0 -column 0 -sticky news

		## Label
		grid [ttk::label $dock.f1.l0 -text "Search Algorithm    :" ] -in $dock.f1 -row 1 -column 0 -pady 20 -sticky w

		## ComboBox_1
		set dockList "GA LGA"
		grid [ttk::combobox $dock.f1.cb1 -textvariable VsLab::ga_set  -values $dockList -state readonly] -in $dock.f1 -row 1 -column 1  -padx 2
		$dock.f1.cb1 set [lindex $dockList 0]

		#Label
		grid [ttk::label $dock.f1.l1 -text "Number of Solution :" ] -in $dock.f1 -row 2 -column 0 -pady 10 -sticky w

		## spinbox
		grid [spinbox $dock.f1.sb1 -width 5 -textvariable VsLab::ga_run -from 0 -to 1000 -increment 1] -in $dock.f1 -row 2 -column 1 -sticky w

		$dock.f1.sb1 set 10

########## Frame 2
	grid [ttk::frame $dock.f2 ]  -pady 5 -padx 10 -row 1 -column 0 -sticky news

		## Label
		grid [ttk::labelframe $dock.f2.lf1 -text "Other options :"] -in $dock.f2 -row 3 -column 0 -columnspan 2  -pady 10 -sticky news

		set label "{Number of Evaluations :} {Number of Generations :} {Population Size :}"
		set entry {VsLab::ga_num_evals VsLab::ga_num_generations VsLab::ga_pop_size}
		foreach a $label b $entry c {1 2 3} {
			## Label
			grid [ttk::label $dock.f2.lf1.$c -text $a ] -in $dock.f2.lf1 -row $c -column 0 -pady 10 -padx 10 -sticky w

			## entry
			grid [ttk::entry $dock.f2.lf1.ent$c -width 10 -textvariable $b] -in $dock.f2.lf1 -row $c -column 1 -padx 15 -sticky we
		}

########## Frame 3
		grid [ttk::frame $dock.f3 -width 250 ]  -pady 10 -padx 10 -row 2 -column 0 -sticky news

		## Label
		grid [ttk::label $dock.f3.lb1 -text "Sample Input File:" ] -in $dock.f3 -row 1 -column 0

		## entry
		grid [ttk::entry $dock.f3.ent1 -width 11 -textvariable sampleFile] -in $dock.f3 -row 1 -column 1 -padx 5 -sticky we

		## button
		grid [ttk::button $dock.f3.bt1 -text "Open" -width 5 -command {VsLab::openDockFile}] -in $dock.f3 -row 1 -column 2


########## Configure weights
	grid columnconfigure  $dock     0 -weight 1
	grid columnconfigure  $dock.f2	0 -weight 1
	grid columnconfigure  $dock.f3	1 -weight 1



}

proc VsLab::openDockFile {} {
	set dock .vslab.nb1.f2.nb2.f2
		set types {{{"Coordinate Files"}    {*.dpf}}
				{"All files"             *     }}
		set VsLab::dockSample [tk_getOpenFile -filetypes $types ]
		set VsLab::dockSampleName [file tail $VsLab::dockSample]
		$dock.f3.ent1 delete 0 end
		$dock.f3.ent1 insert end $VsLab::dockSampleName
}

proc save {} {
	global dock

	if { [$dock.f1.cb1 getvalue]==0} { set VsLab::ga_set "GA" }
	if { [$dock.f1.cb1 getvalue]==1} { set VsLab::ga_set "LGA"}
	set $VsLab::ga_run			[$dock.f1.sb1 get]
	set $VsLab::ga_num_evals			[$dock.f1.lf1.ent1 get]
	set $VsLab::ga_num_generations		[$dock.f1.lf1.ent2 get]
	set $VsLab::ga_pop_size			[$dock.f1.lf1.ent3 get]

	destroy $dock
}
