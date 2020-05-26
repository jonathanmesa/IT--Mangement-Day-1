#Working with a custom object
#Create a custom object
$customobject = new-object -TypeName PSCustomObject		#-> Note it is empty by default 

#Validate it is empty
$customobject

#Show that Custom Object is an empty template that you can use to add types to.
#Use the custom object to restructure the data  about the c:\windows location.
$Result = @()
foreach ( $file in Get-ChildItem -Path c:\windows -file )
{
    $temp = new-object -TypeName PSCustomObject
    $temp | Add-Member -MemberType NoteProperty -Name filename -Value $file.name
    $temp | Add-Member -MemberType NoteProperty -Name path -Value $file.fullname
    $temp | Add-Member -MemberType NoteProperty -Name "size(Mb)" -Value ($file.length /1mb)
    $Result += $temp
}
$Result

#############################################################

#Same code adding hash tables via Select-Object
$Result2 = Get-ChildItem -Path c:\windows -file | Select-Object -Property `
@{name="Filename";Expression={$_.name}}, `
@{name="Path";Expression={$_.fullname}}, `
@{name="Size(MB)";Expression={$_.length /1mb}} 
$Result2 

#Or using single hash table to add onto the array		->  Note the output is no longer a nice table
$Result3 = @()
foreach ( $file in Get-ChildItem -Path c:\windows -file )
{
    $temp = `
    @{
        "Filename" = $file.name
        "Path" = $file.fullname
        "Size(MB)" = $file.length /1mb
     }
     $Result3 += $temp
}
$Result3 

#Using type casting to add a hashtable as pscustomobject to the array		->  Note the output is a nice table again
$Result4 = @()
foreach ( $file in Get-ChildItem -Path c:\windows -file )
{
    $temp = `
    [pscustomobject]@{
        "Filename" = $file.name
        "Path" = $file.fullname
        "Size(MB)" = $file.length /1mb
     }
     $Result4 += $temp
}


$Result4 


#Example 

$computerInfo = Get-CimInstance 'Win32_ComputerSystem' # contains information from Get-CimInstance Win32_ComputerSystem.
$osInfo =  Get-CimInstance 'Win32_OperatingSystem'#  contains information from Get-CimInstance Win32_OperatingSystem.
$diskInfo = Get-CimInstance 'Win32_LogicalDisk' # contains information from Get-CimInstance Win32_LogicalDisk.

[hashtable]$objectProperty = @{}

$objectProperty.Add('ComputerName',$computerInfo.Name)
$objectProperty.Add('OS',$osInfo.Caption)
$objectProperty.Add('OS Version',$("$($osInfo.Version) Build $($osInfo.BuildNumber)"))
$objectProperty.Add('Domain',$computerInfo.Domain)
$objectProperty.Add('DomainJoined',$computerInfo.PartOfDomain)
$ObjectProperty.Add('Disks',$diskInfo)


$ourObject = New-Object -TypeName psobject -Property $objectProperty
$ourObject 

#Jonathan
