<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		KeyVault.restore.ps1

		Purpose:	KeyVault Restore Automation Script

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
		KeyVault Restore Automation Script

	.DESCRIPTION
		Key Vault Restore Automation Script

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Create temporary folder to download files
		3) Download files from Azure File Share
		4) Restore Key Vault Serects

	.PARAMETER keyVaultName
		Specify the Azure Key Vault Name parameter.

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
		C:\PS>.\KeyVault.restore.ps1
			-keyVaultName "$(keyVaultName)"
			-keyVaultResourceGroup "$(keyVaultResourceGroup)"
			-storageAccountName "$(storageAccountName)"
			-storageResourceGroup "$(storageResourceGroup)"
			-fileshareName "$(fileshareName)"
			-backupFolder "$(backupFolder)"
			-tempRestoreFolder "$(tempRestoreFolder)"
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

	[Parameter(Mandatory = $true)]
	[string]$backupFolder,

	[string]$tempRestoreFolder = "$env:Temp\KeyVaultRestore"
)

#region - Create temporary folder to download files
if (test-path $tempRestoreFolder)
{
	$paramRemoveItem = @{
		Path    = $tempRestoreFolder
		Recurse = $true
		Force   = $true
	}
	Remove-Item @paramRemoveItem
}

$paramNewItem = @{
	ItemType = 'Directory'
	Force    = $true
	Path     = $tempRestoreFolder
}
New-Item @paramNewItem | Out-Null

Write-Output "Starting download of backup to Azure Files"

$paramGetAzStorageAccount = @{
	ResourceGroupName = $storageResourceGroup
	Name              = $storageAccountName
}
$storageAccount = Get-AzStorageAccount @paramGetAzStorageAccount
#endregion

#region - Download files from Azure File Share
$paramGetAzStorageFile = @{
	Context   = $storageAccount.Context
	ShareName = $fileshareName
	Path      = $backupFolderName
}
$backupFolderTest = Get-AzStorageFile @paramGetAzStorageFile

if (-not $backupFolderTest)
{
	Write-Error "Backup folder in Azure File Share Not Found"
	exit
}

$paramGetAzStorageFile = @{
	ShareName = $fileshareName
	Path      = $backupFolder
	Context   = $storageAccount.Context
}
$backupFiles = Get-AzStorageFile @paramGetAzStorageFile | Get-AzStoragefile

foreach ($backupFile in $backupFiles)
{
	Write-Output "downloading $backupFolder\$($backupFile.name)"
	$paramGetAzStorageFileContent = @{
		ShareName   = $fileshareName
		Path        = "$backupFolder\$($backupFile.name)"
		Destination = "$tempRestoreFolder\$($backupFile.name)"
		Context     = $storageAccount.Context
	}
	Get-AzStorageFileContent @paramGetAzStorageFileContent
}
#endregion

#region - Restore secrets to Key Vault
Write-Output "Starting Restore"

$secrets = get-childitem $tempRestoreFolder | where-object { $_ -match "^(secret-)" }
$certificates = get-childitem $tempRestoreFolder | where-object { $_ -match "^(certificate-)" }
$keys = get-childitem $tempRestoreFolder | where-object { $_ -match "^(key-)" }

foreach ($secret in $secrets)
{
	write-output "restoring $($secret.FullName)"
	$paramRestoreAzKeyVaultSecret = @{
		VaultName = $keyVaultName
		InputFile = $secret.FullName
	}
	Restore-AzKeyVaultSecret @paramRestoreAzKeyVaultSecret
}

foreach ($certificate in $certificates)
{
	write-output "restoring $($certificate.FullName)"
	$paramRestoreAzKeyVaultCertificate = @{
		VaultName = $keyVaultName
		InputFile = $certificate.FullName
	}
	Restore-AzKeyVaultCertificate @paramRestoreAzKeyVaultCertificate
}

foreach ($key in $keys)
{
	write-output "restoring $($key.FullName)"
	$paramRestoreAzKeyVaultKey = @{
		VaultName = $keyVaultName
		InputFile = $key.FullName
	}
	Restore-AzKeyVaultKey @paramRestoreAzKeyVaultKey
}

$paramRemoveItem = @{
	Path    = $tempRestoreFolder
	Recurse = $true
	Force   = $true
}
Remove-Item @paramRemoveItem

Write-Output "Restore Complete"
#endregion