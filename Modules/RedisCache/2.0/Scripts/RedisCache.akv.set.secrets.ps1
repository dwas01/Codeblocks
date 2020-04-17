<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		RedisCache.akv.set.secrets.ps1

		Purpose:	Set Azure Cache for Redis Key Secrets

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
		Set Azure Cache for Redis Key Secrets.

	.DESCRIPTION
		Set Azure Cache for Redis Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Azure Cache for Redis Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER redisCacheName
		Specify the Azure Cache for Redis Name output parameter.

	.PARAMETER redisCacheResourceId
		Specify the Azure Cache for Redis ResourceId output parameter.

	.PARAMETER redisCacheResourceGroup
		Specify the Azure Cache for Redis ResourceGroup output parameter.

	.PARAMETER redisCacheKey
		Specify the Azure Cache for Redis Primary Key output parameter.

	.PARAMETER redisCacheConnectionString
		Specify the Azure Cache for Redis Connection String output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\RedisCache.akv.set.secrets.ps1
			-redisCacheName "$(redisCacheName)"
			-redisCacheResourceId "$(redisCacheResourceId)"
			-redisCacheResourceGroup "$(redisCacheResourceGroup)"
			-redisCacheKey "$(redisCacheKey)"
			-redisCacheConnectionString "$(redisCacheConnectionString)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$RedisCacheName,

	[Parameter(Mandatory = $false)]
	[string]$RedisCacheResourceId,

	[Parameter(Mandatory = $false)]
	[string]$RedisCacheResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$redisCacheKey,

	[Parameter(Mandatory = $false)]
	[string]$redisCacheConnectionString
)

#region - KeyVault Parameters
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	Write-Output "KeyVault Name: $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Azure Cache for Redis Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['redisCacheName']))
	{
		Write-Output "Azure Cache for Redis Name: $redisCacheName"
		$kvSecretParameters.Add("RedisCache--Name", $($redisCacheName))
	}
	else
	{
		Write-Output "Azure Cache for Redis Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['redisCacheResourceId']))
	{
		Write-Output "Azure Cache for Redis ResourceId: $redisCacheResourceId"
		$kvSecretParameters.Add("RedisCache--ResourceId", $($redisCacheResourceId))
	}
	else
	{
		Write-Output "Azure Cache for Redis ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['redisCacheResourceGroup']))
	{
		Write-Output "Azure Cache for Redis ResourceGroup: $redisCacheResourceGroup"
		$kvSecretParameters.Add("RedisCache--ResourceGroup", $($redisCacheResourceGroup))
	}
	else
	{
		Write-Output "Azure Cache for Redis ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['redisCacheKey']))
	{
		Write-Output "Azure Cache for Redis PrimaryKey: $redisCacheKey"
		$kvSecretParameters.Add("RedisCache--PrimaryKey", $($redisCacheKey))
	}
	else
	{
		Write-Output "Azure Cache for Redis PrimaryKey: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['redisCacheConnectionString']))
	{
		Write-Output "Azure Cache for Redis Connection String: $redisCacheConnectionString"
		$kvSecretParameters.Add("RedisCache--ConnectionString", $($redisCacheConnectionString))
	}
	else
	{
		Write-Output "Azure Cache for Redis Connection String: []"
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