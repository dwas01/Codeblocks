<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		tier2.sqlserverdb.akv.set.secrects.ps1

		Purpose:	Set SQL Server Database Key Vault Secrets

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
		Set SQL Server Database Key Vault Secrets.

	.DESCRIPTION
		Set SQL Server Database Key Vault Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set SQL Server Database Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER sqlServerdbName
		Specify the SQL Server Name output parameter.

	.PARAMETER sqlServerdbResourceId
		Specify the SQL Server ResourceId output parameter.

	.PARAMETER sqlServerdbResourceGroup
		Specify the SQL Server ResourceGroup output parameter.

	.PARAMETER sqldbConnectionString
		Specify the SQL Database XXX Connection String output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\tier2.sqlserverdb.akv.set.secrects.ps1
			-keyVaultName "$(keyVaultName)"
            -sqlServerdbName "$(sqlServerdbName)"
			-sqlServerdbResourceId "$(sqlServerdbResourceId)"
			-sqlServerdbResourceGroup "$(sqlServerdbResourceGroup)"
			-sqldbConnectionString "$(sqldbConnectionString)"

#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerdbName,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerdbResourceId,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerdbResourceGroup,

	[Parameter(Mandatory = $false)]
    [string]$sqldbConnectionString
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	write-output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - SQL Server Database Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqlServerdbName']))
	{
		Write-Output "SQL Server Name: $sqlServerdbName"
		$kvSecretParameters.Add("SqlServer--Name--$($sqlServerdbName)", $($sqlServerdbName))
	}
	else
	{
		Write-Output "SQL Server Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqlServerdbResourceId']))
	{
		Write-Output "SQL Server ResourceId: $sqlServerdbResourceId"
		$kvSecretParameters.Add("SqlServer--ResourceId--$($sqlServerdbName)", $($sqlServerdbResourceId))
	}
	else
	{
		Write-Output "SQL Server ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqlServerdbResourceGroup']))
	{
		Write-Output "SQL Server ResourceGroup: $sqlServerdbResourceGroup"
		$kvSecretParameters.Add("SqlServer--ResourceGroup--$($sqlServerdbName)", $($sqlServerdbResourceGroup))
	}
	else
	{
		Write-Output "SQL Server ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqldbMedicalConnectionString']))
	{
		Write-Output "SQL Database Medical Connection String: $sqldbConnectionString"
		$kvSecretParameters.Add("SqlDB--ConnectionStrings--SqlserverConnection--$($sqlServerdbName)", $($sqldbConnectionString))
	}
	else
	{
		Write-Output "SQL Database Connection String: []"
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
			$paramSetAzureKeyVaultSecret = @{
				VaultName   = $keyVaultName
				Name        = $key
				SecretValue = (ConvertTo-SecureString $value -AsPlainText -Force)
				Verbose     = $true
				ErrorAction = 'SilentlyContinue'
			}
			Set-AzKeyVaultSecret @paramSetAzureKeyVaultSecret
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