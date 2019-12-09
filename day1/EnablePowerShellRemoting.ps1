#Check WinRM Service status: 
Get-Service -Name WinRM | Select-Object -Property Name, DisplayName, Status, StartType     # WinRM must be with Status: Running and StartType: Automatic


#Check Firewall: 
Get-NetFirewallRule –Name "WINRM-HTTP-In-TCP*" | Select-Object -Property Name, Enabled, Profile, Description	 #Enabled: False for Public Network profile, True for Private and Domain


# Endpoints: 
Get-PSSessionConfiguration                                                                                                                                                                    # Comment on purpose and permissions
