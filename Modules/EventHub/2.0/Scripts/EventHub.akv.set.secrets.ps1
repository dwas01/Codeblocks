<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		EventHub.akv.set.secrets.ps1

		Purpose:	Set Event Hub Key Secrets

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
		Set Event Hub Key Secrets.

	.DESCRIPTION
		Set Event Hub Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Event Hub Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER namespaceName
		Specify the Event Hub Namespace Name output parameter.

	.PARAMETER namespaceResourceId
		Specify the Event Hub Namespace ResourceId output parameter.

	.PARAMETER namespaceResourceGroup
		Specify the Event Hub Namespace ResourceGroup output parameter.

	.PARAMETER namespaceConnectionString
		Specify the Event Hub Namespace Connection String output parameter.

	.PARAMETER namespacePrimaryKey
		Specify the Event Hub Shared Access Policy Primary Key output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\EventHub.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-namespaceName "$(namespaceName)"
			-namespaceResourceId "$(namespaceResourceId)"
			-namespaceResourceGroup "$(namespaceResourceGroup)"
			-namespaceConnectionString "$(namespaceConnectionString)"
			-namespacePrimaryKey "$(namespacePrimaryKey)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$namespaceName,

	[Parameter(Mandatory = $false)]
	[string]$namespaceResourceId,

	[Parameter(Mandatory = $false)]
	[string]$namespaceResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$namespaceConnectionString,

	[Parameter(Mandatory = $false)]
	[string]$namespacePrimaryKey
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Event Hub Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespaceName']))
	{
		Write-Output "Event Hub Namespace Name: $namespaceName"
		$kvSecretParameters.Add("Namespace--Name--$($namespaceName)", $($namespaceName))
	}
	else
	{
		Write-Output "Event Hub Namespace Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespaceResourceId']))
	{
		Write-Output "Event Hub Namespace ResourceId: $namespaceResourceId"
		$kvSecretParameters.Add("Namespace--ResourceId--$($namespaceName)", $($namespaceResourceId))
	}
	else
	{
		Write-Output "Event Hub Namespace ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespaceResourceGroup']))
	{
		Write-Output "Event Hub Namespace Resource Group: $namespaceResourceGroup"
		$kvSecretParameters.Add("Namespace--ResourceGroup--$($namespaceName)", $($namespaceResourceGroup))
	}
	else
	{
		Write-Output "Event Hub Namespace Resource Group: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespaceConnectionString']))
	{
		Write-Output "Event Hub Namespace Connection String: $namespaceConnectionString"
		$kvSecretParameters.Add("Namespace--ConnectionString--$($namespaceName)", $($namespaceConnectionString))
	}
	else
	{
		Write-Output "Event Hub Namespace Connection String: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespacePrimaryKey']))
	{
		Write-Output "Event Hub Shared Access Policy Primary Key: $namespacePrimaryKey"
		$kvSecretParameters.Add("Namespace--PrimaryKey--$($namespaceName)", $($namespacePrimaryKey))
	}
	else
	{
		Write-Output "Event Hub Shared Access Policy Primary Key: []"
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