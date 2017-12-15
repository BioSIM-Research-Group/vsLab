package provide AutoDock 1.0

proc VsLab::debug {opt text} {
##
##  Usage: debug $text
##
##  opt  - title or text
##  text - text to be displayed
##
##  There is a global variable that varies from YES to NO depending on what we want

        #variable vLab::debug

        ## see if it is title or text
        set charTitle "="
        if {$opt=="title"} {set repeat [string repeat $charTitle [expr (70-[string length $text])] ]; set text "$charTitle$charTitle $text $repeat"}

        if {$opt=="time"} {set text "» Time spend in procedure: $text"}

        ## write the text if the Debug =YES
         puts "VsLab:    $text"
}


proc VsLab::Shell {database} {

  # General variables
	global autoDockToolsPath autoDockPath autoGridPath

	# path of the directory
	set Path [file dirname $database]

	# LOGO

	debug text "########################################################"
	debug text "######                                            ######"
	debug text "######         Virtual Screening Lab v1.3         ######"
	debug text "######                                            ######"
	debug text "######  www.fc.up.pt/pessoas/nscerque/vsLab/vLab  ######"
	debug text "######                                            ######"
	debug text "######     For help contact: nscerque@fc.up.pt    ######"
	debug text "######                                            ######"
	debug text "########################################################"
	debug text ""

	if {[file exists $database]==0} {puts "Database $database does not exists...." return}
	debug text "Reading Database : $database"
	debug text ""


	## open database
		set erro 0; set erro [catch {sqlite3 outputdb $database} erroMsg ]
		if {$erro!=0 } {debug text  "\nError while reading database  $databse: $erro (type exit to quit).\n"}

		## Reading Data from previous input table

		## color aqui um foreach
		set inputList ""
		set erro [catch {outputdb eval {SELECT * FROM input} dbvalues {lappend inputList [array get dbvalues]}} erroMsg ]
		if {$erro!=0} {debug text "\nError while reading database $database: $erroMsg (type exit to quit).\n";return 0}



		set runs 1
		foreach row $inputList  {
		array set dbvalues $row

			## Running autodock

			## see if the table of the ligand already exists
			set LigandName "T_[file rootname [file tail $dbvalues(Ligand)]]"
			if {[outputdb eval {select count(*) from sqlite_master where name=$LigandName}]!=1} {

				# run autodock
				set results ""
				set results [VsLab::autodock $runs "$autoDockToolsPath $autoDockPath $autoGridPath $Path/$dbvalues(Output) $Path/$dbvalues(Protein) $Path/$dbvalues(Ligand) {$dbvalues(grid_size)} {$dbvalues(grid_center)} $dbvalues(grid_spacing) $dbvalues(gridSample) $dbvalues(ga_set) $dbvalues(ga_run) $dbvalues(ga_num_evals) $dbvalues(ga_num_generations) $dbvalues(ga_pop_size) $dbvalues(dockSample)"]

				#include information on the table if there is something
				if {$results!=""} {
					outputdb eval "CREATE TABLE if not exists $LigandName (Solution, PDB, Cluster, Energy, ki, E1, E2, E3, E4)"

					foreach a $results {
						set solution    	[lindex $a 0]
						set pdb                 [file tail [lindex $a 1]]
						set cluster		[lindex $a 2]
						set energy              [lindex $a 3]
						set ki                  [lindex $a 4]
						set E1                  [lindex [lindex $a 5] 0]
						set E2                  [lindex [lindex $a 5] 1]
						set E3                  [lindex [lindex $a 5] 2]
						set E4                  [lindex [lindex $a 5] 3]

						outputdb eval "INSERT INTO $LigandName (Solution, PDB, Cluster, Energy, ki, E1, E2, E3, E4) VALUES (:solution, :pdb, :cluster, :energy, :ki, :E1, :E2, :E3, :E4)"
					}
				}

			}

		# end this turn and passes to the next ligand
		unset dbvalues
		incr runs

	}
	outputdb close
	debug text  ""
	debug text  "All calculations have been done!"
	debug text  ""
	debug text  "To visualize the results load the output file (*.vslab) in the VsLab Gui."
}



proc VsLab::analyseResult {saveName fileName} {

	set loadFile [open $fileName r]
	set solution 0 ;# count the docking solutions
	set read 0; # only treats the output near the end of the file
	set returnList ""
#	set energy 0; set ki "-"; set conformations 0
#	set E1 0;	set E2 0; set E3 0;	set E4 0

        while {![eof $loadFile] } {
		set readFile [gets $loadFile]

		if {[string match "*CLUSTER ANALYSIS OF CONFORMATIONS*" $readFile]==1} {set read 1}

		if {$read==1 && [lindex $readFile 0] =="MODEL"} {
			incr solution
			set newName "$saveName-S$solution.pdb"
			set saveFile [open $newName w]
			set energy 0; set ki "-"; set conformations 0
      set E1 0;       set E2 0; set E3 0;     set E4 0
			while {[lindex $readFile 0]!="ENDMDL" && ![eof $loadFile]} {
				## save the solution with the name P1_1:S1.pdb
				puts $saveFile $readFile
				## Extract information to store in a list to return and store in sqlite
				if { [string first "Number of conformations in this cluster" $readFile 0]!=-1}  {set conformations [lindex $readFile 8]}
				if { [string first "Estimated Free Energy of Binding" $readFile 0]!=-1} 	{set energy [lindex $readFile 7]}
				if { [string first "Estimated Inhibition Constant, Ki" $readFile 0]!=-1} 	{set ki [format %2.2e  [expr exp (($energy*1000)/(1.987*298.15))]]}
				if { [string first "Final Intermolecular Energy" $readFile 0]!=-1} 		{set E1 [lindex $readFile 6]}
				if { [string first "Final Total Internal Energy" $readFile 0]!=-1} 		{set E2 [lindex $readFile 7]}
				if { [string first "Torsional Free Energy" $readFile 0]!=-1} 			{set E3 [lindex $readFile 6]}
				if { [string first "Unbound System's Energy" $readFile 0]!=-1} 			{set E4 [lindex $readFile 6]}


				## read another line till ENDMDL
				set readFile [gets $loadFile]
			}
			puts $saveFile $readFile ;# save ENDMOL

			## if the solution are part of a cluster it will be rejected
			#set returnList [linsert $returnList end "$solution $newName $energy $ki {$E1 $E2 $E3 $E4}" ]
			set returnList [linsert $returnList end "$solution $newName $conformations $energy $ki {$E1 $E2 $E3 $E4}" ]
			close $saveFile
		}

	}
	close $loadFile

return $returnList
}


proc VsLab::autodock {runs input} {
###################################################################################
## This procedures are used to dock the ligand in the proteins using autodock    ##
###################################################################################
## Description: Dock the ligand inside the active site of the proteni
##
## Usage: docking $options saveOutput newTable previousTable
##
##			options			- options for the docking process
##			directory		- directory where the results should be stored and the database
##			protein			- protein used as input
##			ligand			- ligand used as input

	## Reading variables

	#set input "$vLab::autoDockToolsPath $vLab::autoDockPath $vLab::autoGridPath $input"


  set keywords  " {AutoDockTools Path} {AutoDock Path} {AutoGrid Path} {Output Directory} {Protein} {Ligand} {Grid Points} {Grid Center} {Grid Spacing} {Sample Grid File (gpf)} {Search Algorithm} {Number of Solutions} {Number of Evaluations} {Number of Generations} {Population Size} {Sample Dock File (dpf)}"
	set variables "autoDockToolsPath autoDockPath autoGridPath directory protein ligand grid_size grid_center grid_spacing gridSample ga_set ga_run ga_num_evals ga_num_generations ga_pop_size dockSample"

	foreach {b} $variables {c} $input {set $b $c}


	if {$runs==1} {
		foreach {a} $keywords  {b} $variables {c} $input {if {$a!="Ligand"} {VsLab::debug text  "[format %-25s $a]: $c"}}

	}

	foreach {a} $keywords  {b} $variables {c} $input {if {$a=="Ligand"} {VsLab::debug text  "[format %-25s $a]: ($runs) - $c"}}






	## creating pdbqt files
	set ligandOutput "$directory/[file rootname [file tail $ligand] ].pdbqt"
#       set erro [catch {exec $autoDockToolsPath/bin/python $autoDockToolsPath/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_ligand4.py -l $ligand -o $ligandOutput} erroMsg ]
#       if {$erro!=0} {debug text "Error : $erroMsg"}


	set proteinOutput "$directory/[file rootname [file tail $protein] ].pdbqt"
#       set erro [catch {exec $autoDockToolsPath/bin/python $autoDockToolsPath/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_receptor4.py -r $protein -A checkhydrogens -o $proteinOutput } erroMsg ]
#	if {$erro!=0} {debug text "Error : $erroMsg"}



if {$runs==1} {
	## creating grid
	set gridName "$directory/grid"
	set erro [catch {exec $autoDockToolsPath/bin/python $autoDockToolsPath/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_gpf4.py -l $ligandOutput -r $proteinOutput -o "$gridName.gpf" -d $directory} erroMsg ]

       if {$erro!=0} {VsLab::debug text "Error : $erroMsg"}


		## open file
		array unset Input; set mem 0
		if {$gridSample=="none"} {set loadFile [open "$gridName.gpf" r]
			} else {set loadFile [open $gridSample r]}

      while {![eof $loadFile] } {
				set readFile [gets $loadFile]; incr mem

				switch  [lindex $readFile 0] {
					"npts"		 {set readFile "{npts $grid_size} 				 				 {# num.grid points in xyz}"}
					"spacing"	 {set readFile "{spacing $grid_spacing} 						{# spacing(A)}"}
					"receptor"	 {set readFile "{receptor $proteinOutput}					 	{# macromolecule}"}
					"gridcenter" {set readFile "{gridcenter $grid_center}						 {# xyz-coordinates or auto}"}
					#"smooth"	 {set readFile "{smooth $smooth} 							 	{# store minimum energy w/in rad(A)}"}
					#"dielectric" {set readFile "{dielectric $dielectric}				 		 {# <0, AD4 distance-dep.diel;>0, constant}"}
					"gridfld"	 {set readFile "{gridfld $directory/[lindex $readFile 1]} 	 	{# grid_data_file}"}
					"map"		 {set readFile "{map $directory/[lindex $readFile 1]} 		 	{# atom-specific affinity map}"}
					"elecmap"	 {set readFile "{elecmap $directory/[lindex $readFile 1]}     	{# electrostatics map}"}
					"dsolvmap"	 {set readFile "{dsolvmap $directory/[lindex $readFile 1]}    	{# desolvation map}"}
					default		 { }
				}
				array set Input "$mem {$readFile}"
			}
		close $loadFile

		## save the new file
		set saveFile [open "$gridName.gpf" w]
			for {set a 1} {$a<=[expr $mem-1]} {incr a} {
				if {[llength [lindex [array get Input $a] 1]]!=2} {
					puts $saveFile [lindex [array get Input $a] 1]
				} else {
					puts "Antiga [lindex [array get Input $a] 1]"
					puts "NOVA [format %-35s [lindex [lindex [array get Input $a] 1] 0]]  [lindex [lindex [array get Input $a] 1] 1]"
					puts $saveFile "[format %-35s [lindex [lindex [array get Input $a] 1] 0]]  [lindex [lindex [array get Input $a] 1] 1]"}
			}

		close $saveFile


     ## running autogrid

        # Open a pipe
        set pipe [open "|$autoGridPath -p $gridName.gpf -l $gridName.glg"]
        # Set up to deliver file events on the pipe
        fconfigure $pipe -blocking false
        fileevent $pipe readable [list VsLab::isReadable $pipe]
        # Launch the event loop and wait for the file events to finish
        vwait ::DONE
        # Close the pipe
        close $pipe


	}

	## create autodock input file
    set dockName "$directory/[file rootname [file tail $ligand] ]"
    exec $autoDockToolsPath/bin/python $autoDockToolsPath/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_dpf4.py -l $ligandOutput -r $proteinOutput -o "$dockName.dpf"

		## open file
		array unset InputD; set mem 0
		if {$dockSample=="none"} {set loadFile [open "$dockName.dpf" r]
			} else {set loadFile [open $dockSample r]}

		while {![eof $loadFile] } {
			set readFile [gets $loadFile]; incr mem


			switch  [lindex $readFile 0] {
				"ga_run"      	 {set readFile "{ga_run $ga_run}							{# do this many hybrid GA-LS runs}"}
				"move"		 {set readFile "{move $ligandOutput}						{# small molecule}"}
				"fld"       	 {set readFile "{fld $directory/[lindex $readFile 1]}		{# grid_data_file}"}
				"map"          	 {set readFile "{map $directory/[lindex $readFile 1]}		{# atom-specific affinity map}"}
				"elecmap"      	 {set readFile "{elecmap $directory/[lindex $readFile 1]}	{# electrostatics map}"}
				"desolvmap"	 {set readFile "{desolvmap $directory/[lindex $readFile 1]}	{# desolvation map}"}
				"ga_pop_size"	 {set readFile "{ga_pop_size $ga_pop_size}					{# number of individuals in population}"}
				"ga_num_evals"	 {set readFile "{ga_num_evals $ga_num_evals}					{# maximum number of energy evaluations}"}
				"ga_num_generations" {set readFile "{ga_num_generations $ga_num_generations}					{# maximum number of generations}"}
				default { }
      }
				array set InputD "$mem {$readFile}"
		}





#{Search Algorithm} {Number of Solutions} {Number of Evaluations} {Number of Evaluations} {Population Size}
#ga_set ga_run ga_num_evals ga_num_generations ga_pop_size
			close $loadFile

			## save the new file
			set saveFile [open "$dockName.dpf" w]
			for {set a 1} {$a<=[expr $mem-1]} {incr a} {
				if {[llength [lindex [array get InputD $a] 1]]!=2} {puts $saveFile [lindex [array get InputD $a] 1]
					} else {puts $saveFile "[format %-35s [lindex [lindex [array get InputD $a] 1] 0]]  [lindex [lindex [array get InputD $a] 1] 1]"}
				}

			close $saveFile



#	set erro 0
#       set erro [catch {exec $autoGridPath -p $gridName.gpf -l $gridName.glg} erroMsg ]
#	if {$erro!=0 && [string first "Successful Completion"  $erroMsg 0]==-1 } {debug text "Error : $erroMsg"}

	## running autodock

        # Open a pipe
        set pipe [open "|$autoDockPath -p $dockName.dpf -l $dockName.dlg"]
        # Set up to deliver file events on the pipe
        fconfigure $pipe -blocking false
        fileevent $pipe readable [list VsLab::isReadable $pipe]
        # Launch the event loop and wait for the file events to finish
        vwait ::DONE
        # Close the pipe
        close $pipe




#	 set erro 0
#        set erro [catch {exec $autoDockPath -p $dockName.dpf -l $dockName.dlg} erroMsg ]
#        if {$erro!=0 && [string first "Successful Completion"  $erroMsg 0]==-1 } {debug text "Error : $erroMsg"}


	## save each ligand conformation in a new file

	set saveName "$directory/[file rootname [file tail $ligandOutput]]"
	set results [VsLab::analyseResult $saveName $dockName.dlg]
	return $results

}

 proc VsLab::isReadable { f } {
    # The channel is readable; try to read it.
    set status [catch { gets $f line } result]
    if { $status != 0 } {
        # Error on the channel
        puts "error reading $f: $result"
        set ::DONE 2

    } elseif { $result >= 0 } {
        # Successfully read the channel
        puts "got: $line"

    } elseif { [eof $f] } {
        # End of file on the channel
#	puts "$f  $line"
        set ::DONE 1

    } elseif { [fblocked $f] } {
        # Read blocked.  Just return

    } else {
        # Something else
        puts "can't happen"
        set ::DONE 3
    }
 }
