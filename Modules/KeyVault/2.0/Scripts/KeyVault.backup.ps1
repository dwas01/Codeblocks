<#
	..NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		KeyVault.backup.ps1

		Purpose:	KeyVault Backup Automation Script

		Version: 	2.0.0.0 - 1st October 2019 - Codeblock Development Team
		==============================================================================================

		DISCLAIMER
		==============================================================================================
		This script is not supported under any Microsoft standard support program or service.

		This script is provided AS IS without warranty of any kind.
		Microsoft further disclaims all implied warranties including, without limitation, any
		implied warranties of merchantability or of fitness for a particular purpose.

		The entire risk arising out of the use or performance of the script
		and documentation remains with you. In no event shall Microsoft, its authors,
		or anyone else involved in the creation, production, or delivery of the
		script be liable for any damages whatsoever (including, without limitation,
		damages for loss of business profits, business interruption, loss of business
		information, or other pecuniary loss) arising out of the use of or inability
		to use the sample scripts or documentation, even if Microsoft has been
		advised of the possibility of such damages.

		IMPORTANT
		==============================================================================================
		This script uses or is used to either create or sets passwords and secrets.
		All coded passwords or secrests supplied from input files must be created and provided by the customer.
		Ensure all passwords used by any script are generated and provided by the customer
		==============================================================================================

	.SYNOPSIS
		KeyVault Backup Automation Script

	.DESCRIPTION
		KeyVault Backup Automation Script

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Setup Backup Directory
		3) Backup KeyVault Secrets
		4) Copy Files to Azure Files
		5) Create Backup Folder
		6) Upload Files

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER keyVaultResourceGroup
		Specify the KeyVault Resource Group Name parameter.

	.PARAMETER storageAccountName
		Specify the Storage Account Name parameter.

	.PARAMETER storageResourceGroup
		Specify the Storage Resource Group Name parameter.

	.PARAMETER fileshareName
		Specify the File Share Name parameter.

	.PARAMETER backupFolder
		Specify the Backup Folder parameter.

	.PARAMETER tempRestoreFolder
		Specify the Temp Restore Folder parameter.

	.EXAMPLE
		Default:
		C:\PS>.\KeyVault.backup.ps1
			-keyVaultName "$(keyVaultName)"
			-keyVaultResourceGroup "$(keyVaultResourceGroup)"
			-storageAccountName "$(storageAccountName)"
			-storageResourceGroup "$(storageResourceGroup)"
			-fileshareName "$(fileshareName)"
			-backupFolder "$(backupFolder)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault
#Requires -Module Az.Storage

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $true)]
	[string]$keyVaultResourceGroup,

	[Parameter(Mandatory = $true)]
	[string]$storageAccountName,

	[Parameter(Mandatory = $true)]
	[string]$storageResourceGroup,

	[Parameter(Mandatory = $true)]
	[string]$fileshareName,

	[string]$backupFolder = "$env:Temp\KeyVaultBackup"
)

#region - Setup Backup Directory
if (test-path $backupFolder)
{
	$paramRemoveItem = @{
		Path    = $backupFolder
		Recurse = $true
		Force   = $true
	}
	Remove-Item @paramRemoveItem
}
#endregion

#region - Backup Key Vault Secrets
$paramNewItem = @{
	ItemType = 'Directory'
	Force    = $true
	Path     = $backupFolder
}
New-Item @paramNewItem | Out-Null

Write-Output "Starting backup of KeyVault to local directory"

#region - Certificates
$paramGetAzKeyVaultCertificate = @{
	VaultName = $keyVaultName
}
$certificates = Get-AzKeyVaultCertificate @paramGetAzKeyVaultCertificate

foreach ($cert in $certificates)
{
	$paramBackupAzKeyVaultCertificate = @{
		Name       = $cert.name
		VaultName  = $keyVaultName
		OutputFile = "$backupFolder\certificate-$($cert.name)"
	}
	Backup-AzKeyVaultCertificate @paramBackupAzKeyVaultCertificate | Out-Null
}
#endregion

#region - Secrets
$paramGetAzKeyVaultSecret = @{
	VaultName = $keyVaultName
}
$secrets = Get-AzKeyVaultSecret @paramGetAzKeyVaultSecret

foreach ($secret in $secrets)
{
	if (-not ($certificates.Name -contains $secret.name))
	{
		$paramBackupAzKeyVaultSecret = @{
			Name = $secret.name
			VaultName = $keyvaultName
			OutputFile = "$backupFolder\secret-$($secret.name)"
		}
		Backup-AzKeyVaultSecret @paramBackupAzKeyVaultSecret | Out-Null
	}
}
#endregion

#region - Keys
$paramGetAzKeyVaultKey = @{
	VaultName = $keyVaultName
}
$keys = Get-AzKeyVaultKey @paramGetAzKeyVaultKey

foreach ($kvkey in $keys)
{
	if (-not ($certificates.Name -contains $kvkey.name))
	{
		$paramBackupAzKeyVaultKey = @{
			Name       = $kvkey.name
			VaultName  = $keyVaultName
			OutputFile = "$backupFolder\key-$($kvkey.name)"
		}
		Backup-AzKeyVaultKey @paramBackupAzKeyVaultKey | Out-Null
	}
}
#endregion

Write-Output "Local file backup complete"
#endregion

#region - Copy Files to Azure Files
Write-Output "Starting upload of backup to Azure Files"
$paramGetAzStorageAccount = @{
	ResourceGroupName = $storageResourceGroup
	Name              = $storageAccountName
}
$storageAccount = Get-AzStorageAccount @paramGetAzStorageAccount
$files = Get-ChildItem $backupFolder
$backupFolderName = Split-Path $backupFolder -Leaf
#endregion

#region - Create Backup Folder
$paramGetAzStorageFile = @{
	Context   = $storageAccount.Context
	ShareName = $fileshareName
	Path      = $backupFolderName
}
$backupFolderTest = Get-AzStorageFile @paramGetAzStorageFile

if (-not $backupFolderTest)
{
	$paramNewAzStorageDirectory = @{
		Context = $storageAccount.Context
		ShareName = $fileshareName
		Path    = $backupFolderName
	}
	New-AzStorageDirectory @paramNewAzStorageDirectory
}
#endregion

#region - Upload Files
foreach ($file in $files)
{
	$paramSetAzStorageFileContent = @{
		Context   = $storageAccount.Context
		ShareName = $fileshareName
		Source    = $file.FullName
		Path      = "$backupFolderName\$($file.name)"
		Force     = $true
	}
	Set-AzStorageFileContent @paramSetAzStorageFileContent
}

$paramRemoveItem = @{
	Path    = $backupFolder
	Recurse = $true
	Force   = $true
}
Remove-Item @paramRemoveItem

Write-Output "Upload complete"

Write-Output "Backup Complete"
#endregion