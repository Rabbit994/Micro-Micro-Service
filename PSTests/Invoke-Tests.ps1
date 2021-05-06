[CmdletBinding()]
param (
    # URI To test
    [Parameter(Mandatory=$true,HelpMessage="Base URI to test")]
    [string]
    $URI
)
#Check for Pester being installed, install if it's not
if ($null -eq (Get-Module Pester -ListAvailable)){ 
    Install-Module Pester
}
#Remove trailing / if passed
if ($URI.Substring($URI.Length - 1) -eq "/") {
    $URI = $URI.Substring(0,$URI.Length -1) 
}
Describe "Check for server online" -Tags "Ping"{
    Context "Ping Check"{
        It "Math Main is Online" {
            $testuri = "$($URI)/math/ping"
            Invoke-RestMethod $testuri | Should -Be "pong"
        }
        It "Math Micro is Online" {
            $testuri = "$($URI)/math/api/ping"
            Invoke-RestMethod $testuri | Should -Be "pong"
        }
        It "Date Main is Online" {
            $testuri = "$($URI)/date/ping"
            Invoke-RestMethod $testuri | Should -Be "pong"
        }
        It "Date Micro is Online" {
            $testuri = "$($URI)/date/api/ping"
            Invoke-RestMethod $testuri | Should -Be "pong"
        }
    }
}
Describe "Math Service" -Tags "Math Micro" {
    Context "Micro" {
        #All Invoke-RestMethods is due to return of Invoke-RestMethod and Json Comparsion is best way to confirm
        It "Add Online" {
            (Invoke-RestMethod -Uri "$($URI)/math/api/add?number1=15&number2=5" | ConvertTo-JSON) | Should -Be (@{result = 20} | ConvertTo-JSON)
        }
        It "Subtract Online" {
            (Invoke-RestMethod -Uri "$($URI)/math/api/subtract?number1=15&number2=5" | ConvertTo-JSON) | Should -Be (@{result = 10} | ConvertTo-Json)
        }
        It "Multiply Online" {
            (Invoke-RestMethod -Uri "$($URI)/math/api/multiply?number1=15&number2=5" | ConvertTo-Json) | Should -Be (@{result = 75} | ConvertTo-Json)
        }
        It "Divide Online" {
            (Invoke-RestMethod -Uri "$($URI)/math/api/divide?number1=15&number2=5" | ConvertTo-Json) | Should -Be (@{result = 3} | ConvertTo-Json)
        }
        It "Expo Online" {
            (Invoke-RestMethod -Uri "$($URI)/math/api/expo?number1=15&number2=5" | ConvertTo-Json) | Should -Be (@{result = 759375} | ConvertTo-Json)
        }
        It "Remainder Online" {
            (Invoke-RestMethod -Uri "$($URI)/math/api/remainder?number1=22&number2=5" | ConvertTo-Json) | Should -Be (@{result = 2} | ConvertTo-Json)
        }
    }
    Context "Main" {
        It "Calc Online" {
            $a = @{
                op = 'add'
                number1 = 23
                number2 = 19
            }
            (Invoke-RestMethod -Uri "$($URI)/math/calc" -Method POST -Body ($a | ConvertTo-JSON) | ConvertTo-JSON) | Should -Be (@{result = 42} | ConvertTo-Json)
        }
    }
}
Describe "Date Service" -Tags "Date" {
    Context "Micro" {
        It "Day Online" {
            $date = Get-Date
            (Invoke-RestMethod -Uri "$($URI)/date/api/today_day" | ConvertTo-Json) | Should -Be (@{day = ($date.ToUniversalTime().day)} | ConvertTo-Json)
        }
        It "Month Online" {
            $date = Get-Date
            (Invoke-RestMethod -Uri "$($URI)/date/api/today_month" | ConvertTo-Json) | Should -Be (@{month = ($date.ToUniversalTime().month)} | ConvertTo-Json)
        }
        It "Year Online" {
            $date = Get-Date
            (Invoke-RestMethod -Uri "$($URI)/date/api/today_year" | ConvertTo-Json) | Should -Be (@{year = ($date.ToUniversalTime().year)} | ConvertTo-Json)
        }
    }
    Context "Main" {
        It "Today Online" {
            $body = @{
                format = 'american'
            }
            $result = Invoke-RestMethod -Uri "$($URI)/date/today" -Method POST -Body ($body | ConvertTo-JSON)
            $date = Get-Date
            $fdate = "$($date.ToUniversalTime().month)/$($date.ToUniversalTime().day)/$($date.ToUniversalTime().year)"
            ($result | ConvertTo-Json) | Should -Be (@{today = $fdate} | ConvertTo-JSON)
        }
    }
}