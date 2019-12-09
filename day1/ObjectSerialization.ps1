

#Result displayed as expected, comment on the property PSComputerName
Invoke-Command -ComputerName MS -ScriptBlock {Get-Service -Name BITS}

#If you check the members, you’ll notice that you are working with Deserialized object (Deserialized.System.ServiceProcess.ServiceController), as it was transferred trough the network and methods are missing. 
#Similar to Export-CliXML, Import-CliXMl 

Invoke-Command -ComputerName MS -ScriptBlock {Get-Service -Name BITS} | Get-Member

#Still if you check the object on the remote session it would be the original object - System.ServiceProcess.ServiceController, with access to methods.
Invoke-Command -ComputerName MS -ScriptBlock {Get-Service -Name BITS}  | Get-Member


##########
