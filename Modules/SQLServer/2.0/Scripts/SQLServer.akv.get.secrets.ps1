<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		SQLServer.akv.get.secrects.ps1

		Purpose:	Get SQL Server Database KeyVault Secrets as Azure DevOps variables

		Version: 	1.0.0.0 - 1st October 2019 - Azure Virtual Datacenter Development Team
		==============================================================================================

	.SYNOPSIS
		Get SQL Server KeyVault Secrets as Azure DevOps variables.

	.DESCRIPTION
		Get SQL Server KeyVault Secrets as Azure DevOps variables.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Get SQL Server Secrets
		3) Set Azure DevOps variables

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER sqlServerName
		Specify the SQL Server Name output parameter.		

	.EXAMPLE
		Default:
		C:\PS>.\SQLServer.akv.get.secrects.ps1
			-keyVaultName "$(keyVaultName)"
			-sqlServerName "$(sqlServerName)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerName	
)

#region - Get Azure KeyVault Secret
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	$kvSecretNames = @{ }
	$kvSecretNames.Add("sqlServerName","SqlServer--Name--$($sqlServerName)")
	$kvSecretNames.Add("sqlServerResourceId","SqlServer--ResourceId--$($sqlServerName)")
	$kvSecretNames.Add("sqlServerResourceGroup","SqlServer--ResourceGroup--$($sqlServerName)")

	$kVSecretNames.Keys | ForEach-Object {
		$key = $psitem
		$value = $kvSecretParameters.Item($psitem)

		$paramGetAzureKeyVaultSecret = @{
			VaultName   = $keyVaultName
			Name	    = $value
			Verbose     = $true
			ErrorAction = 'SilentlyContinue'
		}
		$secret = (Get-AzKeyVaultSecret @paramGetAzureKeyVaultSecret).SecretValueText

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