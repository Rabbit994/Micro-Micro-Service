Start-Process -FilePath docker -ArgumentList "stop pixel-chaos" -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "rm pixel-chaos" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t pixel-chaos -f pixel.dockerfile ." -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "run -d --name pixel-chaos pixel-chaos" -Wait -NoNewWindow