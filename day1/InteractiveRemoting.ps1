# interactive remoting with local credentials: 

Enter-PSSession –ComputerName DC

#Run with current credentials: 

$Env:COMPUTERNAME 				# Confirm logged to remote computer
whoami.exe  				# Confirm using current user credentials
Get-WindowsFeature -Name AD-Domain-Services    		# confirm that you have ADDS installed (obviously DC) 
Exit-PSSession


#Run with alternative credentials:

Enter-PSSession –ComputerName DC –Credentials Contoso\Administrator 	# Password same as for current user
$Env:COMPUTERNAME 					# Confirm logged to remote computer
whoami.exe  					# Confirm using alternative user credentials
Exit-PSSession
