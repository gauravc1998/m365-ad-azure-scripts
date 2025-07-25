<#
.SYNOPSIS
Get all licensed Microsoft 365 users and their assigned licenses.

.DESCRIPTION
This script connects to Microsoft Graph and retrieves user display name, UPN, and license SKU.

.AUTHOR
Gauti1998

.REQUIREMENTS
- Microsoft Graph PowerShell SDK
- Admin permissions
#>

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All", "Directory.Read.All"

# Get all users
$users = Get-MgUser -All -Property DisplayName,UserPrincipalName,AssignedLicenses

# Display users with license info
$users | Where-Object { $_.AssignedLicenses.Count -gt 0 } | Select-Object `
    DisplayName, `
    UserPrincipalName, `
    @{Name="Licenses";Expression={ ($_.AssignedLicenses | ForEach-Object { $_.SkuId }) -join ", " }}

# Disconnect
Disconnect-MgGraph
