package provide VSLAB 1.4

###################################################################################################
## VsLab allow to dock one or a group of ligands into a target protein using autodock and VMD    ##
###################################################################################################
## 
## version 1.4 L
## Last revision SET 2011 - Nuno Sousa Cerqueira
##
## Faculdade de Ciencias, Universidade do Porto - Portugal
##
## email: nscerque@fc.up.pt
##

namespace eval VsLab:: {
	namespace export VsLab
        #### Read Packages	        
	
	## Lib
       package require GuiVsLab                1.0
       package require Gui_AutoDock            1.0
       package require Gui_AutoGrid            1.0
       package require Gui_Sasa                1.0
       package require Gui_About               1.0
       package require Gui_inputFile           1.0
       package require AutoDock                1.0	
	
       ## Other	
       package require tablelist
       package require sqlite3

        #### Variables Program

		variable img1 ""
		variable version			1.4
		variable progressMessage		"Ready."
		variable progressMax			100
        variable debug                          "YES"
        variable topGui                         ".vslab"
		variable boxLine 			1
        variable arrayLigandPath                ""
        variable arrayligandName                ""
		variable proteinPath			""
        variable ligandPath                     ""
        variable database                       ""
        variable grid_fileName                  ""
        variable grid_size                      ""
        variable grid_center                    ""
        variable grid_spacing                   0.375
		variable grid_selection			"all"
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
		variable lCharge0                       0
		variable lCharge1                       0 

}


proc VsLab::vslab {} {
	if {[winfo exists $::VsLab::topGui]} {wm deiconify $::VsLab::topGui;  return $::VsLab::topGui}

	#### variable reset
	variable ::VsLab::database	""
	
	#### startGui
      	VsLab::startGui
	return $::VsLab::topGui
}

