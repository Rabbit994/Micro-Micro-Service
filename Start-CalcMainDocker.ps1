Start-Process -FilePath docker -ArgumentList "stop calc-main" -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "rm calc-main" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t calc-main -f docker/calc_main.dockerfile ." -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "run -d -p 9001:80 --name calc-main calc-main" -Wait -NoNewWindow