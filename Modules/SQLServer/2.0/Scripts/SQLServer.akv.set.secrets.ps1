<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		SQLServer.akv.set.secrects.ps1

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

	.PARAMETER sqlServerName
		Specify the SQL Server Name output parameter.

	.PARAMETER sqlServerResourceId
		Specify the SQL Server ResourceId output parameter.

	.PARAMETER sqlServerResourceGroup
		Specify the SQL Server ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\SQLServer.akv.set.secrects.ps1
			-keyVaultName "$(keyVaultName)"
            -sqlServerName "$(sqlServerName)"
			-sqlServerResourceId "$(sqlServerResourceId)"
			-sqlServerResourceGroup "$(sqlServerResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerName,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerResourceId,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerResourceGroup
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	write-output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - SQL Server Database Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqlServerName']))
	{
		Write-Output "SQL Server Name: $sqlServerName"
		$kvSecretParameters.Add("SqlServer--Name--$($sqlServerName)", $($sqlServerName))
	}
	else
	{
		Write-Output "SQL Server Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqlServerResourceId']))
	{
		Write-Output "SQL Server ResourceId: $sqlServerResourceId"
		$kvSecretParameters.Add("SqlServer--ResourceId--$($sqlServerName)", $($sqlServerResourceId))
	}
	else
	{
		Write-Output "SQL Server ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqlServerResourceGroup']))
	{
		Write-Output "SQL Server ResourceGroup: $sqlServerResourceGroup"
		$kvSecretParameters.Add("SqlServer--ResourceGroup--$($sqlServerName)", $($sqlServerResourceGroup))
	}
	else
	{
		Write-Output "SQL Server ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqldbMedicalConnectionString']))
	{
		Write-Output "SQL Database Medical Connection String: $sqldbMedicalConnectionString"
		$kvSecretParameters.Add("medical--ConnectionStrings--SqlserverConnection--$($sqlServerName)", $($sqldbMedicalConnectionString))
	}
	else
	{
		Write-Output "SQL Database Medical Connection String: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqldbNotificationConnectionString']))
	{
		Write-Output "SQL Database Notification Connection String: $sqldbNotificationConnectionString"
		$kvSecretParameters.Add("notification--ConnectionStrings--SqlserverConnection--$($sqlServerName)", $($sqldbNotificationConnectionString))
		$kvSecretParameters.Add("notification-backgroundtask--ConnectionStrings--SqlserverConnection--$($sqlServerName)", $($sqldbNotificationConnectionString))
	}
	else
	{
		Write-Output "SQL Database Notification Connection String: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqldbUserConnectionString']))
	{
		Write-Output "SQL Database User Connection String: $sqldbUserConnectionString"
		$kvSecretParameters.Add("user--ConnectionStrings--SqlserverConnection--$($sqlServerName)", $($sqldbUserConnectionString))
		$kvSecretParameters.Add("user-backgroundtask--ConnectionStrings--SqlserverConnection--$($sqlServerName)", $($sqldbUserConnectionString))
	}
	else
	{
		Write-Output "SQL Database User String Connection String: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['sqldbHazardConnectionString']))
	{
		Write-Output "SQL Database Hazard Connection String: $sqldbHazardConnectionString"
		$kvSecretParameters.Add("hazard--ConnectionStrings--SqlserverConnection--$($sqlServerName)", $($sqldbHazardConnectionString))
		$kvSecretParameters.Add("hazard-dispatcher--ConnectionStrings--SqlserverConnection--$($sqlServerName)", $($sqldbHazardConnectionString))
		$kvSecretParameters.Add("hazard-backgroundtask--ConnectionStrings--SqlserverConnection--$($sqlServerName)", $($sqldbHazardConnectionString))
	}
	else
	{
		Write-Output "SQL Database Hazard Connection String: []"
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