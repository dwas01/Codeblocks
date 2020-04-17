<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ApplicationInsights.akv.set.secrets.ps1

		Purpose:	Set Application Insights Key Secrets

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
		Set Application Insights Key Secrets.

	.DESCRIPTION
		Set Application Insights Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Application Insights Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER appInsightsName
		Specify the Application Insights Name output parameter.

	.PARAMETER appInsightsResourceId
		Specify the Application Insights Resource Id output parameter.

	.PARAMETER appInsightsResourceGroup
		Specify the Application Insights ResourceGroup output parameter.

	.PARAMETER appInsightsKey
		Specify the Application Insights Instrumentation Key output parameter.

	.PARAMETER appInsightsAppId
		Specify the Application Insights AppId output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\ApplicationInsights.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-appInsightsName "$(appInsightsName)"
			-appInsightsResourceId "$(appInsightsResourceId)"
			-appInsightsResourceGroup "$(appInsightsResourceGroup)"
			-appInsightsKey "$(appInsightsKey)"
			-appInsightsAppId "$(appInsightsAppId)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsName,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsResourceId,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsKey,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsAppId
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Analysis Services Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsName']))
	{
		Write-Output "Application Insights Name: $appInsightsName"
		$kVSecretParameters.Add("AppInsights--Name", $($appInsightsName))
	}
	else
	{
		Write-Output "Application Insights Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsResourceId']))
	{
		Write-Output "Application Insights ResourceId: $appInsightsResourceId"
		$kVSecretParameters.Add("AppInsights--ResourceId", $($appInsightsResourceId))
	}
	else
	{
		Write-Output "Application Insights ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsResourceGroup']))
	{
		Write-Output "Application Insights ResourceGroup: $appInsightsResourceGroup"
		$kVSecretParameters.Add("AppInsights--ResourceGroup", $($appInsightsResourceGroup))
	}
	else
	{
		Write-Output "Application Insights ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsKey']))
	{
		Write-Output "Application Insights (OPS) Instrumentation Key: $appInsightsOpsKey"
		$kVSecretParameters.Add("AppInsights--InstrumentationKey", $($appInsightsKey))
	}
	else
	{
		Write-Output "Application Insights Instrumentation Key: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsAppId']))
	{
		Write-Output "Application Insights AppId: $appInsightsAppId"
		$kVSecretParameters.Add("AppInsights--AppId", $($appInsightsAppId))
	}
	else
	{
		Write-Output "Application Insights AppId: []"
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