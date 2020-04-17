<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ApplicationGateway.akv.set.secrets.ps1

		Purpose:	Set Application Gateway Key Secrets

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
		Set Application Gateway Key Secrets.

	.DESCRIPTION
		Set Api Management Service Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Application Gateway Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER applicationGatewayName
		Specify the Application Gateway Name output parameter.

	.PARAMETER applicationGatewayResourceId
		Specify the Application Gatewaye ResourceId output parameter.

	.PARAMETER applicationGatewayResourceGroup
		Specify the Application Gateway ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\ApplicationGateway.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-applicationGatewayName "$(applicationGatewayName)"
			-applicationGatewayResourceId "$(applicationGatewayResourceId)"
			-applicationGatewayResourceGroup "$(applicationGatewayResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$applicationGatewayName,

	[Parameter(Mandatory = $false)]
	[string]$applicationGatewayResourceId,

	[Parameter(Mandatory = $false)]
	[string]$applicationGatewayResourceGroup
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	Write-Output "Key Vault Name : $keyVaultName"
	$kVSecretParameters = @{ }

	#region - Application Gateway Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['applicationGatewayName']))
	{
		Write-Output "Application Gateway Name: $applicationGatewayName"
		$kVSecretParameters.Add("ApplicationGateway--Name", $($applicationGatewayName))
	}
	else
	{
		Write-Output "Application Gateway Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['applicationGatewayResourceId']))
	{
		Write-Output "Application Gateway ResourceId: $applicationGatewayResourceId"
		$kVSecretParameters.Add("ApplicationGateway--ResourceId", $($applicationGatewayResourceId))
	}
	else
	{
		Write-Output "Application Gateway ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['applicationGatewayResourceGroup']))
	{
		Write-Output "Application Gateway ResourceGroup: $applicationGatewayResourceGroup"
		$kVSecretParameters.Add("ApplicationGateway--ResourceGroup", $($applicationGatewayResourceGroup))
	}
	else
	{
		Write-Output "Application Gateway ResourceGroup: []"
	}
	#endregion

	#region - Set Azure KeyVault Secret
	$kVSecretParameters.Keys | ForEach-Object {
		$key = $psitem
		$value = $kVSecretParameters.Item($psitem)

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