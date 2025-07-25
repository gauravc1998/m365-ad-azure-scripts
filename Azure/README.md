Great! Here's a **professional and well-structured README section** you can add to your GitHub repository under `Azure/Get-LastSignInDetails.ps1` to describe the script clearly.

---

## 📄 Script: `Get-LastSignInDetails.ps1`

### 🔍 Overview

This PowerShell script connects to **Microsoft Graph** and retrieves the **last interactive and non-interactive sign-in times** for each user in your **hybrid Azure AD environment**. It's useful for:

* Auditing login activity
* Identifying stale/inactive accounts
* Security and compliance reports

---

### 🛠️ Features

* ✅ Fetches **all Azure AD users**
* ✅ Pulls sign-in logs from the past **X days**
* ✅ Filters by **interactive** and **non-interactive** login types
* ✅ Exports the results to a CSV report

---

### 📂 Output Sample

| DisplayName       | UserPrincipalName                             | LastInteractiveSignIn | LastNonInteractiveSignIn |
| ----------------- | --------------------------------------------- | --------------------- | ------------------------ |
| Jack Lee | [jack.lee@domain.com](mailto:jack.lee@domain.com) | 2025-07-22T14:15:33Z  | 2025-07-20T09:11:08Z     |

---

### 📌 Parameters

```powershell
-DaysBack     # (Optional) Number of days to go back (default: 30)
-ExportPath   # (Optional) Path to save the CSV report (default: Desktop)
```

---

### 🚀 How to Use

```powershell
# Step 1: Install the Microsoft Graph module (if not already installed)
Install-Module Microsoft.Graph -Scope CurrentUser

# Step 2: Run the script
.\Get-LastSignInDetails.ps1 -DaysBack 15
```

---

### 🔐 Required Permissions

To use this script, the account must have the following Microsoft Graph permissions:

* `AuditLog.Read.All`
* `Directory.Read.All`

> These can be granted interactively or via Azure App Registration.

---

### 📦 Use Cases

* 🧑‍💼 Account activity reviews
* 📉 Identifying dormant or risky accounts
* ✅ Periodic login reporting for security teams

