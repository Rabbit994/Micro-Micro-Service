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
    "apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/do/deploy.yaml")
}
Start-Process @params
$params = @{
    Filepath = "kubectl.exe"
    NoNewWindow = $true
    Wait = $true
    ArgumentList = @("--kubeconfig=kubeconfig.yaml",
    "apply -f calc-micro_service.yaml"
    )
}
Start-Process @params

