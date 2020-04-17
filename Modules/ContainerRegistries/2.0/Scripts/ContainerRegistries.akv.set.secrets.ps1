<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ContainerRegistries.akv.set.secrets.ps1

		Purpose:	Set Container Registries Key Secrets

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
		Set Container Registries Key Secrets.

	.DESCRIPTION
		Set Container Registries Key Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Container Registries Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER containerRegistryName
		Specify the Container Registries Name output parameter.

	.PARAMETER containerRegistryResourceId
		Specify the Container Registries ResourceId output parameter.

	.PARAMETER containerRegistryResourceGroup
		Specify the Container Registries ResourceGroup output parameter.

	.PARAMETER containerRegistryLoginServer
		Specify the Container Registries Login Server output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\ContainerRegistries.akv.set.secrets.ps1
			-keyVaultName "$(keyVaultName)"
			-containerRegistryName "$(containerRegistryName)"
			-containerRegistryResourceId "$(containerRegistryResourceId)"
			-containerRegistryResourceGroup "$(containerRegistryResourceGroup)"
			-containerRegistryLoginServer "$(containerRegistryLoginServer)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$containerRegistryName,

	[Parameter(Mandatory = $false)]
	[string]$containerRegistryResourceId,

	[Parameter(Mandatory = $false)]
	[string]$containerRegistryResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$containerRegistryLoginServer
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Container Registries Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['containerRegistryName']))
	{
		Write-Output "Container Registries Name: $containerRegistryName"
		$kvSecretParameters.Add("ContainerRegistry--Name--$($containerRegistryName)", $($containerRegistryName))
	}
	else
	{
		Write-Output "Container Registries Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['containerRegistryResourceId']))
	{
		Write-Output "Container Registries ResourceId: $containerRegistryResourceId"
		$kvSecretParameters.Add("ContainerRegistry--ResourceId--$($containerRegistryName)", $($containerRegistryResourceId))
	}
	else
	{
		Write-Output "Container Registries ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['containerRegistryResourceGroup']))
	{
		Write-Output "Container Registries ResourceGroup: $containerRegistryResourceGroup"
		$kvSecretParameters.Add("ContainerRegistry--ResourceGroup--$($containerRegistryName)", $($containerRegistryResourceGroup))
	}
	else
	{
		Write-Output "Container Registries ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['containerRegistryLoginServer']))
	{
		Write-Output "Container Registries Login Server: $containerRegistryLoginServer"
		$kvSecretParameters.Add("ContainerRegistry--LoginServer--$($containerRegistryName)", $($containerRegistryLoginServer))
	}
	else
	{
		Write-Output "Container Registries Login Server: []"
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