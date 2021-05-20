Start-Process -FilePath docker -ArgumentList "stop calc-micro" -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "rm calc-micro" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t calc-micro -f docker/calc_micro.dockerfile ." -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "run -d -p 9002:80 --name calc-micro calc-micro" -Wait -NoNewWindow