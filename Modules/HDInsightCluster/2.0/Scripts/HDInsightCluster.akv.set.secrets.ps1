<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		HDInsightCluster.akv.set.secrets.ps1

		Purpose:	Set HDInsight Cluster Key Secrets

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
		Set HDInsight Key Secrets.

	.DESCRIPTION
		Set HDInsight Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set HDInsight Cluster Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER hdInsightClusterName
		Specify the HDInsight Cluster Name output parameter.

	.PARAMETER hdInsightClusterResourceId
		Specify the HDInsight Cluster Service ResourceId output parameter.

	.PARAMETER hdInsightClusterResourceGroup
		Specify the HDInsight Cluster ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\HDInsightCluster.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-hdInsightClusterName "$(hdInsightClusterName)"
			-hdInsightClusterResourceId "$(hdInsightClusterResourceId)"
			-hdInsightClusterResourceGroup "$(hdInsightClusterResourceGroup)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$hdInsightClusterName,

	[Parameter(Mandatory = $false)]
	[string]$hdInsightClusterResourceId,

	[Parameter(Mandatory = $false)]
	[string]$hdInsightClusterResourceGroup
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - HDInsight Cluster Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['hdInsightClusterName']))
	{
		Write-Output "HDInsight Cluster Name: $hdInsightClusterName"
		$kvSecretParameters.Add("HDInsightCluster--Name", $($hdInsightClusterName))
	}
	else
	{
		Write-Output "HDInsight Cluster Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['hdInsightClusterResourceId']))
	{
		Write-Output "HDInsight Cluster ResourceId: $hdInsightClusterResourceId"
		$kvSecretParameters.Add("HDInsightCluster--ResourceId", $($hdInsightClusterResourceId))
	}
	else
	{
		Write-Output "HDInsight Cluster ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['hdInsightClusterResourceGroup']))
	{
		Write-Output "HDInsight Cluster ResourceGroup: $hdInsightClusterResourceGroup"
		$kvSecretParameters.Add("HDInsightCluster--ResourceGroup", $($hdInsightClusterResourceGroup))
	}
	else
	{
		Write-Output "HDInsight Cluster ResourceGroup: []"
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