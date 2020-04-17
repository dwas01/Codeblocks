<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		MySQL.akv.set.secrets.ps1

		Purpose:	Set MySQL Database Key Secrets

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
		Set MySQL Database Key Secrets.

	.DESCRIPTION
		Set MySQL Database Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set MySQL Database Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER mySQLName
		Specify the MySQL Database Name output parameter.

	.PARAMETER mySQLResourceId
		Specify the MySQL Database ResourceId output parameter.

	.PARAMETER mySQLResourceGroup
		Specify the MySQL Database ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\MySQL.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-mySQLName "$(mySQLName)"
			-mySQLResourceId "$(mySQLResourceId)"
			-mySQLResourceGroup "$(mySQLResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$mySQLName,

	[Parameter(Mandatory = $false)]
	[string]$mySQLResourceId,

	[Parameter(Mandatory = $false)]
	[string]$mySQLResourceGroup
)

#region - KeyVault Parameters
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	Write-Output "KeyVault Name: $keyVaultName"
	$kvSecretParameters = @{ }

	#region - MySQL Database Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['mySQLName']))
	{
		Write-Output "MySQL Database Name: $mySQLName"
		$kvSecretParameters.Add("MySQL--Name", $($mySQLName))
	}
	else
	{
		Write-Output "MySQL Database Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['mySQLResourceId']))
	{
		Write-Output "MySQL Database ResourceId: $mySQLResourceId"
		$kvSecretParameters.Add("MySQL--ResourceId", $($mySQLResourceId))
	}
	else
	{
		Write-Output "MySQL Database ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['mySQLResourceGroup']))
	{
		Write-Output "MySQL Database ResourceGroup: $mySQLResourceGroup"
		$kvSecretParameters.Add("MySQL--ResourceGroup", $($mySQLResourceGroup))
	}
	else
	{
		Write-Output "MySQL Database ResourceGroup: []"
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