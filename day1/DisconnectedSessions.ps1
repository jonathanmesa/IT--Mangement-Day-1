# Invoke in disconnected session
Invoke-Command -ComputerName DC -ScriptBlock {Get-Service} -InDisconnectedSession

# Show Session locally
Get-PSSession  

# show session on the remote computer
Get-PSSession -ComputerName DC

# Store session into variable
$sess = Get-PSSession -ComputerName DC

# Demo Connect and Disconnect
# Comment on state and availability
Connect-PSSession -ComputerName DC
Disconnect-PSSession -Session $sess

# Connect and Receive the output
# Receive also connects
Receive-PSSession -Session $sess

# Close the session
Get-PSSession | Remove-PSSession
Get-PSSession -ComputerName DC | Remove-PSSession
