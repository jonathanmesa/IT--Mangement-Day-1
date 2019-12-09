
#Commands that have parameter ComputerName
Get-Command -ParameterName ComputerName 


Invoke-Command –ComputerName $env:ComputerName –ScriptBlock {“$env:ComputerName”} 	#Works. PowerShell Remoting enabled, WinRM Service running

Stop-Service –name WinRM  

Invoke-Command –ComputerName $env:ComputerName –ScriptBlock {“$env:ComputerName”} 	#Does not work, as WinRM service stopped

Get-Process –Name System –ComputerName $env:ComputerName	 # Still, this option works, as it uses NativeOS Remoting and does not rely on PowerShell Remoting

Start-Service –name WinRM
