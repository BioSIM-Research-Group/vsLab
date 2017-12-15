package provide Gui_About 1.0

proc VsLab::About {about}  {

	
	set logo1 {R0lGODlhKwF2AOf/AAABAAcAAAACBQEEABABAQMGAQAGCgsEAhYFAAcJBRoE
ABEHAA4IBiYCAQkMCBwHAyEHAAwOChcLDBINCz0CAhoNByYKAiAMAA8RDigL
ACQMAi0LABIUEScQACsPAzEOADUNARQVEycRCRcYFjATASEWEjsSARkaGDgU
ATYUBz0TACgYESAaFRocGTQXCBwdG0QUAiUcGi0bDywbFUEXAjIbEh8gHj4Z
CikeG0oYAS0gGDEgGUccAkUcCT0eDSIkIjgfFy0iHjsiFD8hFSYoJVQeBDIn
IzknICssKjArKVAmFE0nGkYpHC0vLFomDF8nCDAyL0EuJk0sG0YtJj0xLTM0
MkEzK00zKWIuHzc5N0k1K28tCz45N4IvCEo8Mz0/PH0xDEM+O0k9O048N1U9
MkFCQGE8LW08KoY4DkpFREVHRF9CM1JFQVhEPUlKSJI8EmNHPWtGNJk8EVRN
R01PTFlMSVxNRJdBEmFNRlBST1dRTWtNPXpLNnVNPaNEEVVXVGtSRmFUUKtF
EVxWU49NLnxTRGhYT4RTPlxdW3BaU2JeXLZNFVxhY19hXmJkYW9hXXhgV2lk
YmJmaXNjWoleTMRTGI9gSdBWF3hqZW9tbIdpXYNrXtVaG31tY45pXJRpVndw
ad1aF4psW4RtZtpdFt9cGa1nRnJ1dIBybnl0c+JeG+VgHYl4bupkGJx1ZoN7
dYd6dpJ4a6R0XoB8evJkHe9pJpV+d59+bZCBfYCFh6Z+b5SEeYqGhI2Gf7CB
bqSEeZeIg6CIgJSNho2PjLGIeZSPjY+Rjo2RlKqLfJ2OiZ+OhI+UlqGSjZSW
k5KXmpuWlZ+XkKyXjZqcmZidn7WXiaGcmqWdlqydmMyZhrahmKumpMKhk7up
n7qsprSvrc2uocexqMG0rry2tcm6tsS/vdfBuOTAsNPEvsrJxdzQyuXOxdvW
1fbTxuTY0uPh3+/f2uri2/rf1fbj1+/p6Pjp4//v6Pnz8vX39P727v/7+vv9
+v799Pn+//z/+/7//P///yH5BAEKAP8ALAAAAAArAXYAAAj+AAcIHEiwoMGD
CBMqXMiwocOHECNKnEixosWLGDNq3Mixo8ePIEOKHEmypMmTKFOqXMmypcuX
MGPKnEmzps2bOHPq3Mmzp8+fQIMKHUq0qNGjSJMqXcq0qdOnUKNKnUq1qtWr
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
}
	
########## Frame 1
	grid [frame $about.f1 -bg black] -in $about -row 0 -column 0 -sticky news
	image create photo img2 -data $logo1
	grid [label $about.f1.logo -bg black -image img2 ] -in $about.f1 -row 0 -column 0  -sticky ew
	
########## Frame 2
	grid [ttk::frame $about.f2 ] -in $about  -pady 5 -padx 10 -row 1 -column 0 -sticky news
		
		## text
		grid [text $about.f2.txt -width 51 -relief flat -yscrollcommand [list $about.f2.sry set] ] -in $about.f2 -row 0 -column 0 -pady 10 -sticky news
	
		
		## Scrool_Bar V
      		scrollbar $about.f2.sry -orient vertical -command [list $about.f2.txt  yview]
      		grid $about.f2.sry -in $about.f2 -row 0 -column 1  -sticky ns


		## Scrool_Bar H
      		#scrollbar $about.f2.srx -orient horizontal -command [list $about.f2.txt xview]
      		#grid $about.f2.srx -in $about.f2 -row 1 -column 0 -sticky ew

		
	
		## Inserir o tyexto
	
		$about.f2.txt insert end "Version : 1.0 (Out 2009) \n\n"
		$about.f2.txt insert end "Web site: www.fc.up.pt/pessoas/nscerque/vLab.html \n\n"
	
		$about.f2.txt insert end "Developers:   Maria Joao Ramos        (mjramos@fc.up.pt) \n"
		$about.f2.txt insert end "              Nuno Sousa Cerqueira    (nscerque@fc.up.pt) \n"
		$about.f2.txt insert end "              Joao Ribeiro            () \n\n\n"
	
	
		$about.f2.txt insert end "VsLab Scope: \n\n"

		set txt "Molecular docking is becoming an important part in the process of developing new drugs. There is much docking software that has been successfully used in a myriad of keystone problems, however, as commonly happens with most of the scientific software, the programs are often complex and a deep knowledge is required for the common user to carry out standard steps."
		$about.f2.txt insert end "$txt\n\n"
	
		set txt "This is an obstacle and a cornerstone issue for the research teams in the fields of Chemistry and the Life Sciences, who are interested in conducting this kind of calculations but do not have enough programming skills."
		$about.f2.txt insert end "$txt\n\n"
		
		set txt "To overcome these limitations, we have designed vsLab, an easy-to-use graphical interface for the well known molecular docking software AutoGrid/AutoDock that has been included into VMD as a plug-in. This program allows almost anyone to use AutoDock and AutoGrid for simple docking or for virtual screening campaigns without requiring any deep knowledge about these techniques."
		$about.f2.txt insert end "$txt\n\n"
	
		set txt "The potential associated to this software makes it an attractive choice not only for educational purposes, but also for more advanced users that can use vsLab to increase workflow and productivity of everyday tasks." 
		$about.f2.txt insert end $txt
		
		set txt "\n\n copyright 2009"
		$about.f2.txt insert end $txt
		
		$about.f2.txt configure -state disable
		
	
########## Configure weights	
	grid columnconfigure	$about.f1		0 -weight 1	
	grid columnconfigure	$about.f1.logo		0 -weight 1
	grid rowconfigure 	$about     		1 -weight 1
        grid rowconfigure 	$about.f2     		0 -weight 1
        grid rowconfigure     	$about.f2.txt     	0 -weight 1
	
	grid columnconfigure 	$about  		0 -weight 1
	grid columnconfigure 	$about.f2     		0 -weight 1
	grid columnconfigure    $about.f2.txt     	0 -weight 1
	
}
