#This supports Azure Container Registry
[CmdletBinding()]
param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $RegistryName,
    # Parameter help description
    [Parameter(Mandatory=$false)]
    [string]
    $ResourceGroupName = "Kubes-Training"
)
Import-Module Az -ErrorAction Stop
Connect-AzAccount
New-AzResourceGroup -Name $ResourceGroupName -Location eastus2 -Force
New-AzContainerRegistry -ResourceGroupName $ResourceGroupName -Name $RegistryName -Sku "Basic" -EnableAdminUser
Connect-AzContainerRegistry -Name $RegistryName
Set-Location ..
$RegistryFQDN = "$($RegistryName).azurecr.io"
Start-Process -FilePath docker -ArgumentList "build -t $($RegistryFQDN)/calc-main:latest -f docker/calc_main.dockerfile ." -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "push $($RegistryFQDN)/calc-main:latest" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t $($RegistryFQDN)/calc-micro:latest -f docker/calc_micro.dockerfile ." -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "push $($RegistryFQDN)/calc-micro:latest" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t $($RegistryFQDN)/date-main:latest -f docker/date_main.dockerfile ." -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "push $($RegistryFQDN)/date-main:latest" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t $($RegistryFQDN)/date-micro:latest -f docker/date_micro.dockerfile ." -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "push $($RegistryFQDN)/date-micro:latest" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t $($RegistryFQDN)/name-main:latest -f docker/name_main.dockerfile ." -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "push $($RegistryFQDN)/name-main:latest" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t $($RegistryFQDN)/name-micro:latest -f docker/name_micro.dockerfile ." -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "push $($RegistryFQDN)/name-micro:latest" -Wait -NoNewWindow
Set-Location k8s
$creds = Get-AzContainerRegistryCredential -ResourceGroupName $ResourceGroupName -Name $RegistryName
$params = @{
    FilePath = "kubectl"
    ArgumentList = @("--kubeconfig=kubeconfig.yaml",
        "create secret docker-registry regcred --docker-server=$($RegistryFQDN) --docker-username=$($creds.Username) --docker-password=$($creds.Password)")
    NoNewWindow = $true
    Wait = $true
}
Start-Process @params
(Get-Content ./calc-micro/calc-micro_service-base.yaml) -replace "{registryname}","$($RegistryFQDN)" | Set-Content ./calc-micro/calc-micro_service.yaml
(Get-Content ./calc-main/calc-main_service-base.yaml) -replace "{registryname}","$($RegistryFQDN)" | Set-Content ./calc-main/calc-main_service.yaml
(Get-Content ./date-main/date-main_service-base.yaml) -replace "{registryname}","$($RegistryFQDN)" | Set-Content ./date-main/date-main_service.yaml
(Get-Content ./date-micro/date-micro_service-base.yaml) -replace "{registryname}","$($RegistryFQDN)" | Set-Content ./date-micro/date-micro_service.yaml
(Get-Content ./name-main/name-main_service-base.yaml) -replace "{registryname}","$($RegistryFQDN)" | Set-Content ./name-main/name-main_service.yaml
(Get-Content ./name-micro/name-micro_service-base.yaml) -replace "{registryname}","$($RegistryFQDN)" | Set-Content ./name-micro/name-micro_service.yaml
