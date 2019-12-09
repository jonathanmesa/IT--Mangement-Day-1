

#Execute command remotely 

Invoke-Command -ComputerName DC -ScriptBlock {$env:COMPUTERNAME} 				 # confirm executing command remotely
Invoke-Command -ComputerName DC -ScriptBlock {Get-WindowsFeature -Name AD-Domain-Services}  		# Confirm installed ADDS on DC computer

#Execute multiple times, to demonstrate that command is not executing sequentially in the order specified, but parallel – order in property PSComputername will be different
Invoke-Command -ComputerName Win10, DC, MS -ScriptBlock {Get-Service –Name BITS}
Invoke-Command -ComputerName DC, MS -ScriptBlock {Get-Service –Name BITS} -Credential CONTOSO\Administrator 	# Confirm Alternative Credentials being executed remotely


##########
