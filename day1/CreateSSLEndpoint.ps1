
#  Execute on computer MS, as remoting is not enabled on Win10 computer

# We need to have a Server Auth Certificate with Private Key
# Creating a self-signed for the demo

Get-ChildItem Cert:\LocalMachine\my -SSLServerAuthentication # No Server Auth certs at the moment

# Creating the cert and store it into a variable
$cert = New-SelfSignedCertificate -Type SSLServerAuthentication -Subject 'MS.Contoso.local' -CertStoreLocation Cert:\LocalMachine\My

# Confirming the existence 
Get-ChildItem Cert:\LocalMachine\my -SSLServerAuthentication

# Export the cert and import it as Trusted Root CA
Export-Certificate -Cert $cert -FilePath .\MS_Cert.cer
Import-Certificate -FilePath .\MS_Cert.cer -CertStoreLocation Cert:\LocalMachine\Root

# For the moment using SSL still does not work. We need to create HTTPS listener with this certificate
Invoke-Command -ComputerName MS.Contoso.local -ScriptBlock {"Testing SSL"} -UseSSL

# Currently only HTTP Listener is available
Get-ChildItem -Path WSMan:\localhost\Listener

# ... and computer listens only on port HTTP = 5985
Get-NetTCPConnection | Where-Object -Property LocalPort -like 598*

# Creating HTTPS Listener with the certificate thumbprint
New-Item -Path WSMan:\localhost\Listener -ItemType Listener -Address * -Transport HTTPS -CertificateThumbPrint $cert.PSChildName  -Force

# Confirming that we have HTTPS listener created
Get-ChildItem -Path WSMan:\localhost\Listener

# ... and that the computer listnens on port HTTPS = 5986 as well
Get-NetTCPConnection | Where-Object -Property LocalPort -like 598*

# No existing connections on HTTPS = 5986
Get-NetTCPConnection -RemotePort 5986 # Result in an error

# Now the using UseSSL parameter works 
Invoke-Command -ComputerName MS.Contoso.local -ScriptBlock {"Testing SSL"} -UseSSL

# Confirming the established connection in TimeWait state
Get-NetTCPConnection -RemotePort 5986

# Remove all

# Remove Listener
Get-ChildItem WSMan:\localhost\Listener\Listener | Where-Object -Property Keys -Like '*HTTPS*' | remove-item -Recurse -Force

# Confirm HTTPS Listener removal
Get-ChildItem -Path WSMan:\localhost\Listener

# Confirm Computer does not listen on port HTTPS = 5986 anymore
Get-NetTCPConnection | Where-Object -Property LocalPort -like 598*

# Remove the certificates from the personal and Root store
Get-ChildItem Cert:\LocalMachine\My\$($cert.PSChildName) | Remove-Item -Force
Get-ChildItem Cert:\LocalMachine\Root\$($cert.PSChildName) | Remove-Item -Force 


##########
