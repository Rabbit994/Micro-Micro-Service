Start-Process -FilePath docker -ArgumentList "stop ps-tests" -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "rm ps-tests" -Wait -NoNewWindow
Start-Process -FilePath docker -ArgumentList "build -t ps-tests -f PStests/ps_test.dockerfile ." -Wait -NoNewWindow
Start-Process -Filepath docker -ArgumentList "run -i --network=""micro_frontend"" --name ps-tests ps-tests" -Wait -NoNewWindow