

 # PowerShell Remoting creates a temporary runspace in which it is being executed. 
# When exit or command execution is completed. The runspace is not available any more - all variables, functions, aliases and modules loaded are gone. 

# This is why you cannot access the variables defined
Invoke-Command -ComputerName MS -ScriptBlock {$a = 123; $b = 'abc'; $a; $b}
Invoke-Command -ComputerName MS -ScriptBlock {$a; $b}

# Whenever you are connecting to another machine, a process is being launched on the remote side: wsmprovhost, containing the runspace
# Run multiple times to demonstrate that the process ID is different. This means new process is launched every time
Invoke-Command -ComputerName ms -ScriptBlock {Get-Process -Name wsmprovhost | Format-Table -Property Name, Id}

# To create a persistent session we need to use New-PSSession
# you may specify alternative credentials as well (not required) -Credential Contoso\Administrator
New-PSSession -ComputerName MS -OutVariable sess

# Process id is the same, as it is a persistant session. 
# Run multiple times, to demonstrate consistent Process ID
Invoke-Command -Session $sess -ScriptBlock {Get-Process -Name wsmprovhost | Format-Table -Property Name, Id}

# Because it is persistent all of the variables, aliases, functions and modules will be there each and every time when connected. 

# Declare variables
Invoke-Command -Session $sess -ScriptBlock {$a = 123; $b = 'abc'; $a; $b}

# Call variables multiple times, to demonstrate, that they are available 
Invoke-Command -Session $sess -ScriptBlock {$a; $b}

# If we run again with ComputerName parameter, it creates again a temporary session, where the variables have not been declared and not available
Invoke-Command -ComputerName MS -ScriptBlock {$a; $b}   # returns NULL

# If we check the process, we'll see two results - one for the persistent session and one for the temporary
Invoke-Command -ComputerName MS -ScriptBlock {Get-Process -Name wsmprovhost | Format-Table -Property Name, Id}

#Run multiple times, to demonstrate that one process ID is constant (the persistent session), the other is changing (temporary session)



