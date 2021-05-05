Start-Process -FilePath docker -ArgumentList "stop nginx-proxy" -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "rm nginx-proxy" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t nginx-proxy -f nginx/DOCKERFILE ." -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "run -d -p 9000:80 --name nginx-proxy nginx-proxy" -Wait -NoNewWindow