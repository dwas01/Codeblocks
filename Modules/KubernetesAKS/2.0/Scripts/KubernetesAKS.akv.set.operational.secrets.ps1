<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		KubernetesAKS.akv.set.secrets.ps1

		Purpose:	Set Kubernetes Cluster Operational Key Secrets

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
		Set Kubernetes Cluster Key Secrets.

	.DESCRIPTION
		Set Api Management Service Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Kubernetes Cluster Operational Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER aksPodIdentityName
		Specify the Kubernetes Cluster Pod Identity output parameter.

	.PARAMETER aksPodIdentityResourceId
		Specify the Kubernetes Cluster Pod Identity ResourceId output parameter.

	.PARAMETER aksPodIdentityResourceGroup
		Specify the Kubernetes Cluster Pod Identity ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\KubernetesAKS.akv.set.operational.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-aksPodIdentityName "$(aksPodIdentityName)"
			-aksPodIdentityResourceId "$(aksPodIdentityResourceId)"
			-aksPodIdentityResourceGroup "$(aksPodIdentityResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$aksPodIdentityName,

	[Parameter(Mandatory = $false)]
	[string]$aksPodIdentityResourceId,

	[Parameter(Mandatory = $false)]
	[string]$aksPodIdentityResourceGroup

)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Kubernetes Cluster Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksPodIdentityName']))
	{
		Write-Output "Kubernetes Cluster Name: $aksPodIdentityName"
		$kvSecretParameters.Add("aksPodIdentity--Name--$($aksPodIdentityName)", $($aksPodIdentityName))
	}
	else
	{
		Write-Output "Kubernetes Cluster Pod Identity Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksPodIdentityResourceId']))
	{
		Write-Output "Kubernetes Cluster ResourceId: $aksPodIdentityResourceId"
		$kvSecretParameters.Add("aksPodIdentity--ResourceId--$($aksPodIdentityName)", $($aksPodIdentityResourceId))
	}
	else
	{
		Write-Output "Kubernetes Cluster Pod Identity ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksPodIdentityResourceGroup']))
	{
		Write-Output "Kubernetes Cluster ResourceGroup: $aksPodIdentityResourceGroup"
		$kvSecretParameters.Add("aksPodIdentity--ResourceGroup--$($aksPodIdentityName)", $($aksPodIdentityResourceGroup))
	}
	else
	{
		Write-Output "Kubernetes Cluster Pod Identity ResourceGroup: []"
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