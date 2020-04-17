<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		StreamAnalytics.akv.set.secrets.ps1

		Purpose:	Set Stream Analytics Key Secrets

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
		Set Stream Analytics Key Secrets.

	.DESCRIPTION
		Set Stream Analytics Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Stream Analytics Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER streamAnalyticsName
		Specify the Stream Analytics Name output parameter.

	.PARAMETER streamAnalyticsResourceId
		Specify the Stream Analytics ResourceId output parameter.

	.PARAMETER streamAnalyticsResourceGroup
		Specify the Stream Analytics ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\StreamAnalytics.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-streamAnalyticsName "$(streamAnalyticsName)"
			-streamAnalyticsResourceId "$(streamAnalyticsResourceId)"
			-streamAnalyticsResourceGroup "$(streamAnalyticsResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$streamAnalyticsName,

	[Parameter(Mandatory = $false)]
	[string]$streamAnalyticsResourceId,

	[Parameter(Mandatory = $false)]
	[string]$streamAnalyticsResourceGroup
)

#region - KeyVault Parameters
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	Write-Output "KeyVault Name: $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Stream Analytics Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['streamAnalyticsName']))
	{
		Write-Output "Stream Analytics Name: $streamAnalyticsName"
		$kvSecretParameters.Add("StreamAnalytics--Name", $($streamAnalyticsName))
	}
	else
	{
		Write-Output "Stream Analytics Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['streamAnalyticsResourceId']))
	{
		Write-Output "Stream Analytics ResourceId: $streamAnalyticsResourceId"
		$kvSecretParameters.Add("StreamAnalytics--ResourceId", $($streamAnalyticsResourceId))
	}
	else
	{
		Write-Output "Stream Analytics ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['streamAnalyticsResourceGroup']))
	{
		Write-Output "Stream Analytics ResourceGroup: $streamAnalyticsResourceGroup"
		$kvSecretParameters.Add("StreamAnalytics--ResourceGroup", $($streamAnalyticsResourceGroup))
	}
	else
	{
		Write-Output "Stream Analytics ResourceGroup: []"
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