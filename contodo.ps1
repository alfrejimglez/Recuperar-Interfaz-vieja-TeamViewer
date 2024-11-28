# Ruta de la clave del registro
$RegPath = "HKCU:\SOFTWARE\TeamViewer"

# Establecer el valor UIVersion en el registro
Set-ItemProperty -Path $RegPath -Name "UIVersion" -Value 1 -Type DWord

# Obtener los permisos actuales de la clave
$Acl = Get-Acl -Path $RegPath

# Crear una regla que deniegue la escritura a todos los usuarios
$DenyRule = New-Object System.Security.AccessControl.RegistryAccessRule(
    "Everyone", "SetValue", "Deny"
)

# Añadir la regla a los permisos actuales
$Acl.SetAccessRule($DenyRule)

# Aplicar los permisos modificados a la clave
Set-Acl -Path $RegPath -AclObject $Acl

Write-Host "Valor UIVersion establecido y permisos de solo lectura aplicados correctamente en $RegPath"
