<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		AzureAutomationAccount.akv.set.secrets.ps1

		Purpose:	Set Azure Automation Account Key Secrets

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
		Set Azure Automation Account Key Secrets.

	.DESCRIPTION
		Set Azure Automation Account Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Azure Automation Account Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER automationAccountName
		Specify the Azure Automation Account Name output parameter.

	.PARAMETER automationAccountResourceId
		Specify the Azure Automation Account ResourceId output parameter.

	.PARAMETER automationAccountResourceGroup
		Specify the Azure Automation Account ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\AzureAutomationAccount.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-automationAccountName "$(automationAccountName)"
			-automationAccountResourceId "$(automationAccountResourceId)"
			-automationAccountResourceGroup "$(automationAccountResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$automationAccountName,

	[Parameter(Mandatory = $false)]
	[string]$automationAccountResourceId,

	[Parameter(Mandatory = $false)]
	[string]$automationAccountResourceGroup
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Azure Automation Account Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['automationAccountName']))
	{
		Write-Output "Azure Automation Account Name: $automationAccountName"
		$kvSecretParameters.Add("AutomationAccount--Name", $($automationAccountName))
	}
	else
	{
		Write-Output "Azure Automation Account Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['automationAccountResourceId']))
	{
		Write-Output "Azure Automation Account ResourceId: $automationAccountResourceId"
		$kvSecretParameters.Add("AutomationAccount--ResourceId", $($automationAccountResourceId))
	}
	else
	{
		Write-Output "Azure Automation Account ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['automationAccountResourceGroup']))
	{
		Write-Output "Azure Automation Account ResourceGroup: $automationAccountResourceGroup"
		$kvSecretParameters.Add("AutomationAccount--ResourceGroup", $($automationAccountResourceGroup))
	}
	else
	{
		Write-Output "Azure Automation Account ResourceGroup: []"
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