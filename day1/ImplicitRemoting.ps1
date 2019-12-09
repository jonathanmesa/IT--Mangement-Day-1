 # Create a persistent session
$sess = New-PSSession -ComputerName DC

# Import a single CmdLet into the session
Import-PSSession -Session $sess -CommandName Get-WindowsFeature -Prefix Remote 

# Compare the commands
get-command -Verb Get -Noun *WindowsFeature
 
# Execute the commandlet
Get-WindowsFeature -Name AD-Domain-Services

# Execute the remote cmdlet. Feature installed on the remote computer. 
Get-RemoteWindowsFeature -Name AD-Domain-Services

# Close session
Remove-PSSession -Session $sess

#... and re-create
$sess = New-PSSession -ComputerName DC

# Import module into the session
Import-Module -Name NetTCPIP -PSSession $sess -Prefix Remote

# List Remote Commands
Get-Command -Noun Remote* -Module NetTCPIP

# Execute original command on the local computer 
Get-NetIPConfiguration

# Execute implicit remoting commnad on DC and compare IP Addresses
Get-RemoteNetIPConfiguration
