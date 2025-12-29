# ad-setup.ps1: Script de PowerShell para instalar AD DS
# Se ejecuta automáticamente via user_data en AWS

Write-Host "Iniciando la instalacion de Active Directory Domain Services..."

# Instalar el rol de AD DS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Restart

# Esperar a que la máquina se reinicie

# Configurar el nuevo bosque de Active Directory
$domainName = "rafaelcorp.local"
$safeModeAdminPassword = ConvertTo-SecureString "TuContrasenaSegura2025" -AsPlainText -Force

Install-ADDSForest -DomainName $domainName -InstallDns:$true -SafeModeAdministratorPassword $safeModeAdminPassword -Force

Write-Host "Active Directory instalado y configurado para el dominio: $domainName"
