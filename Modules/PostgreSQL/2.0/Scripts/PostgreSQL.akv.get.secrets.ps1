<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		PostgreSQL.akv.get.secrets.ps1

		Purpose:	Get PostgreSQL Key Secrets as Azure DevOps variables

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
		Get PostgreSQL Key Secrets as Azure DevOps variables.

	.DESCRIPTION
		Get PostgreSQL Key Secrets as Azure DevOps variables.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Get PostgreSQL Secrets
		3) Set Azure DevOps variables

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER postgreSQLName
		Specify the PostgreSQL Name output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\postgreSQL.akv.get.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-postgreSQLName "$(postgreSQLName)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $true)]
	[string]$postgreSQLName
)

#region - Get Azure KeyVault Secret
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	$kvSecretNames = @{ }
	$kvSecretNames.Add("postgreSQLName","postgreSQL--Name--$($postgreSQLName)")
	$kvSecretNames.Add("postgreSQLDBName","postgreSQL--DBName--$($postgreSQLName)")
	$kvSecretNames.Add("postgreSQLResourceId","postgreSQL--ResourceId--$($postgreSQLName)")
	$kvSecretNames.Add("postgreSQLResourceGroup","postgreSQL--ResourceGroup--$($postgreSQLName)")

	$kvSecretNames.Keys | ForEach-Object {
		$key = $psitem
		$value = $kvSecretParameters.Item($psitem)

		$paramGetAzKeyVaultSecret = @{
			VaultName   = $keyVaultName
			Name        = $value
			Verbose     = $true
			ErrorAction = 'SilentlyContinue'
		}
		$secret = (Get-AzKeyVaultSecret @paramGetAzKeyVaultSecret).SecretValueText

		if (-not [string]::IsNullOrWhiteSpace($secret))
		{
			Write-Output "Task Set Variable: $key - $secret"
			Write-Output ("##vso[task.setvariable variable=$key;]$secret")
		}
		else
		{
			Write-Output "KeyVault Secret: $value - []"
		}
	}
}
else
{
	Write-Output "KeyVault Name: []"
}
#endregion