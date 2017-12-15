##
## This program allows to install vsLab
##
## Author: Nuno M. F. Sousa A. Cerqueira
##
## Id: install.tcl,v 1.0 2009/07/09 21:32:32 NSC
##

puts "\n\n"
puts " ############################################################################"
puts " ####                                                                    ####"
puts " ####           INSTALATION OF Virtual Screening Lab (VsLab)             ####"
puts " ####                                                               v1.1 ####"
puts " ############################################################################"

#package require platform

#### Variables
		set PathADT ""
                set PathAD ""
                set PathAG ""
#### Step 1

	puts "\n\n ## Instalation of vsLab:\n "
	puts "     HELP:  Insert the Path where vsLab is going to be installed (example: /home/nuno/Programs/vLab)."
	puts "            If the directory does not exist, it will be created.\n"
	puts -nonewline "     PATH > "
	flush stdout; set Path [gets stdin]


	## creating directory and copying files

      	     ## List of files to copied 
		set fileList [lsort [glob *]]

	     ## Creating Directory 
		if { [file isdirectory $Path]==0} {
			file mkdir $Path
			puts "           - Directory $Path was created."
		} else {
			puts "           - Directory $Path already exists..."
			puts "		 - Removing Old Files..."
			foreach a $fileList { file delete -force $Path/$a}
		}

	     ## Copying files
		puts "           - Copying Files to Directory: $Path"
		foreach a $fileList {file copy -force $a $Path}


#### Step 2

	## AutoDock Tools Path

	puts "\n\n ## Insert the AutoDock Tools Path :\n "
	puts "     HELP: The program AUTODOCK Tools (ADT) can be download from http://autodock.scripps.edu/downloads"
	puts "           Install the program and insert installation path."
	puts "\n\n		linux : /usr/local/MGLTools-1.5.0 (if it was installed as root) or \$HOME/MGLTools-1.5.0 (if it was installed as a regular user)."
	puts "		Mac OS X:  /Library/MGLTools/1.5.0"
	
	

	# check if directory exists
	set continue 0
	while {$continue==0} { 
		puts -nonewline "\n     PATH > "
		flush stdout; set PathADT [gets stdin]
		if { [file isdirectory $PathADT]==0} {
                        puts "     - The Directory $PathADT does not exists. Insert the correct path of AutoDockTools Directory..."
		} else {set continue 1}
	}


	## AutoDock and AutoGrid
	puts "\n\n ## Insert the path of the AutoDock  and AutoGrid binary file: \n"
	puts "     HELP: The program AUTODOCK and AUTOGRID can be download from http://autodock.scripps.edu/downloads"
	puts "     Extract the files and insert the path of the binary files (example: /home/nuno/Programs/AutoDock/autodock4)."

	# check if file exists
        set continue 0
        while {$continue==0} {
		puts -nonewline "\n     AutoDock PATH > "
	        flush stdout; set PathAD [gets stdin]
                if { [file exists $PathAD]==0} {
                        puts "     - The File  $PathAD does not exists. Insert the correct path of AutoDock executable ... (Help: type \"which autodock4\" in the terminal)"
                } else {set continue 1}

	}

	# check if file exists
        set continue 0
	while {$continue==0} {
                puts -nonewline "\n     AutoGrid PATH > "
	        flush stdout; set PathAG [gets stdin]
                if { [file exists $PathAG]==0} {
                        puts "     - The File  $PathAG does not exists. Insert the correct path of AutoGrid executable... (Help: type \"which autogrid4\" in the terminal)"
                } else {set continue 1}

        }


####  Step 3

        ## Adding plug-in to vmd
                set vmdrc [open "[file nativename ~]/.vmdrc" w]
                        # Add new libraries required for vLab
                                puts $vmdrc "lappend auto_path          $Path"
                                puts $vmdrc "lappend auto_path          $Path/Routines/Lib"
                                puts $vmdrc "lappend auto_path          $Path/Routines/Other/bwidget"
                                puts $vmdrc "lappend auto_path          $Path/Routines/Other/tablelist4.11"
				
				
				# LINUX
				if {$tcl_platform(os) == "Linux"} {
                                	if { $tcl_platform(machine) == "i686" }   {puts  $vmdrc "load $Path/Routines/Other/sqlite/32B/tclsqlite-3.6.11.so"}
                                	if { $tcl_platform(machine) == "x86_64" } {puts  $vmdrc "load $Path/Routines/Other/sqlite/64B/libtclsqlite3.so"}
				}
				
				# MacOS Leopard
				if {$tcl_platform(os) == "Darwin"} {
					puts  $vmdrc "load $Path/Routines/Other/sqlite/MacOs/libsqlite3.6.18.dylib"
				}
					
				
				puts $vmdrc "variable autoDockToolsPath 	$PathADT"
				puts $vmdrc "variable autoDockPath	 	$PathAD"
				puts $vmdrc "variable autoGridPath 	 	$PathAG"

                        # Add vLab extension
                                puts $vmdrc "vmd_install_extension VsLab \"VsLab::vslab\" \"Modeling/Virtual Screening Lab\""

                puts $vmdrc "menu main on"
                close $vmdrc

                puts "           - vLab plug-in (Extensions»Modelling»Virtual Screening Lab) added to VMD (.vmdrc file created in the home directory)"




	puts "## INSTALLATION DONE\n"
	puts "   vsLab is now installed. The extension can be found at the VMD menu Extensions » Modelling » virtual screening Lab."
	puts "   Enjoy ..."

