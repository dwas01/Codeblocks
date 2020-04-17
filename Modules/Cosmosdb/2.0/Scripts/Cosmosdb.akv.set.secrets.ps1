<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		Cosmosdb.akv.set.secrets.ps1

		Purpose:	Set Cosmosdb Database Account Key Secrets

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
		Set Cosmosdb Database Account Key Secrets.

	.DESCRIPTION
		Set Cosmosdb Database Account Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Cosmosdb Database Account Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER cosmosdbAccountName
		Specify the Cosmosdb Database Account Name output parameter.

	.PARAMETER cosmosdbResourceId
		Specify the Cosmosdb Database Account ResourceId output parameter.

	.PARAMETER cosmosdbResourceGroup
		Specify the Cosmosdb Database Account ResourceGroup output parameter.

	.PARAMETER cosmosdbEndpoint
		Specify the Cosmosdb Database Account Endpoint output parameter.

	.PARAMETER cosmosdbAccountKey
		Specify the Cosmosdb Database Account Primary Master Key output parameter.

	.PARAMETER cosmosdbConnectionString
		Specify the Cosmosdb Database Account Connection String output parameter.

	.PARAMETER cosmosdbTableApiConnectionString
		Specify the Cosmosdb Database Account Table Api Connection String output parameter.

	.PARAMETER cosmosdbvNetResourceGroup
		Specify the Cosmosdb Database Account vNet Resource Group output parameter.

	.PARAMETER cosmosdbvNetResourceName
		Specify the Cosmosdb Database Account vNet Resource Name output parameter.

	.PARAMETER cosmosdbSubnetName
		Specify the Cosmosdb Database Account SubNet Name output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\Cosmosdb.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-cosmosdbAccountName "$(cosmosdbAccountName)"
			-cosmosdbResourceId "$(cosmosdbResourceId)"
			-cosmosdbResourceGroup "$(cosmosdbResourceGroup)"
			-cosmosdbEndpoint "$(cosmosdbEndpoint)"
			-cosmosdbAccountKey "$(cosmosdbAccountKey)"
			-cosmosdbConnectionString "$(cosmosdbConnectionString)"
			-cosmosdbTableApiConnectionString "$(cosmosdbTableApiConnectionString)"
			-cosmosdbvNetResourceGroup "$(cosmosdbvNetResourceGroup)"
			-cosmosdbvNetResourceName "$(cosmosdbvNetResourceName)"
			-cosmosdbSubnetName "$(cosmosdbSubnetName)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbName,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbResourceId,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbEndpoint,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbAccountKey,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbConnectionString,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbTableApiConnectionString,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbvNetResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbvNetResourceName,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbSubnetName
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Cosmosdb Database Account Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbName']))
	{
		Write-Output "Cosmosdb Database Account Name: $cosmosdbName"
		$kvSecretParameters.Add("Cosmosdb--Name--$($cosmosdbName)", $($cosmosdbName))
	}
	else
	{
		Write-Output "Cosmosdb Database Account Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbResourceId']))
	{
		Write-Output "Cosmosdb Database Account ResourceId: $cosmosdbResourceId"
		$kvSecretParameters.Add("Cosmosdb--ResourceId--$($cosmosdbName)", $($cosmosdbResourceId))
	}
	else
	{
		Write-Output "Cosmosdb Database Account ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbResourceGroup']))
	{
		Write-Output "Cosmosdb Database Account ResourceGroup: $cosmosdbResourceGroup"
		$kvSecretParameters.Add("Cosmosdb--ResourceGroup--$($cosmosdbName)", $($cosmosdbResourceGroup))
	}
	else
	{
		Write-Output "Cosmosdb Database Account ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbEndpoint']))
	{
		Write-Output "Cosmosdb Database Account Endpoint: $cosmosdbEndpoint"
		$kvSecretParameters.Add("Cosmosdb--Endpoint--$($cosmosdbName)", $($cosmosdbEndpoint))
	}
	else
	{
		Write-Output "Cosmosdb Database Account Endpoint: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbAccountKey']))
	{
		Write-Output "Cosmosdb Database Account Endpoint: $cosmosdbAccountKey"
		$kvSecretParameters.Add("Cosmosdb--AccountKey--$($cosmosdbName)", $($cosmosdbAccountKey))
	}
	else
	{
		Write-Output "Cosmosdb Database Account Endpoint: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbConnectionString']))
	{
		Write-Output "Cosmosdb Database Account Connection String: $cosmosdbConnectionString"
		$kvSecretParameters.Add("Cosmosdb--ConnectionString--$($cosmosdbName)", $($cosmosdbConnectionString))
	}
	else
	{
		Write-Output "Cosmosdb Database Account Connection String: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbTableApiConnectionString']))
	{
		Write-Output "Cosmosdb Database Account Table Api Connection String: $cosmosdbTableApiConnectionString"
		$kvSecretParameters.Add("Cosmosdb--TableApiConnectionString--$($cosmosdbName)", $($cosmosdbTableApiConnectionString))
	}
	else
	{
		Write-Output "Cosmosdb Database Account Table Api Connection String: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbvNetResourceGroup']))
	{
		Write-Output "Cosmosdb Database Account vNet Resource Group: $cosmosdbvNetResourceGroup"
		$kvSecretParameters.Add("Cosmosdb--vNetResourceGroup--$($cosmosdbName)", $($cosmosdbvNetResourceGroup))
	}
	else
	{
		Write-Output "Cosmosdb Database Account vNet Resource Group: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbvNetResourceName']))
	{
		Write-Output "Cosmosdb Database Account vNet Resource Name: $cosmosdbvNetResourceName"
		$kvSecretParameters.Add("Cosmosdb--vNetResourceName--$($cosmosdbName)", $($cosmosdbvNetResourceName))
	}
	else
	{
		Write-Output "Cosmosdb Database Account vNet Resource Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbSubnetName']))
	{
		Write-Output "Cosmosdb Database Account Subnet Name: $cosmosdbSubnetName"
		$kvSecretParameters.Add("Cosmosdb--SubnetName--$($cosmosdbName)", $($cosmosdbSubnetName))
	}
	else
	{
		Write-Output "Cosmosdb Database Account Subnet Name: []"
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