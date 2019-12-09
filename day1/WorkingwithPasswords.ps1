

# Create credentials object
$UserName = 'Contoso\Administrator'
$secureString = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force

# Result
$secureString

# Create PSCredential object
$cred = New-Object -TypeName PSCredential -ArgumentList $UserName, $secureString
# Result
$cred

# Demo that it works with the created credentials
Invoke-Command -ComputerName MS -ScriptBlock {whoami} -Credential $cred

# Convert secure string as  encrypted string. 
$encryptedString = ConvertFrom-SecureString -SecureString $secureString

# Result
$encryptedString

# Convert back to Secure string
$convertedString = ConvertTo-SecureString -String $encryptedString

# Result
$convertedString

# Create PSCredential object with the converted secure string
$convertedCred = New-Object -TypeName PSCredential -ArgumentList $UserName, $convertedString

# Result
$convertedCred
$ConvertedCred.GetNetworkCredential().Password

# Demo that it works again
Invoke-Command -ComputerName ms -ScriptBlock {whoami} -Credential $convertedCred

# Cannot construct secure string from encrypted string, as it is encrypted twice : User and Computer
# Demo: When try to reconstruct secure string from encrypted string on another machine - it fails! 
Invoke-Command -ComputerName DC -ScriptBlock {$using:encryptedString}  # sending the credentials
Invoke-Command -ComputerName DC -ScriptBlock {ConvertTo-SecureString -String $using:encryptedString} # try to re-construct - fails!
# Result: Key not valid for use in specified state. 


##########
