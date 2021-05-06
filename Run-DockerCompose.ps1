[CmdletBinding()]
param (
    # Parameter help description
    [Parameter(Mandatory=$true,HelpMessage="Execution")]
    [ValidateSet('build','up','stop','down')]
    [string]
    $Action
)
switch($Action){
    "build" {
        Start-Process 'docker-compose' -ArgumentList '--project-name micro build --no-cache' -NoNewWindow -Wait
    }
    "up" {
        Start-Process 'docker-compose' -ArgumentList '--project-name micro up -d --build' -NoNewWindow -Wait
        #Start-Process 'docker' -ArgumentList 'system prune -f'
    }
    "down" {
        Start-Process 'docker-compose' -ArgumentList '--project-name micro down' -NoNewWindow -Wait
    }
    "stop" {
        Start-Process 'docker-compose' -ArgumentList '--project-name micro stop' -NoNewWindow -Wait
    }
}