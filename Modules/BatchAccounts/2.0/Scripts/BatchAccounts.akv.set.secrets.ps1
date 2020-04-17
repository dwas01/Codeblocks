<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		BatchAccounts.akv.set.secrets.ps1

		Purpose:	Set Azure Batch Account Key Secrets

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
		Set Azure Batch Account Key Secrets.

	.DESCRIPTION
		Set Azure Batch Account Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Azure Batch Account Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER batchAccountName
		Specify the Azure Batch Account Name output parameter.

	.PARAMETER batchAccountResourceId
		Specify the Azure Batch Account ResourceId output parameter.

	.PARAMETER batchAccountResourceGroup
		Specify the Azure Batch Account ResourceGroup output parameter.

	.PARAMETER batchAccountPrimaryKey
		Specify the Azure Batch Account PrimaryKey output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\BatchAccounts.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-batchAccountName "$(batchAccountName)"
			-batchAccountResourceId "$(batchAccountResourceId)"
			-batchAccountResourceGroup "$(batchAccountResourceGroup)"
			-batchAccountPrimaryKey "$(batchAccountPrimaryKey)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$batchAccountName,

	[Parameter(Mandatory = $false)]
	[string]$batchAccountResourceId,

	[Parameter(Mandatory = $false)]
	[string]$batchAccountResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$batchAccountPrimaryKey
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Azure Batch Account Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['batchAccountName']))
	{
		Write-Output "Azure Batch Account Name: $batchAccountName"
		$kvSecretParameters.Add("BatchAccount--Name--$($batchAccountName)", $($batchAccountName))
	}
	else
	{
		Write-Output "Azure Batch Account Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['batchAccountResourceId']))
	{
		Write-Output "Azure Batch Account ResourceId: $batchAccountResourceId"
		$kvSecretParameters.Add("BatchAccount--ResourceId--$($batchAccountName)", $($batchAccountResourceId))
	}
	else
	{
		Write-Output "Azure Batch Account ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['batchAccountResourceGroup']))
	{
		Write-Output "Azure Batch Account ResourceGroup: $batchAccountResourceGroup"
		$kvSecretParameters.Add("BatchAccount--ResourceGroup--$($batchAccountName)", $($batchAccountResourceGroup))
	}
	else
	{
		Write-Output "Azure Batch Account ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['batchAccountPrimaryKey']))
	{
		Write-Output "Azure Batch Account PrimaryKey: $batchAccountPrimaryKey"
		$kvSecretParameters.Add("batchAccount--PrimaryKey--$($batchAccountName)", $($batchAccountPrimaryKey))
	}
	else
	{
		Write-Output "Azure Batch Account PrimaryKey: []"
	}
	#endregion

	#region - Set Azure KeyVault Secret
	$kvSecretParameters.Keys | ForEach-Object {
		$key = $psitem
		$value = $kvSecretParameters.Item($psitem)

		if (-not [string]::IsNullOrWhiteSpace($value))
		{
			Write-Output "KeyVault Secret: $key : $value"
			$value = $kvSecretParameters.Item($psitem)
			$paramSetAzKeyVaultSecret = @{
				VaultName   = $keyVaultName
				Name        = $key
				SecretValue = (ConvertTo-SecureString $value -AsPlainText -Force)
				Verbose     = $true
			}
			Set-AzKeyVaultSecret @paramSetAzKeyVaultSecret
		}
		else
		{
			Write-Output "KeyVault Secret: $key - []"
		}
	}
	#endregion
}
else
{
	Write-Output "KeyVault Name: []"
}
#endregion