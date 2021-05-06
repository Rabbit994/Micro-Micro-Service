Start-Process -FilePath docker -ArgumentList "stop ps-test" -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "rm ps-test" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t ps-test -f PStests/ps_test.dockerfile ." -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "run -i --network=""micro_frontend"" --name ps-test ps-test" -Wait -NoNewWindow