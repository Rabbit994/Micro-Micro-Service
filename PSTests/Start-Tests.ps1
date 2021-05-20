#This exists because Pester can't handle .\Invoke-Tests -URI $env:base_url :table_flip:
$container = New-PesterContainer -Path 'Invoke-Tests.ps1' -Data @{URI = $env:base_url}
Invoke-Pester -Container $container -Output Detailed