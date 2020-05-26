#Note: For the moment PowerShell Remoting is not enabled on Win10 computer, so use MS

# Using Kerberos - works
Invoke-Command -ComputerName MS.Contoso.Local -ScriptBlock {"Testing Trustedhosts"} -Credential Contoso\Power

# Using NTLM  does not work
Invoke-Command -ComputerName 192.168.1.2 -ScriptBlock {"Testing Trustedhosts"} -Credential Contoso\Power

<#Comment on: 
[192.168.1.2] Connecting to remote server 192.168.1.2 failed with the following error message : The WinRM client cannot
process the request. Default authentication may be used with an IP address under the following conditions: the
transport is HTTPS or the destination is in the TrustedHosts list, and explicit credentials are provided. Use
winrm.cmd to configure TrustedHosts. Note that computers in the TrustedHosts list might not be authenticated. 
#>

# TruestedHosts is empty by default
Get-Item -Path WSMan:\localhost\Client\TrustedHosts

# Add IP to TrustedHosts for MS.contoso.local
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -value 192.168.1.2 -Force	# apply settings
Get-Item -Path WSMan:\localhost\Client\TrustedHosts			# confirm settings

# Using NTLM  Now works
Invoke-Command -ComputerName 192.168.1.2 -ScriptBlock {"Testing Trustedhosts"} -Credential Contoso\Power


# Remove TrustedHosts
Set-Item -Path WSMan:\localhost\Client\TrustedHosts –value "" –Force			# Back to default
Invoke-Command -ComputerName 192.168.1.2 -ScriptBlock {"Testing Trustedhosts"} -Credential Contoso\Power	# Does not work again


##########

