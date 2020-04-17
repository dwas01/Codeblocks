<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		NetworkSecurityGroups.akv.set.secrets.ps1

		Purpose:	Set Network Security Groups Key Secrets

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
		Set Network Security Groups Key Secrets.

	.DESCRIPTION
		Set Network Security Groupss Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Network Security Groups Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER networkSecurityGroupsName
		Specify the Network Security Groups Name output parameter.

	.PARAMETER networkSecurityGroupsResourceId
		Specify the Network Security Groups ResourceId output parameter.

	.PARAMETER networkSecurityGroupsResourceGroup
		Specify the Network Security Groups ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\NetworkSecurityGroups.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-networkSecurityGroupsName "$(networkSecurityGroupsName)"
			-networkSecurityGroupsResourceId "$(networkSecurityGroupsResourceId)"
			-networkSecurityGroupsResourceGroup "$(networkSecurityGroupsResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$networkSecurityGroupsName,

	[Parameter(Mandatory = $false)]
	[string]$networkSecurityGroupsResourceId,

	[Parameter(Mandatory = $false)]
	[string]$networkSecurityGroupsResourceGroup
)

#region - KeyVault Parameters
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['keyVaultName']))
{
	Write-Output "KeyVault Name: $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Network Security Groups Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['networkSecurityGroupsName']))
	{
		Write-Output "Network Security Groups Name: $networkSecurityGroupsName"
		$kvSecretParameters.Add("NetworkSecurityGroups--Name--$($networkSecurityGroupsName)", $($networkSecurityGroupsName))
	}
	else
	{
		Write-Output "Network Security Groups Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['networkSecurityGroupsResourceId']))
	{
		Write-Output "Network Security Groups ResourceId: $networkSecurityGroupsResourceId"
		$kvSecretParameters.Add("NetworkSecurityGroups--ResourceId--$($networkSecurityGroupsName)", $($networkSecurityGroupsResourceId))
	}
	else
	{
		Write-Output "Network Security Groups ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['networkSecurityGroupsResourceGroup']))
	{
		Write-Output "Network Security Groups ResourceGroup: $networkSecurityGroupsResourceGroup"
		$kvSecretParameters.Add("NetworkSecurityGroups--ResourceGroup--$($networkSecurityGroupsName)", $($networkSecurityGroupsResourceGroup))
	}
	else
	{
		Write-Output "Network Security Groups ResourceGroup: []"
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