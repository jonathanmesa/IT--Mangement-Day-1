#View the list of all COM objects and show some of them:
$allcom =  Get-ChildItem -path HKLM:\Software\Classes | Where-Object -FilterScript `
{
    $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
}

$allcom | More

#Working with Wscript
#Create a new COM object:
$wscript = new-object -ComObject wscript.shell

#View the object 
$wscript | select *

#Get objects members
$wscript | get-member

#Start a application via the COM object
$wscript.run("utilman")

#Send a message
$wscript.popup("Hello From Windows PowerShell and COM") 


#inetrnet Explorer

$requestUri = "bing.com"


$ie = new-object -ComObject "InternetExplorer.Application"
$ie.visible = $true
$ie.silent = $true
$ie.navigate($requestUri)
while($ie.Busy) { Start-Sleep -Milliseconds 100 }

$ie.AddressBar = $true



#Explorer the Shell.Application com object. Shell.Application is used to perform tasks like navigate the file system using Windows Explorer, launch control panel items and cascade and tile windows on the desktop
#Look at the members
$winshell = new-object -ComObject Shell.Application
$winshell | get-member

#Use a methode of Shell.Application
$winshell.minimizeAll()


#Office automation
#Even these powerpoints for the lab are being generated from about 50 individual PPTs via COM automation of powerpoint

#Look at running word processes
get-process winword

#Open a word document in PowerShell
$Word = New-Object -ComObject Word.Application	#->   Note the application is running but bot yet visible	

#Look at running word processes
get-process winword			#	-> Should be 1 more now while it is not visible on screen

Make word visible
$Word.Visible = $True

#Add a new blank document
$Document = $Word.Documents.Add()

#Add some text 
$Selection = $Word.Selection
$Selection.TypeText("My username is $($Env:USERNAME) and the date is $(Get-Date)")
$Selection.TypeParagraph()
$Selection.Font.Bold = 1
$Selection.TypeText("This is on a new line and bold!")

#Save the document to file and exit
$Report = "C:\temp\MyFirstDocument.docx" 
$Document.SaveAs([ref]$Report,[ref]$SaveFormat::wdFormatDocument)
$word.Quit() 

 #Look at $word again everything is empty and clean due to common language runtime (CLR) garbage collector. Memory will be cleaned up no need to call dispose or GC.Collect()

#Look at $word
$word

#Recreate a new word document this time use strict switch to see it is using the .NET COM Interop
$Word2 = New-Object -ComObject Word.Application -strict

#Jonathan