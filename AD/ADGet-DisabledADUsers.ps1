<#
.SYNOPSIS
List all disabled users from on-premises Active Directory.

.DESCRIPTION
Fetches all user accounts in Active Directory where the 'Enabled' property is False.

.AUTHOR
Gauti1998

.REQUIREMENTS
- Run on a domain-joined system
- ActiveDirectory PowerShell module

.EXAMPLE
.\Get-DisabledADUsers.ps1
#>

# Import AD module (required if running standalone)
Import-Module ActiveDirectory

# Get all disabled users
$disabledUsers = Get-ADUser -Filter {Enabled -eq $false} -Properties DisplayName, SamAccountName, EmailAddress, Enabled

# Display the results
$disabledUsers | Select-Object DisplayName, SamAccountName, EmailAddress | Format-Table -AutoSize
