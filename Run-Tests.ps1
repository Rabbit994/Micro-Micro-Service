Write-Host "Pinging"
Invoke-RestMethod -uri 'http://127.0.0.1:9000/math/ping'
Invoke-RestMethod -uri 'http://127.0.0.1:9000/math/api/ping'
Write-Host "Doing Math"
Invoke-RestMethod -Uri 'http://127.0.0.1:9000/math/api/add?number1=15&number2=5' -Method GET
Invoke-RestMethod -Uri 'http://127.0.0.1:9000/math/api/subtract?number1=15&number2=5' -Method GET
Invoke-RestMethod -Uri 'http://127.0.0.1:9000/math/api/multiply?number1=20&number2=5' -Method GET
Invoke-RestMethod -Uri 'http://127.0.0.1:9000/math/api/divide?number1=20&number2=5' -Method GET
Invoke-RestMethod -Uri 'http://127.0.0.1:9000/math/api/expo?number1=20&number2=5' -Method GET
Invoke-RestMethod -Uri 'http://127.0.0.1:9000/math/api/remainder?number1=22&number2=5' -Method GET
$a = @{
    op = "add"
    number1 = 5
    number2 = 1616981
}
Invoke-RestMethod -Uri http://127.0.0.1:9000/math/calc -Method POST -Body ($a | ConvertTo-Json)

