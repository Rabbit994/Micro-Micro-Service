FROM mcr.microsoft.com/powershell
WORKDIR /app
RUN pwsh -command Install-Module Pester -Force
COPY pstests/Invoke-Tests.ps1 .
COPY pstests/Start-Tests.ps1 .
ENV base_url=http://micro_nginx-proxy_1
CMD ["pwsh", "Start-Tests.ps1"]