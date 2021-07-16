
if ((Test-Path -Path kubectl.exe) -eq $false){
    throw "You do not have Kubectl installed, please download it and put into k8s folder"
}
if ((Test-Path -Path kubeconfig.yaml) -eq $false){
    throw "Please download kubeconfig.yaml file from your provider and load into k8s folder"
}
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @("--kubeconfig=kubeconfig.yaml",
    "delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/do/deploy.yaml")
}
#Start-Process @params #Digital Ocean already applies Ingress Controllers
#region Calc-Main
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'delete -f', './calc-main/calc-main_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'delete -f', './calc-main/calc-main_ingress.yaml'
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
    'delete -f', './calc-micro/calc-micro_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'delete -f', './calc-micro/calc-micro_ingress.yaml'
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
    'delete -f', './date-main/date-main_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'delete -f', './date-main/date-main_ingress.yaml'
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
    'delete -f', './date-micro/date-micro_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'delete -f', './date-micro/date-micro_ingress.yaml'
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
    'delete -f', './name-main/name-main_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'delete -f', './name-main/name-main_ingress.yaml'
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
    'delete -f', './name-micro/name-micro_service.yaml'
    )
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'delete -f', './name-micro/name-micro_ingress.yaml'
    )
}
Start-Process @params
#endregion

#Region LoadGen
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @('--kubeconfig=kubeconfig.yaml',
    'delete -f', './load-gen/loadgen_service.yaml'
    )
}
Start-Process @params
#endregion