<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		KubernetesAKS.akv.set.secrets.ps1

		Purpose:	Set Kubernetes Cluster Key Secrets

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
		2) Set Kubernetes Cluster Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER aksClusterName
		Specify the Kubernetes Cluster Name output parameter.

	.PARAMETER aksClusterResourceId
		Specify the Kubernetes Cluster ResourceId output parameter.

	.PARAMETER aksClusterResourceGroup
		Specify the Kubernetes Cluster ResourceGroup output parameter.

	.PARAMETER aksClusterControlPlaneFQDN
		Specify the Kubernetes Cluster Control Plane FQDN output parameter.

	.PARAMETER aksClusterSPNId
		Specify the Kubernetes Cluster Service Principal Name Id output parameter.

	.PARAMETER aksClusterSubnetId
		Specify the Kubernetes Cluster Subnet Id output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\KubernetesAKS.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-aksClusterName "$(aksClusterName)"
			-aksClusterResourceId "$(aksClusterResourceId)"
			-aksClusterResourceGroup "$(aksClusterResourceGroup)"
			-aksClusterControlPlaneFQDN "$(aksClusterControlPlaneFQDN)"
			-aksClusterSPNId "$(aksClusterSPNId)"
			-aksClusterSubnetId "$(aksClusterSubnetId)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$aksClusterName,

	[Parameter(Mandatory = $false)]
	[string]$aksClusterResourceId,

	[Parameter(Mandatory = $false)]
	[string]$aksClusterResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$aksClusterControlPlaneFQDN,

	[Parameter(Mandatory = $false)]
	[string]$aksClusterSPNId,

	[Parameter(Mandatory = $false)]
	[string]$aksClusterSubnetId
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Kubernetes Cluster Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksClusterName']))
	{
		Write-Output "Kubernetes Cluster Name: $aksClusterName"
		$kvSecretParameters.Add("aksCluster--Name--$($aksClusterName)", $($aksClusterName))
	}
	else
	{
		Write-Output "Kubernetes Cluster Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksClusterResourceId']))
	{
		Write-Output "Kubernetes Cluster ResourceId: $aksClusterResourceId"
		$kvSecretParameters.Add("aksCluster--ResourceId--$($aksClusterName)", $($aksClusterResourceId))
	}
	else
	{
		Write-Output "Kubernetes Cluster ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksClusterResourceGroup']))
	{
		Write-Output "Kubernetes Cluster ResourceGroup: $aksClusterResourceGroup"
		$kvSecretParameters.Add("aksCluster--ResourceGroup--$($aksClusterName)", $($aksClusterResourceGroup))
	}
	else
	{
		Write-Output "Kubernetes Cluster ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksClusterControlPlaneFQDN']))
	{
		Write-Output "Kubernetes Cluster Control Plane FQDN: $aksClusterControlPlaneFQDN"
		$kvSecretParameters.Add("aksCluster--ControlPlaneFQDN--$($aksClusterName)", $($aksClusterControlPlaneFQDN))
	}
	else
	{
		Write-Output "Kubernetes Cluster Control Plane FQDN: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksClusterSPNId']))
	{
		Write-Output "Kubernetes Cluster SPN Id: $aksClusterSPNId"
		$kvSecretParameters.Add("aksCluster--SPNId--$($aksClusterName)", $($aksClusterSPNId))
	}
	else
	{
		Write-Output "Kubernetes Cluster SPN Id: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['aksClusterSubnetId']))
	{
		Write-Output "Kubernetes Cluster SubnetId: $aksClusterSubnetId"
		$kvSecretParameters.Add("aksCluster--SubnetId--$($aksClusterName)", $($aksClusterSubnetId))
	}
	else
	{
		Write-Output "Kubernetes Cluster SubnetId: []"
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