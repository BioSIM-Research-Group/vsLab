package provide Gui_inputFile 1.0

proc VsLab::buildFilesFrame {input ProteinList}  {

########## Frame 1

	grid [ttk::frame $input.f1  ] -in $input -row 0 -column 0 -sticky ew

	## Label
	grid [ttk::label $input.f1.l2 -text "Protein (VMD Toplevel):" ] -in $input.f1 -row 0 -column 0 -padx 18 -pady 15

	## label
	grid [ttk::label $input.f1.lb -text "none" ] -in $input.f1 -row 0 -column 1 -sticky ew -padx 10



########## Frame 2
	grid [ttk::labelframe $input.f2 -text "Ligands :" -height 150 -width 320 ] -in $input -padx 10 -row 1 -column 0 -sticky news -pady 10

		grid [ttk::frame $input.f2.f21] -in $input.f2 -row 0 -column 0 -padx 5 -sticky news
			grid [listbox $input.f2.f21.lb1  -yscrollcommand [list $input.f2.f21.scb1 set]] -in $input.f2.f21 -row 0 -column 0  -padx 0 -pady 10 -sticky news
			grid [ttk::scrollbar $input.f2.f21.scb1 -command [list $input.f2.f21.lb1 yview]] -in $input.f2.f21 -row 0 -column 1 -columnspan 1 -padx 0 -pady 10 -sticky ns

		grid [ttk::frame  $input.f2.f22] -in $input.f2 -row 0 -column 1 -sticky news
			grid [ttk::button  $input.f2.f22.bt1 -text "Add" -width 7 -command {\
					set VsLab::ligandPath [VsLab::openFile]; \
					set VsLab::ligandName [file tail $VsLab::ligandPath]; \
					.vslab.nb1.f2.nb2.f1.f2.f21.lb1 insert end $VsLab::ligandName; \
					set VsLab::arrayLigandPath [linsert $VsLab::arrayLigandPath end $VsLab::ligandPath]\
                   			}] -in $input.f2.f22 -pady 10 -row 1 -column 0

			grid [ttk::button  $input.f2.f22.bt3 -text "Add Dir." -width 7 -command {VsLab::chooseDir}] -in $input.f2.f22 -row 2 -column 0 -pady 10 -padx 5
			grid [ttk::button  $input.f2.f22.bt2 -text "Delete" -width 7 -command {VsLab::deleteLigand [.vslab.nb1.f2.nb2.f1.f2.f21.lb1 curselection]}] -in $input.f2.f22 -row 3 -column 0 -pady 10 -padx 5

########## Frame 3

        grid [ttk::frame $input.f3  ] -in $input -row 2 -column 0 -sticky ew

        ## Label
        grid [ttk::checkbutton $input.f3.cb -variable VsLab::lCharge -text "Keep the original charges of the ligands." ] -in $input.f3 -row 0 -column 0 -padx 18 -pady 15




########## Configure weights
	grid columnconfigure  $input     	0 -weight 1
        grid rowconfigure     $input     	1 -weight 1
	grid columnconfigure  $input.f2		0 -weight 1
	grid rowconfigure     $input.f2		0 -weight 1
	grid columnconfigure  $input.f2.f21     0 -weight 1
	grid rowconfigure     $input.f2.f21     0 -weight 1
	grid columnconfigure  $input.f2.f21.lb1 0 -weight 1
	grid rowconfigure     $input.f2.f21.lb1 0 -weight 1
	grid columnconfigure  $input.f3.cb 	0 -weight 1
        grid rowconfigure     $input.f3.cb	0 -weight 1



########## Bindings



}

proc VsLab::openFile {} {
	set types {{{"Coordinate Files"}    {*.pdb *.mol2 }}
    		    {"All files"             *     }}
	set filePath [tk_getOpenFile -filetypes $types ]
	return $filePath
}

proc VsLab::deleteLigand {pos} {
	set input .vslab.nb1.f2.nb2.f1
	if {$pos!=""} {
		$input.f2.f21.lb1 delete [$input.f2.f21.lb1 curselection] [$input.f2.f21.lb1 curselection]
		set VsLab::arrayLigandPath [lreplace $VsLab::arrayLigandPath $pos $pos]
	}
}

proc VsLab::chooseDir {} {
	set input .vslab.nb1.f2.nb2.f1.f2.f21.lb1
	set dir ""; set dir [tk_chooseDirectory -initialdir . -title "Choose a directory"]
	set contents [glob -directory $dir *.pdb *.mol2]
	$input delete 0 end

	foreach item $contents {
		if {$item!=""} {
			set VsLab::ligandPath $item
			set VsLab::ligandName [file tail $VsLab::ligandPath]
			$input insert end $VsLab::ligandName
			set VsLab::arrayLigandPath [linsert $VsLab::arrayLigandPath end $VsLab::ligandPath]
		}
	}

}


proc VsLab::create_inputFile {} {
	global autoDockToolsPath
	set grid  $VsLab::topGui.nb1.f2.nb2.f3


	#### Resume variables Data
	set VsLab::grid_center	"[format %2.0f $VsLab::X] [format %2.0f $VsLab::Y] [format %2.0f $VsLab::Z]"

	set gridpointW [expr ( [$grid.f1.scaleW get]/ [$grid.f1.sp0 get]) ]
	set gridpointH [expr ( [$grid.f1.scaleH get]/ [$grid.f1.sp0 get]) ]
	set gridpointD [expr ( [$grid.f1.scaleD get]/ [$grid.f1.sp0 get]) ]

	set VsLab::grid_size "[format %2.0f $gridpointW] [format %2.0f $gridpointH] [format %2.0f $gridpointD]"


	#### See if the user has added some ligand files
	if {$VsLab::arrayLigandPath==""} {tk_messageBox -message "No ligands have been selected..." -title "Warning"; return}


	#### Create Files
	set fileName [file rootname [file tail [molinfo [molinfo top] get name] ]]

	set topLayerName $fileName

	set types { {{VirtualLab Files} {.vsLab}     }
		{{All Files}        *            }}

	set fileName [tk_getSaveFile -initialfile $fileName  -defaultextension ".vsLab" -filetypes $types]

	## see if the file Name exists
	if {$fileName == ""} {return}

	if {[file exists $fileName]==1} {
		## remove filename
		file delete $fileName

		## remove directory
		if {[file isdirectory [file root $fileName]]==1} {file delete -force [file root $fileName]}
	}

	set fileName [file root $fileName]
	## Create the new directory
	if {[file isdirectory $fileName]==0} {file mkdir $fileName}

	## Create directory for ligands and protein
	file mkdir "$fileName/Files"

	## Store all files in this directory


	## See if the file exists; is not create them


	## Inactivate Run
	$VsLab::topGui.nb1.f2.fb.bRun configure -state disable

			## Creating Files
			#set toplevel $VsLab::topGui

	if {[winfo exists $VsLab::topGui.input]} {wm deiconify $VsLab::topGui.input ;return}
	toplevel $VsLab::topGui.input

	#### Title of the windows
	wm title $VsLab::topGui.input "Input" ;# titulo da pagina

	#### FRAME 1 - Canvas
	grid [frame $VsLab::topGui.input.f1 ] -row 1 -column 0 -padx 1 -pady 1 -sticky news

	#### Label 1
	grid [ttk::label $VsLab::topGui.input.l1 -text "Creating input Files...  Please wait."] -row 0 -column 0  -padx 15 -pady 5 -sticky ew

	#### Progress bar
	grid [ttk::progressbar $VsLab::topGui.input.pb1 -maximum [expr (2*[llength $VsLab::arrayLigandPath] +2)]] -row 1 -column 0  -padx 15 -pady 5 -sticky ew

	#### Button
	grid [ttk::button $VsLab::topGui.input.b1 -state disable  -text "Done" -command {destroy $VsLab::topGui.input; $VsLab::topGui.nb1.f2.fb.bRun configure -state normal } ] -row 2 -column 0  -padx 15 -pady 5 -sticky ew



	## Create the filename
	 set directory  [lindex [file split $fileName] [expr [llength [file split $fileName]]-1]]

	 set VsLab::database $fileName.vsLab
	 sqlite3 outputdb $VsLab::database

	## See if the table Input on the database already exists. If not create it
	if {[outputdb eval {select count(*) from sqlite_master where name="input"}]!=1} {
		outputdb eval "CREATE TABLE if not exists input (Output, Protein, Ligand, lCharge,  grid_size, grid_center, grid_spacing, gridSample, ga_set, ga_run, ga_num_evals, ga_num_generations, ga_pop_size, dockSample)"

		foreach a $VsLab::arrayLigandPath {
			if {$a!=""} {
				set a "$directory/Files/[file tail $a]"
				set protein "$directory/Files/$topLayerName.pdb"
				outputdb eval "INSERT INTO input (Output, Protein, Ligand, lCharge, grid_size, grid_center, grid_spacing, gridSample, ga_set, ga_run, ga_num_evals, ga_num_generations, ga_pop_size, dockSample) VALUES (:directory, :protein, :a, :VsLab::lCharge, :VsLab::grid_size, :VsLab::grid_center, :VsLab::grid_spacing, :VsLab::gridSample, :VsLab::ga_set, :VsLab::ga_run, :VsLab::ga_num_evals, :VsLab::ga_num_generations, :VsLab::ga_pop_size, :VsLab::dockSample)"
				$VsLab::topGui.input.pb1 step 1;update
			}
		}


	# close the database for the results
	outputdb close


			##tk_messageBox -message "Creating Input Files... (Please wait)" -title "Warning"

			# Protein
			set sel [atomselect [molinfo top] all]
			set ProteinFile "$fileName/Files/$topLayerName.pdb"; $sel writepdb $ProteinFile

			$VsLab::topGui.input.pb1 step 1;update
			# Open the Protein File and change it in order to make the Zn and the Fe correct
			#VsLab::changePDB $ProteinFile

			$VsLab::topGui.input.pb1 step 1;update

			# Create the PDBQT of the protein
		        set proteinOutput "$fileName/[file rootname [file tail $ProteinFile] ].pdbqt"
       			set erro [catch {exec $autoDockToolsPath/bin/python $autoDockToolsPath/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_receptor4.py -r $ProteinFile -A checkhydrogens -o $proteinOutput } erroMsg ]
       			if {$erro!=0} {VsLab::debug text "Error : $erroMsg"}


			# Ligand
			foreach a $VsLab::arrayLigandPath {
				if {$a!=""} {file copy $a  $fileName/Files/[file tail $a]}
				set ligand "$fileName/Files/[file tail $a]"
	        set ligandOutput "[file rootname $fileName/[file tail $a]].pdbqt"

				if {$VsLab::lCharge==1} {
    			set erro [catch {exec $autoDockToolsPath/bin/python $autoDockToolsPath/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_ligand4.py -C -l $ligand -o $ligandOutput} erroMsg ]


				} else {
          set erro [catch {exec $autoDockToolsPath/bin/python $autoDockToolsPath/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_ligand4.py -l $ligand -o $ligandOutput} erroMsg ]
				}

			if {$erro!=0} {VsLab::debug text "Error : $erroMsg"}
				$VsLab::topGui.input.pb1 step 1; update
			}

			$VsLab::topGui.input.pb1 configure -value [expr (2*[llength $VsLab::arrayLigandPath] +2)]

			#### turn button able
			$VsLab::topGui.input.l1 configure -text " All input files have been created !"
			$VsLab::topGui.input.b1 configure -state normal

		} else {tk_messageBox -message "The file already exists! Change the name of the protein..." -title "Warning"}



}

proc VsLab::changePDB {file} {
	# puts in memory the data
        set openFile [open $file r]
        set i 1
        while {![eof $openFile]} {
                set readFile [gets $openFile]
                set pdb($i) $readFile
                incr i
        }
        close $openFile

        # list of metals
                set list   "Ca CA MG Mg MN Mn BR Br Zn ZN Fe FE"
                set charge_list "2.000 2.000 2.000 2.000 2.000 2.000 -1.00 -1.00 2.000 2.000 3.000 3.000"


        set saveFile [open $file w]

        # changes data and saves

        for {set a 1} {$a<$i} {incr a} {

					if {[lsearch $list [lindex $pdb($a) 11]]!=-1} {

						## Ler Formato PDB
						set strPdb [lindex $pdb($a) 0]
						set natmPdb [lindex $pdb($a) 1]
						set tatmPdb [lindex $pdb($a) 2]
						set tatmPdb [lindex $list [lsearch $list [lindex $pdb($a) 11]] ]
						set resiPdb [lindex $pdb($a)  3]
						set chainPdb [lindex $pdb($a) 4]     ;#123456 1234 123 1234 123 12345 1234567 1234567 1234567 12345 12345678 12345678
						set nresiPdb [lindex $pdb($a)  5]    ;#ATOM      1  N   LEU A   5     -44.797 124.229  36.402  1.00 82.31           N
						set xPdb [lindex $pdb($a) 6]         ;#ATOM   4613 FE   HEM A 500      52.518  83.141  57.090  1.00 30.98     0.000 Fe
						set yPdb [lindex $pdb($a) 7]
						set zPdb [lindex $pdb($a) 8]
						set xtr1Pdb [lindex $pdb($a) 9]
						set xtr2Pdb [lindex $pdb($a) 10]
						set xtr3Pdb [lindex $pdb($a) 11]

						set charge [lindex $charge_list [lsearch $list [lindex $pdb($a) 11]] ]

						#puts "123456 1234 1234 123 1 1234567 1234567 1234567 1234567 12345 12345678 12345678"
						puts $saveFile "[format %-6s $strPdb] [format %4s $natmPdb] [format %-4s $tatmPdb] [format %3s $resiPdb] [format %-1s $chainPdb] [format %-7s $nresiPdb] [format %7.3f $xPdb] [format %7.3f $yPdb] [format %7.3f $zPdb] [format %5s $xtr1Pdb] [format %-8s $xtr2Pdb] [format %6s $charge] [format %-4s $xtr3Pdb]"

					} else {puts $saveFile  $pdb($a)}



        }
        close $saveFile


}



proc VsLab::Run {database} {

	if {[file exists $database]==-1} {
		tk_messageBox -message "An input file must be created first or a file open..." -title "Warning"; return
    return
	}

	set    msg "Depending on the number of ligands the VMD interface might block.\n\n"
	append msg "In those cases read the README file to see how to run vsLab in the shell... \n"
	tk_messageBox -title "About" -message $msg

	VsLab::Shell $database


}
