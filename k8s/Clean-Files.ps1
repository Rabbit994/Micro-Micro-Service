Get-ChildItem -Recurse -include *.yaml -Exclude kubeconfig.yaml | where {$_.Name -notlike "*-base.yaml"} | Remove-Item -Force:$true -Confirm:$false