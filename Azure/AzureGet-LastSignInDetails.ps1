<#
.SYNOPSIS
Get the last interactive and non-interactive sign-in date for all users in Azure AD.

.DESCRIPTION
This script uses Microsoft Graph to pull the most recent interactive and non-interactive sign-in logs per user in a hybrid Azure AD environment.

.AUTHOR
Gauti1998

.REQUIREMENTS
- Microsoft Graph PowerShell SDK
- Azure AD AuditLog.Read.All & Directory.Read.All permissions

.OUTPUT
Exports data to a CSV file on your Desktop

.EXAMPLE
.\Get-LastSignInDetails.ps1 -DaysBack 30
#>

param (
    [int]$DaysBack = 30,
    [string]$ExportPath = "$env:USERPROFILE\Desktop\LastSignInReport.csv"
)

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "AuditLog.Read.All", "Directory.Read.All"
$startDate = (Get-Date).AddDays(-$DaysBack).ToString("yyyy-MM-ddTHH:mm:ssZ")

Write-Host "`n⏳ Fetching sign-in logs for the last $DaysBack days..." -ForegroundColor Cyan

# Pull all users
$allUsers = Get-MgUser -All -Property Id, DisplayName, UserPrincipalName

# Pull all sign-ins in the given time range
$signIns = Get-MgAuditLogSignIn -Filter "createdDateTime ge $startDate" -All

# Group by UPN
$userSignInData = foreach ($user in $allUsers) {
    $userLogs = $signIns | Where-Object { $_.UserPrincipalName -eq $user.UserPrincipalName }

    $lastInteractive = ($userLogs | Where-Object { $_.SignInEventTypes -contains "interactiveUser" } | Sort-Object CreatedDateTime -Descending | Select-Object -First 1).CreatedDateTime
    $lastNonInteractive = ($userLogs | Where-Object { $_.SignInEventTypes -contains "nonInteractiveUser" } | Sort-Object CreatedDateTime -Descending | Select-Object -First 1).CreatedDateTime

    [PSCustomObject]@{
        DisplayName            = $user.DisplayName
        UserPrincipalName      = $user.UserPrincipalName
        LastInteractiveSignIn  = if ($lastInteractive) { $lastInteractive } else { "N/A" }
        LastNonInteractiveSignIn = if ($lastNonInteractive) { $lastNonInteractive } else { "N/A" }
    }
}

# Export to CSV
$userSignInData | Export-Csv -Path $ExportPath -NoTypeInformation -Encoding UTF8

Write-Host "`n✅ Report exported to:`n$ExportPath" -ForegroundColor Green

Disconnect-MgGraph

