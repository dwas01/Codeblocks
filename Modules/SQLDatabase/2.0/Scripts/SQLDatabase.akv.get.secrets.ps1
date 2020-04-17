<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		tier2.sqlserverdb.akv.get.secrects.ps1

		Purpose:	Get SQL Server Database KeyVault Secrets as Azure DevOps variables

		Version: 	1.0.0.1 - 1st October 2019 - BUMA Build Release Deployment Team
		==============================================================================================

	.SYNOPSIS
		Get SQL Server Database KeyVault Secrets as Azure DevOps variables.

	.DESCRIPTION
		Get SQL Server Database KeyVault Secrets as Azure DevOps variables.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Get SQL Server Database Secrets
		3) Set Azure DevOps variables

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER sqlServerdbName
		Specify the SQL Server Name output parameter.		

	.EXAMPLE
		Default:
		C:\PS>.\tier2.sqlserverdb.akv.get.secrects.ps1
			-keyVaultName "$(keyVaultName)"
            -sqlServerdbName "$(sqlServerdbName)"			
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerdbName	
)

#region - Get Azure KeyVault Secret
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	$kvSecretNames = @{ }
	$kvSecretNames.Add("sqlServerdbName","SqlServer--Name--$($sqlServerdbName)")
	$kvSecretNames.Add("sqlServerdbResourceId","SqlServer--ResourceId--$($sqlServerdbName)")
	$kvSecretNames.Add("sqlServerdbResourceGroup","SqlServer--ResourceGroup--$($sqlServerdbName)")
	$kvSecretNames.Add("sqldbConnectionString","SqlDB--ConnectionStrings--SqlserverConnection--$($sqlServerdbName)")

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