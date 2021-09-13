FROM mcr.microsoft.com/powershell
WORKDIR /app
RUN pwsh -command Install-Module Pester -Force
COPY PSTests/Invoke-Tests.ps1 .
COPY PSTests/Start-Tests.ps1 .
ENV base_url=www.micromicroservice.net
CMD ["pwsh", "Start-Tests.ps1"]