#Show WMI commands:
Get-Command -Noun *wmi*

#Show Cim commands:
Get-Command -Noun *cim*

#List objects:

#List WMI objects: 
Get-WMIObject -List 
(Get-WMIObject –List).count			#-> Should be the same as CIM

#List CIM objects
Get-CIMClass
(Get-CIMClass).count			#-> Should be the same as WMI

#Show some classes
Get-WMIObject –Class Win32_Operatingsystem
Get-CIMInstance –Class Win32_bios

#The prefix CIM or WIN32 don’t matter
Get-WMIObject –Class CIM_PhysicalMemory
Get-CIMInstance –Class Win32_PhysicalMemory

#Using WQL:
Get-CIMInstance -Query "SELECT * FROM Win32_process WHERE PageFileUsage > 50000" 

#Removing a folder
#New-Item -Type Directory -Path c:\cimtest
get-item -Path c:\cimtest
$folder = Get-WMIObject -Query 'Select * From Win32_Directory Where Name ="C:\\cimtest " ' 
Remove-WMIObject -InputObject $folder
get-item -Path c:\cimtest
