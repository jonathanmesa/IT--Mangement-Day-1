#Recap from Foundations
#Create a variable storing a string object, and check its members and datatype
$var= "Hello World"
$var | Get-Member
$var.GetType()

#Due to everything being a object makes it possible to use the pipeline.  PowerShell can uses its binding logic to positionally bind the objects properties to the next cmdlet parameters.
$var | Out-File –path c:\temp\helloworld.txt

#Check the dataTypes available by default
Get-TypeData | Sort-Object -Property typename

#Inspect a type
[datetime] | fl

#Show some properties and methods of an object
$today = get-date
$today | get-member

#Properties:
$today.month
$today.Ticks
$today.DayOfYear
#Methods:
$today.adddays(-$today.DayOfYear)
$today.IsDaylightSavingTime()
$today.tostring("yyyy-MM-dd,yy-dd-MM")

#Inspect static members and demo some
Get-Member -InputObject ([System.DateTime])  -Static
[System.DateTime]::Today
[System.DateTime]::IsLeapYear(2068)
[System.Net.IPAddress]::Loopback
[System.Guid]::NewGuid()

