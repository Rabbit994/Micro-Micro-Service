[CmdletBinding()]
param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $HostName,
    # Parameter help description
    [Parameter(Mandatory=$false)]
    [switch]
    $LoadGen
)
if ((Test-Path -Path kubectl.exe) -eq $false){
    throw "You do not have Kubectl installed, please download it and put into k8s folder"
}
if ((Test-Path -Path kubeconfig.yaml) -eq $false){
    throw "Please download kubeconfig.yaml file from your provider and load into k8s folder"
}

#region Setup Ingress Files
(Get-Content ./calc-micro/calc-micro_ingress-base.yaml) -replace "{hostname}","$($HostName)" | Set-Content ./calc-micro/calc-micro_ingress.yaml
(Get-Content ./calc-main/calc-main_ingress-base.yaml) -replace "{hostname}","$($HostName)" | Set-Content ./calc-main/calc-main_ingress.yaml
(Get-Content ./date-main/date-main_ingress-base.yaml) -replace "{hostname}","$($HostName)" | Set-Content ./date-main/date-main_ingress.yaml
(Get-Content ./date-micro/date-micro_ingress-base.yaml) -replace "{hostname}","$($HostName)" | Set-Content ./date-micro/date-micro_ingress.yaml
(Get-Content ./name-main/name-main_ingress-base.yaml) -replace "{hostname}","$($HostName)" | Set-Content ./name-main/name-main_ingress.yaml
(Get-Content ./name-micro/name-micro_ingress-base.yaml) -replace "{hostname}","$($HostName)" | Set-Content ./name-micro/name-micro_ingress.yaml
#endregion

#region Setup secret
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    "create secret generic baseurl --from-literal=uri=http://$($HostName)"
    )
}
Start-Process @params
#region Calc-Main
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './calc-main/calc-main_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './calc-main/calc-main_ingress.yaml'
    )
}
#endregion
#region calc-micro
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './calc-micro/calc-micro_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './calc-micro/calc-micro_ingress.yaml'
    )
}
#endregion
#region date-main
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './date-main/date-main_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './date-main/date-main_ingress.yaml'
    )
}
Start-Process @params
#endregion
#region date-micro
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './date-micro/date-micro_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './date-micro/date-micro_ingress.yaml'
    )
}
Start-Process @params
#endregion
#region name-main
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './name-main/name-main_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './name-main/name-main_ingress.yaml'
    )
}
Start-Process @params
#endregion
#region name-micro
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './name-micro/name-micro_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'apply -f', './name-micro/name-micro_ingress.yaml'
    )
}
Start-Process @params
#endregion

#region LoadGen
if ($LoadGen){
    $params = @{
        Filepath = "kubectl.exe"
        NoNewWindow = $true
        Wait = $true
        ArgumentList = @('--kubeconfig=kubeconfig.yaml',
        'apply -f', './load-gen/loadgen_service.yaml'
        )
    }
}
#endregion
