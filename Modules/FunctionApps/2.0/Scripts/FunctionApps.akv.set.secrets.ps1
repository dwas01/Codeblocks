<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		FunctionApps.akv.set.secrets.ps1

		Purpose:	Set Function Apps Key Secrets

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
		Set Function Apps Key Secrets.

	.DESCRIPTION
		Set Function Apps Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Function Apps Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER functionAppName
		Specify the Function Apps Name output parameter.

	.PARAMETER functionAppResourceId
		Specify the Function Apps ResourceId output parameter.

	.PARAMETER functionAppResourceGroup
		Specify the Function Apps ResourceGroup output parameter.

	.PARAMETER functionAppStorageAccountName
		Specify the Function Apps Storage Account Name output parameter.		

	.EXAMPLE
		Default:
		C:\PS>.\FunctionApps.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-functionAppName "$(functionAppName)"
			-functionAppResourceId "$(functionAppResourceId)"
			-functionAppResourceGroup "$(functionAppResourceGroup)"
			-functionAppStorageAccountName "$(functionAppStorageAccountName)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$functionAppName,

	[Parameter(Mandatory = $false)]
	[string]$functionAppResourceId,

	[Parameter(Mandatory = $false)]
	[string]$functionAppResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$functionAppStorageAccountName
)

#region - KeyVault Parameters
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	Write-Output "KeyVault Name: $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Virtual Network Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['functionAppName']))
	{
		Write-Output "Function Apps Name: $functionAppName"
		$kvSecretParameters.Add("VirtualNetwork--Name--$($functionAppName)", $($functionAppName))
	}
	else
	{
		Write-Output "Function Apps Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['functionAppResourceId']))
	{
		Write-Output "Function Apps ResourceId: $functionAppResourceId"
		$kvSecretParameters.Add("FunctionApp--ResourceId--$($functionAppName)", $($functionAppResourceId))
	}
	else
	{
		Write-Output "Function Apps ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['functionAppResourceGroup']))
	{
		Write-Output "Function Apps ResourceGroup: $functionAppResourceGroup"
		$kvSecretParameters.Add("FunctionApp--ResourceGroup--$($functionAppName)", $($functionAppResourceGroup))
	}
	else
	{
		Write-Output "Function Apps Storage Account Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['functionAppStorageAccountName']))
	{
		Write-Output "Function Apps Storage Account Name: $functionAppStorageAccountName"
		$kvSecretParameters.Add("FunctionApp--StorageAccountName--$($functionAppName)", $($functionAppStorageAccountName))
	}
	else
	{
		Write-Output "Function Apps Storage Account Name: []"
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
				ErrorAction = 'SilentlyContinue'
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