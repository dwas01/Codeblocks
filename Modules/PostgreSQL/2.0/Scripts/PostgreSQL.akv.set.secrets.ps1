<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		PostgreSQL.akv.set.secrets.ps1

		Purpose:	Set PostgreSQL Key Secrets

		Version: 	2.0.0.0 - 16th February 2020 - Codeblock Development Team
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
		Set PostgreSQL Key Secrets.

	.DESCRIPTION
		Set PostgreSQL Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set PostgreSQL Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER postgreSQLName
		Specify the PostgreSQL Server Name output parameter.

	.PARAMETER postgreSQLDBName
		Specify the PostgreSQL Database Name output parameter.

	.PARAMETER postgreSQLResourceId
		Specify the PostgreSQL ResourceId output parameter.

	.PARAMETER postgreSQLResourceGroup
		Specify the PostgreSQL ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\postgreSQL.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-postgreSQLName "$(postgreSQLName)"
			-postgreSQLDBName "$(postgreSQLDBName)"
			-postgreSQLResourceId "$(postgreSQLResourceId)"
			-postgreSQLResourceGroup "$(postgreSQLResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$postgreSQLName,

	[Parameter(Mandatory = $false)]
	[string]$postgreSQLDBName,

	[Parameter(Mandatory = $false)]
	[string]$postgreSQLResourceId,

	[Parameter(Mandatory = $false)]
	[string]$postgreSQLResourceGroup
)

#region - KeyVault Parameters
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	Write-Output "KeyVault Name: $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Azure database for PostgreSQL Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['postgreSQLName']))
	{
		Write-Output "PostgreSQL Server Name: $postgreSQLName"
		$kvSecretParameters.Add("postgreSQL--Name--$($postgreSQLName)", $($postgreSQLName))
	}
	else
	{
		Write-Output "PostgreSQL Server Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['postgreSQLDBName']))
	{
		Write-Output "PostgreSQL Database Name: $postgreSQLDBName"
		$kvSecretParameters.Add("postgreSQL--DBName--$($postgreSQLName)", $($postgreSQLDBName))
	}
	else
	{
		Write-Output "PostgreSQL Database Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['postgreSQLResourceId']))
	{
		Write-Output "PostgreSQL ResourceId: $postgreSQLResourceId"
		$kvSecretParameters.Add("postgreSQL--ResourceId--$($postgreSQLName)", $($postgreSQLResourceId))
	}
	else
	{
		Write-Output "PostgreSQL ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['postgreSQLResourceGroup']))
	{
		Write-Output "PostgreSQL ResourceGroup: $postgreSQLResourceGroup"
		$kvSecretParameters.Add("postgreSQL--ResourceGroup--$($postgreSQLName)", $($postgreSQLResourceGroup))
	}
	else
	{
		Write-Output "PostgreSQL ResourceGroup: []"
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