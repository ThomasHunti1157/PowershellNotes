    ## PowerShell Notes
    
Directly interfaces with windows

rdp connection command: xfreerdp /u:student /v:10.50.38.32 /dynamic-resolution +glyph-cache +clipboard


**version do matter run in version used by powershell



cmdlets: every command starts with a VERB and ends with a NOUN.

get-command  - lists all the commands
Get-Verb - gives a list of all the verbs
get-command -verb get - obtains a list of get a list of the get verb commands.
get-commmand -noun service - get a list of nouns with service

** in essence capitalization does not matter
cls - will clear screen

tasklist - runs external commmand to bring up all proccesses running 

Makeup of a command - Get-EventLog -LogName Security  - displays a list of security logs

if a command with a space in between it needs quatation marks such as: Get-EventLog -LogName "Security etc"

    ##HELP SYSTEM

Get-Help Get-Process - obtains the help command on the given command afterwards
**good source of info is the microsoft documentation
download help documentation without throwing errors
update-help -force -erroraction silentlycontinueget-childitem or

full help page: get-help get-process -full

get-help *log*   --  throw out any command and options for something using log

get-help -Examples get-process  --  throw out a list of examples for the given command

pull up get help in a gui -- get-help get-process (-online or -showwindow)


OREILLY BOOKS SOURCE FOR (learn windows powershell)

optional and mandatory parameters - you dont need every paramter for a single command to run
(some parameters are implid in a command)

When looking at get-help for commands anything in the square brackets is required in the command.


Get-ChildItem -filter *.exe -path c:\windows -recurse -name -- finds all executables in the windows directory

    ##Aliases
    
$Alias:dir - references the powershell command as Get-ChildItem (also ls does the same thing with the same alias)

Get-alias -Definition get-childitem - shows all aliases that reference this command in powershell

Creating your own alias - Set-Alias edit notepad.exe
remove an alias with command - remove-item alias:edit

**get-host shows all info about the host computer

properties or attributes is similar to the make model of the car

methods are actions that you will be making the object do.

**aliases are not persistent

(Get-process).processname

(Get-Process notepad).kill()
run method of kill against the process of notepad (get process for notepad and kill it)

get-process | get-member

method is something you can do to the object

Get-service | format-table name, status (can redirect to anyway you want to sort)


function fruit-host {
  write-host "Apple"
  write-host "Orange"
  write-host "Banana"
}

function fruit-output {
  write-output "Apple"
  write-output "Orange"
  write-output "Banana"
}

    ##Variable 
    
    get-variable
    $HOME
    
        ##DEFINING A VARIABLE
        
$a = 10  (need a dollar sign to identify a variable)
retrieve a variable = get-variable <variable>
    or
get-childitem variable:a

$a , $b , $c = 2 , 4 , 6

print them out - $a, $b, $c

test-path variable:<variable> - will return true or false for if the variable excists

deleting a variable - remove-variable a   or    del variable:<variable>

$var = "George"
 write-host "hello $var"
 **need double quotes around text if it includes a variable (single quotes do not work will print the literal variable)

find a process running that starts with s -- get-process -name s*

find a list of aliases -- get-alias gal, dir, echo, ?, %, ft

show firewall rules -- show-netfirewallrule 

**use command pipe into get-member to see all hidden attributes EX: date | get-member

using attributes to sort and display

use command | get-member to find attribuites for a given command

Extend the expression further, but this time sort by description, include description, hotfix ID, and install Date.

EX: Get-Hotfix | sort -property Description | ft Description, HotFixID, InstalledOn 

    ##Practical Excercises Variables Basic Commands

update-help -force -erroraction silentlycontinue

get-process 

get-service

write-host or write-output

get-variable or get-childitem or print by calling th variable or use double quotes to print text with variable
remove-variable <variable> 

get-command 

read-host


get-process

get-alias gal, dir, echo, ?, %, ft

show-netfirewallrule 

set-alias gh get-help

$var1=26
$var2=9
$sum=$var1 + $var2
$sub=$var1 - $var2
$prod=$var1 * $var2
$quo=$var1 / $var2    
    
    ##Practical Excercises Pipeline
    
ps | sort -property Starttime -ErrorAction SilentlyContinue | select -skip 1 -First 1 -last 1 | format-table starttime, name

date | select-object -ExpandProperty DayofWeek
(date).DayOfWeek
date | get-member

Get-HotFix

Get-Hotfix | sort -property Description | ft Description, HotFixID, InstalledOn

    ##DAY 2 NOTES
    

  ##ARRAYS

**when running get-process or get-service outputs as an array
find object EX: (Get-Process).GetType()
access parts of that array EX: 
$proc = Get-process
$proc[1]  -- to obtain last one $proc[-1]
$proc -is [array] -- will output true

-find number of items in the lst EX: $proc.Count

-creating an array

$array = 1,5,6,

##polymorphic arrays - storing strings integers and system information

$array = "World", "hello", 5, 10, (Get-Date) (last part of an array is a system value type)

--create an array to add to EX: $array3=@()  -- will come back true as an array even though it has no items in it

**you can also make an array by going line by line 

$array[$array.count-1] 

    ##JAGGED ARRAYS
  
-Nested Array
EX: $jagarray = "joe", "jim", "jan", (1, (('apple', 'pear'), 3), "jay"

puling those strings EX:

$jagarray [3][1][1]

$a = 1,2,3
$a += @(<whatever you want to append to array>)
create a nested array: $a , @(7,8,9)   <that comma adds the nested array>

make  large array @b = @('BOOM') * 20

$TargetingArray = @(
  (39.2566, 45.765753, 'Tehran'),
  (56.2356485, 24.2548575, 'Bejing')
  )
  
  $TargetingArray = @(
  (39.2566, 45.765753, 'Tehran'),
  (56.2356485, 24.2548575, 'Bejing')
  )

  
  pull data from a given array: $TargetingArray[0][1]  #pulls the first pat of the the first item in the list
  
  foreach ($line in $TargetingArray) {
    if ($line[-1] -eq 'Bejing'){
      write-output $line
    }
  }
  
    ##SCRIPT BLOCKS
    
-performing an action inside like a variable
-whatever action is gonna be in curly braces
EX: $myblock = { get-service | format-table name, status }

to run a script block EX: & $myblock  #need a & to run script block

$a = 1
$c = { 1 + 1 }

$a + &$c


    ##SORTING AND GROUPING
    
Get-ChildItem | Sort-Object 
gci | Sort-Object -Descending
gci | Sort-Object -Property Legth -Descending

##Group-Object

Get-Service | Group-Object status

Get-ChildItem | Group-Object {$_.Length -lt 1kb}
                               ^
                       pipeline variable  #variable saying whatever is being passed through the pipeline
                       
1, 3, 5, 8, 2, 10 | Sort-Object
  ^
if each int is put into single quotes it will sort 
  ^
if each int is put into double quotes it will output in the same order as single quotes

1..10 | sort-Object -Property { Get-Random }  -- will initiate a random sort

Get-Process | Select-Object -First 10 

Get-Process | Select_Object name, id, Description -ExpandProperty Description
                                                      ^
                                             Gives the full property    -- such as if you used expandproperty for name it would give you the full name
                           
difference between where and select: where object filters and outputs results when select outputs those exact

Get-Service | Where-Object {$_.Status -eq 'running'}   -- will give each object from get-service command check for which status is runnning and output the result

Get-ChildItem *.txt | Where-Object {$_.Length -lt 100} 

Get-Process | Where {$_.Name -like "*powershell*"} | format-table name, description
                                ^
                      like and match difference is like takes both one is regex and one takes wildcards(like takes wildcards)
                     
                              Get-Process | where {$_.name -eq "idle"} | Format-Table name, Description
                              
1, 2, 3, 1, 2, 3, 1, 2, 3 | Sort-Object | Get-Unique
gci | Measure-Object length

Get-ChildItem | Measure-Object -Property length -- give us how many items are in systen 32
(Get-ChildItem).count

Get-ChildItem | Measure-Object -Property length -Average -Maximum -Minimum -sum

'i bet you all cant wait to graduate' > test.txt
$before = Get-ChildItem 
'4' > test.txt
$after = gci
Compare-Object $before $after -Property length, name
Get-Random
$myTruck = New-Object object 
$myTruck | New-Object Get-Member
#add a property
Add-Member -MemberType NoteProperty -Name -Color Black -InputObject $myTruck
#add a property to an object (short handed)
Add-Member -me NoteProperty -in $myTruck -na Make -va Ford
#add a property through the pipeline **favorite
$myTruck | Add-Member NoteProperty -Name Model -Value F150

##add a method 
Add-Member -MemberType ScriptMethod -InputObject $myTruck -name Drive -Value { "Going on a roadtrip" }
#add a method through a pipeline 
$myTruck | Add-Member ScriptMethod -Name Park -Value { "finding a spot" }
$myTruck | Add-Member ScriptMethod Stop { "coming to a stop" }
**anytime adding a method it is SCRIPTMETHOD

use these methods 

$myTruck.Park()
finding a spot

$Soldier = [PSCustomObject]@{
  "FirstName"   = "Joe"
  "LastName"    = "Snuffy"
  "MilitaryRank"= "SSG"
  "MOS"         = "17c"
  "Position"    = "Host Analyst"
}
$Soldier

difference between arrays and hash tables is key value pair hash table @ curly braces

$a = Get-WmiObject Win32_ComputerSystem
$c = Get-WmiObject Win32_OperatingSystem
$d = Get-WmiObject Win32_BIOS
$e = Get-WmiObject Win32_LogicalDisk

<#
$hostsystem = [PSCustomObject]@{
  "ComputerName"    = "$a"
  "OperatingSystem" = "$c"
  "Version"         = "$c"
  "Manafacturer"    = "$d"
  "Disks"           = "$e"
}
$hostsystem #>

$myobject = New-Object psobject

$myobject | Add-Member -MemberType noteProperty -Name ComputerName -Value $a.Name
$myobject | Add-Member -MemberType noteProperty -Name OperatingSystem -Value $c.Caption
$myobject | Add-Member -MemberType noteProperty -Name Version -Value $c.Version
$myobject | Add-Member -MemberType noteProperty -Name Manafacturer -Value $d.Manafacturer
$myobject | Add-Member -MemberType noteProperty -Name Disks -Value $e._path

$myobject 

    Get-PSDrive -- provides info on the drive 
    
new-psdrive -name HKU -psprovider registry -root HKEY_USERS  -- symbolic link from hive drive users to hkcu

change to drive with cd command

    ##Comparison Operators
    
    -contains or -notcontains 
    -n -- will return a boolean statement true or false to see if it matches or contains
    similar to -notin
    -is -- to see if it is the same type
    
    EX: 
    1,2,3 -eq 2 -- will return 2
    if there are multiple values in a comparitive statement it will retur the one that is different.
    
    combination of comparison operators 
    
    $num = 5
    (($num -gt 1) -and ($num -lt 10))
    (($num -gt 1) -or ($num -lt 10))
    
    conditional statements:
    
$x = 11
if($x -gt 10) {"$x is larger than 10"}
if($x -le 12) {
write-host "$x is not equal to 9" -Foregroundcolor Gray
}

##IF ELSE 

if ("ABC" -eq "ABC") {
write-host "Example 1 - condition satisfied" -foregoundcolor green
}
else {
  write-host "Conditon no satisfied" -foregroundcolor red
  }

    ##SWITCH
    
$fruit = "C" 
switch($fruit) {
  a {"apple"}
  b {"banana"}
  c {"cranberry"}
  }
  
#making a default in a switch statement

    ##LOOPS 

$nums = 1, 2, 3, 4
$nums | ForEach-Object{$_ * 2

$list = 'a', 'b', 'c'
$list | foreach {$_.ToUpper()}

makes all the letters in the list uppercase

Get-ChildItem | ForEach-Object {$_.length / 1kb}

##foreach
Foreach ($item in gci C:\ -Recurse) {$item.name}

Foreach ($num in 1..5) {$num * 2}

foreach array
$teams = "Tiger", "Pistons", "Red Wings", "Lions"
foreach ($team in $teams) {"Detroit $team"}

$num = 0
while ($num -lt 3) {
  $num 
  $num++
  }
  
$num = 0
do {
  $num
  $num++
  }while($num -lt 3)

#do until

$num = 0
do {
  $num
  $num++
}until($num -gt 3)

    #for Loops 
    
for($num = 1; $num -le 3; $num++){$num}

for ($i = 0; $i -le 255; $i++) {
  write-host 192.168.192.$i
  }
  
  ##Reading And Writing to Files
set-content and get-content
  
Set-Content -path .\example.txt -Value "A String"
Get-Content -path .\example.txt
cat .\example.txt
  dns.txt
"a new string" > .\example.txt

"another one" >> .\example.txt

Add-Content -path .\example.txt -Value "another nother one"
Add-Content .\example.txt "another nother nother one"

    ##Powershell Scripts

'"Odoyle Rules"' >Odoyle-script.ps1
.\Odoyle-script.ps1

    ##Here Strings -- very similar to making a very short script to be run  
@'
"Odoyle Rules!"
"more code"
get-service
get-childitem
'@ > Anotherdoyle-script.ps1

    ##Hash Tables
    
-requires an at and a curly brace instead of a paranthase
-requires pairs to be stored in a hash table
-keys are assigned values - similar to a dictionary

$mylist = @{First = "John"; Last = "Doe"; Mid = "Bon"; age = 35}

$mylist.Last
$mylist["last"]
$mylist["first", "Mid", "Last"]
$mylist.Keys
$mylist.Values

$list = @{ element1 = 5; array1 = 1..5; array2 = 6,7,8}

$list.remove("element1")

#to order your list put an order before the @
$list = [order]@{ element1 = 5; array1 = 1..5; array2 = 6,7,8}

$employee1 = @{
    First = "Mary"
    Last = "Hopper"
    ID = "001"
    Job = "Software Developer"
}

$employee2 = @{
    First = "John"
    Last = "Williams"
    Id = "002"
    Job = "Web Developer"
}

$employee1.add("Username", "mhopper001")
$employee2.add("Username", "jwilliams002")
$employee1.Job = "Software Lead"
$employee3 = @{
    First = "alex"
    Last = "moran"
    ID = "003"
    Job = "Software Developer"
}
$employee1.Add("Status", "Management")
$employee2.Add("Status", "Intermediate")
$employee3.Add("Statusprac", "Entry Level")

$employee2.Add("Username", $employee2.First[0]+$employee2.Last+$employee2.id)

    ##Day3
    
 Set-Content
 
 $line1 = "Do you have model number: MT5437 for john.doe@sharklasers.com?"
$line2 = "What model number for john.doe@sharklasers.com?"

$pattern = '[A-Za-z]{2}\d{2,5}'

$line1,$line2 | foreach-object {
    if ($_ -match $pattern){
        write-host $matches[0]": $_"
                        ^
               to retrieve captured text from a loop
        }
        else{
        write-host "No matches found on: $_"
        }
}

    ##Stream Manipulation

-- "text `"quotation marks"`"
"text `"quotation marks`""

$text1 = "One Terabyte is $(1TB \ 1GB) Gigabytes"

"Here is another`nline of text"

$text = @'
Here is some text with `"quotes`".
1TB equals $(1TB / 1GB) GB.
Variables are resolved
"$PWD" is your current path
'@

"{0:n3}" -f 123.45678 -- formatting the last three digits as 3 instead of 5
"{0:d5}" -f 1 -- insures there are at least 5 digits


get-service | select-object -First 10 | ForEach-Object{"The Service {0} is call '{1}' : '{2}" -f $_.Name, $_.DisplayName, $_.Status}

(ipconfig) -match 'IPv6' -- prints line in which the match is found

    ##Regex
    
'server1,server2,server3' -replace '[,]',';'

"Hello Johnathon"  -replace "John" , "Toyot"

(ipconfig) -match 'IPv6'

(qprocess) -replace '\s{2,}', ', ' | select -First 10

$list = 'comp1', 'comp2', 'comp3'
$pattern = 'comp(\d{1,3})'
$list -replace $pattern, 'Computer$1'

$list -replace $pattern, 'Computer$1 (This changed from $0)'

$profile -split '\.'

$profile -split '(?=\.)'

--use -csplit function to enable case sensitive

"Powershell is Awesome!" -match "\w+(\?|!)"
 $matches
 $matches[0]
 
 "10.0.0.122" -as [ipaddress] -as [bool] --this is a good way to find ip addresses
 
    ##Functions
    
 function test-id {
  'Hello World!'
}

function test-me($value) {
  if($value) {
    write-host -foregroundColor Green "True"
    }
    else {
    write-host -ForegoundColor Red "False"
    }
}
function test-me {
  param (
        [Parameter(Mandatory=$true, HelpMessage='Enter a name please')]
        $var
  )
  "Your name is $var"
}

--Exportable file formats
.csv -- Get-Process | Export-Csv C:\Users\student\Desktop\getproc

    ##Error Handling

Try {
  Get-Processes
}
Catch [System.Management.Automation.CommandNotFoundException] {
  Write-Host "Catch 1: the Command is not found!" -ForegroundColor Yellow
}

Get-Process -ErrorAction SilentlyContinue 

    ##System Information
    
Get-CimInstance -query
Get-WmiObject -query


function q ($var1,$var2,$var3,$var4)
{
    ##return sum of variables
    return $var1 + $var2 + $var3 + $var4
}

function q {$file, $line) {

$content = get-content $file 
foreach ($item in $content) {
  if ($i.startswith($line)) {
    return $i
  }
}
return $null
} {


function q($arr) {
  return $arr -join('/')   #When using the join option the \ before any charcater is neccesary for powershell and placed before#
}

function q() {
  return get-process | sort-object -property name -descending
}

function q($arr,$rows,$cols,$key) {
  foreach ($i in $arr) {
    if ($i[0] -eq $key) {
      return $i[9]
    }
  }
  return 
}

**provided on a pipeline wants an advanced function  start of a PROCESS BLOCK

Process {
      command
    }

function add-nums {

  Begin {
    $sum = 0
    }
  Process {
    $sum = $var1 + $var2
  }
}

    ## return date in a specific format
    
    #Custom date w/ -Uformat
    
    $fmt = '%Y%m%d'
    return Get-Date -Uformat $fmt


function Get-SquareNum {
    
    param (
        [Parameter(Mandatory, HelpMessage='Enter a number to b squared')]
        $num
    )
    
    write-output "Your squared number is $($num * $num)"
    }

function Get-Product {
    
    param (
        [Parameter(Mandatory, HelpMessage='Enter a number to b squared')]
        $num,
        $num1,
        $num2
    )
    
    write-output "Your squared number is $($num * $num1 * $num2)"
    }


function Get-Hyp {
    
    param (
        [Parameter(Mandatory, HelpMessage='Enter a number to b squared')]
        $num,
        $num1
    )
    $asq= $($num * $num)
    $bsq= $($num1 * $num1)
    $csq= $($asq + $bsq)
    $ans= [math]::Sqrt($csq)
    write-output "Your Hyp is $ans"
    } (($IPArray1[0] -eq $IPArray2[0]) -and ($IPArray1[1] -eq $IPArray2[1]) -and ($IPArray1[2] -eq $IPArray2[2])) {
Write-Host "True"
} else {
Write-Host "False"
}
function Get-Angle { 
    
    param (
        [Parameter(Mandatory, HelpMessage='Enter a number to b squared')]
        $num,
        $num1
    )
    $ans= $(180 - $num - $num1)
    write-output "Your missing angle is: $ans"
    }

    function Get-Hash {
    
    param (
        [Parameter(Mandatory, HelpMessage='First name, last name, age, and weight in pounds')]
        $FirstName,
        $LastName,
        $Age,
        $Weight
    )
        
        $person = @{
        First = $FirstName
        Last = $LastName
        Age = $Age
        Weight = $Weight
    }
    write-output $person
    }

    function Get-netinfo {
       (ipconfig) -match 'IPv4'
       (ipconfig) -match 'Subnet'
       (ipconfig) -match 'Gateway'
        
    }
    
( Get-ChildItem | Select -First -1).Name

Get-childItem | Format-List *

Typecasting [type]<whatever to be typecasted>
**find types -- Get-TypeData *

[MailAddress]"thohuntington13@gmail.com"

DisplayName User            Host      Address                  
----------- ----            ----      -------                  
            thohuntington13 gmail.com   thohuntington13@gmail.com
            
            
$Names | ForEach-Object -Process {
    Get-Content -Path "C:\data\names\$_\config.txt"     --The $_ will take data from the piped in variable
}
        or
        
$Names.ForEach({Get-Content -Path "C:\data\names\$_\config.txt"}) --shortest method

##TrimStart

  function Get-netinfo {
       $ipv4= (ipconfig) -match 'IPv4'
       $ipv4 = $ipv4.TrimStart("IPv4 Address. . . . . . . . . . . : ")
       write-host "IP: $ipv4"
       $subnet = (ipconfig) -match 'Subnet'
       $subnet = $subnet.TrimStart("Subnet Mask . . . . . . . . . . . : ")
       write-host "Subnet: $subnet"
       $default = (ipconfig) -match 'Gateway' | Select-object 
       $default = $default.TrimStart("Default Gateway . . . . . . . . . : ")
       write-host "Gateway: $default"
        
    }

<# 1 #>
function q1($var1,$var2,$var3,$var4) {
    return $var1 * $var2 * $var3 * $var4

    <# Return the product of the arguments #>
}
function q2($arr,$rows,$cols,$key) {
    foreach ($i in $arr) {
    if ($i[0] -eq $key) {
      return $i[9]
    }
  }
  return -1
    <# Search the 2 dimensional array for the first occurance of key at column index 0
       and return the value at column index 9 of the same row.
       Return -1 if the key is not found.
    #>
}
function q3 {
    $num =0
    $array = @()
    do {
        $num = read-host 
        $array += @($num)
    }until ($num -lt 0)

    return $array | measure -Maximum | select-object -property Maximum | ft -HideTableHeaders | Out-String
    <# In a loop, prompt the user to enter positive integers one at time.
       Stop when the user enters a -1. Return the maximum positive
       value that was entered."
	#>
}
function q4($filename,$whichline) {
    return (Get-Content $filename -TotalCount ($whichline + 1))[-1] 
    
    <# Return the line of text from the file given by the `$filename
	   argument that corresponds to the line number given by `$whichline.
	   The first line in the file corresponds to line number 0."
	#>
}
function q5($path) {
    return get-childitem -path $path | sort-object -property name 
    <# Return the child items from the given path sorted
       ascending by their Name
	#>
}
function q6 {

    param
    (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [array]
    $input
    )

    $Sum = 0
    Foreach ($a in $input) {
        
        $Sum += $a

    }

Return $Sum
    <# Return the sum of all elements provided on the pipeline
	#>
}
function q7 {
    return get-command -noun process 
	<# Return only those commands whose noun is process #>
}
function q8($adjective) {
    return "Powershell is $adjective"
    <# Return the string 'PowerShell is ' followed by the adjective given
	   by the `$adjective argument
	#>    
}
function q9($addr) {
    $ip = '^(?:(?:0?0?\d|0?[1-9]\d|1\d\d|2[0-5][0-5]|2[0-4]\d)\.){3}(?:0?0?\d|0?[1-9]\d|1\d\d|2[0-5][0-5]|2[0-4]\d)$'
    if ($addr -match $ip){
        return $true
    }
    else {
        return $false
    }
	<# Return `$true when the given argument is a valid IPv4 address,
	   otherwise return `$false. For the purpose of this function, regard
	   addresses where all octets are in the range 0-255 inclusive to
	   be valid.
	#>
}


function eAdd($addy)
	realaddy = 
(for finding e level addresses of an ip)
	

function q10 ($filepath,$lasthash) {
    $newhash = (Get-FileHash $filepath).Hash #| select-object -property Hash | ft -HideTableHeaders | Out-string #
    if ($lasthash -eq $newhash) {
        return $false
    }
    else {
        return $true
    }
    
    <# Return `$true if the contents of the file given in the
       `$filepath argument have changed since `$lasthash was
       computed. `$lasthash is the previously computed SHA256
       hash (as a string) of the contents of the file. #>
}
get-help about_system_variables -showwindow

function eclass {

    $addy = "255.123.123.123"
    $ans = $addy -split '\.'
    $ans
    if ((($ans[0] -gt 239) -and ($ans[0] -lt 255)) -and (($ans[1] -ge 0) -and ($ans[1] -lt 256)) -and (($ans[2] -ge 0) -and ($ans[2] -lt 256)) -and (($ans[3] -ge 0) -and ($ans[3] -lt 256))) {
        return $true
    
    } else {
        return $false
    }

}

function pipeline {

    param 
    (
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]
        $pipelinevalue
    )

    $pipelinevalue

}

function arraypipeline {

    param
    (
        [Parameter(Mandatory,ValueFromPipeline)]
        [string[]]
        $pipelinearray

    )
    $pipelinearray


}

function greetings {


    param (
        [Parameter(Mandatory,ValueFromPipeline)]
        $time
    )
    if (($time -gt 0599) -and ($time -lt 1200)) {
        return "Good Morning"
    } elseif (($time -gt 1199) -and ($time -lt 1700)) {
        return "Good Afternoon"
    } elseif (($time -gt 1699) -and ($time -lt 2200)) {
        return "Good Evening"
    } elseif ((($time -gt 2199) -and ($time -lt 2400)) -or (($time -lt 0601) -and ($time -ge 0000))) {
        return "Good Night"
    }else {return "Good Day"}

}












