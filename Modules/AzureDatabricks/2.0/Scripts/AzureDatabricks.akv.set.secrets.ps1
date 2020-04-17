<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		AzureDatabricks.akv.set.secrets.ps1

		Purpose:	Set Azure Databricks Key Secrets

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
		Set Azure Databricks Key Secrets.

	.DESCRIPTION
		Set Api Management Service Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Azure Databricks Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER databrickName
		Specify the Azure Databricks Name output parameter.

	.PARAMETER databrickResourceId
		Specify the Azure Databricks ResourceId output parameter.

	.PARAMETER databrickResourceGroup
		Specify the Azure Databricks ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\AzureDatabricks.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-databrickName "$(databrickName)"
			-databrickResourceId "$(databrickResourceId)"
			-databrickResourceGroup "$(databrickResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$databrickName,

	[Parameter(Mandatory = $false)]
	[string]$databrickResourceId,

	[Parameter(Mandatory = $false)]
	[string]$databrickResourceGroup
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Azure Databricks Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['databrickName']))
	{
		Write-Output "Azure Databricks Name: $databrickName"
		$kvSecretParameters.Add("Databrick--Name", $($databrickName))
	}
	else
	{
		Write-Output "Azure Databricks Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['databrickResourceId']))
	{
		Write-Output "Azure Databricks ResourceId: $databrickResourceId"
		$kvSecretParameters.Add("Databrick--ResourceId", $($databrickResourceId))
	}
	else
	{
		Write-Output "Azure Databricks ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['databrickResourceGroup']))
	{
		Write-Output "Azure Databrickse ResourceGroup: $databrickResourceGroup"
		$kvSecretParameters.Add("Databrick--ResourceGroup", $($databrickResourceGroup))
	}
	else
	{
		Write-Output "Azure Databricks ResourceGroup: []"
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