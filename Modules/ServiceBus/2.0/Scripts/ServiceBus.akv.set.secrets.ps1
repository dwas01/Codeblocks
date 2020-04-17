<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ServiceBus.akv.set.secrects.ps1

		Purpose:	Set Service Bus KeyVault Secrets

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
		Set Service Bus Key Vault Secrets.

	.DESCRIPTION
		Set Service Bus Key Vault Secrets.

		Deployment steps of the script are outlined below.
		1) Set Azure KeyVault Parameters
		2) Set Service Bus Parameters
		3) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER serviceBusNamespaceName
		Specify the Service Bus Namespace Name output parameter.

	.PARAMETER serviceBusResourceId
		Specify the Service Bus ResourceId output parameter.

	.PARAMETER serviceBusResourceGroup
		Specify the Service Bus ResourceGroup output parameter.

	.PARAMETER serviceBusConnectionString
		Specify the Service Bus Connection String output parameter.

	.PARAMETER serviceBusPrimaryKey
		Specify the Service Bus Primary Key output parameter.

	.PARAMETER serviceBusSendListenConnectionString
		Specify the Service Bus Send Listen Connection String output parameter.

	.PARAMETER serviceBusSendListenPrimaryKey
		Specify the Service Bus Send Listen Primary Key output parameter.

	.PARAMETER serviceBusSendListenSASKeyName
		Specify the Service Bus Send Listen SAS Key Name output parameter.

	.PARAMETER serviceBusEndpoint
		Specify the ServiceBus EndPoint output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\ServiceBus.akv.set.secrects.ps1
			-keyVaultName "$(keyVaultName)"
			-serviceBusNamespaceName "$(serviceBusNamespaceName)"
			-serviceBusResourceId "$(serviceBusResourceId)"
			-serviceBusResourceGroup "$(serviceBusResourceGroup)"
			-serviceBusConnectionString "$(serviceBusConnectionString)"
			-serviceBusPrimaryKey "$(serviceBusPrimaryKey)"
			-serviceBusSendListenConnectionString "$(serviceBusSendListenConnectionString)"
			-serviceBusSendListenPrimaryKey "$(serviceBusSendListenPrimaryKey)"
			-serviceBusSendListenSASKeyName "$(serviceBusSendListenSASKeyName)"
			-serviceBusEndpoint "$(serviceBusEndpoint)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusNamespaceName,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusResourceIdd,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusConnectionString,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusPrimaryKey,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusSendListenConnectionString,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusSendListenPrimaryKey,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusSendListenSASKeyName,

	[Parameter(Mandatory = $false)]
	[string]$serviceBusEndpoint
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	write-output "keyVaultName : $keyVaultName"
	$kvSecretParameters = @{ }

	#region - Service Bus Parameters
	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusNamespaceName']))
	{
		Write-Output "Service Bus Namespace Name: $serviceBusNamespaceName"
		$kvSecretParameters.Add("ServiceBus--NamespaceName--$($serviceBusNamespaceName)", $($serviceBusNamespaceName))
	}
	else
	{
		Write-Output "Service Bus Namespace Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusResourceId']))
	{
		Write-Output "Servic eBus ResourceId: $serviceBusResourceId"
		$kvSecretParameters.Add("ServiceBus--ResourceId--$($serviceBusNamespaceName)", $($serviceBusResourceId))
	}
	else
	{
		Write-Output "Service Bus ResourceId: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusResourceGroup']))
	{
		Write-Output "Service Bus ResourceGroup: $serviceBusResourceGroup"
		$kvSecretParameters.Add("ServiceBus--ResourceGroup--$($serviceBusNamespaceName)", $($serviceBusResourceGroup))
	}
	else
	{
		Write-Output "Service Bus ResourceGroup: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusConnectionString']))
	{
		Write-Output "Service Bus Connection String: $serviceBusConnectionString"
		$kvSecretParameters.Add("ServiceBus--ConnectionString--$($serviceBusNamespaceName)", $($serviceBusConnectionString))
	}
	else
	{
		Write-Output "Service Bus Connection String: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusPrimaryKey']))
	{
		Write-Output "Service Bus Primary Key: $serviceBusPrimaryKey"
		$kvSecretParameters.Add("ServiceBus--PrimaryKey--$($serviceBusNamespaceName)", $($serviceBusPrimaryKey))
	}
	else
	{
		Write-Output "Service Bus Primary Key: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusSendListenConnectionString']))
	{
		Write-Output "Service Bus Send Listen Connection String: $serviceBusSendListenConnectionString"
		$kvSecretParameters.Add("ServiceBus--SendListen--ConnectionString--$($serviceBusNamespaceName)", $($serviceBusSendListenConnectionString))
	}
	else
	{
		Write-Output "Service Bus Send Listen Connection String: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusSendListenPrimaryKey']))
	{
		Write-Output "Service Bus Send Listen Primary Key: $serviceBusSendListenPrimaryKey"
		$kvSecretParameters.Add("ServiceBus--SendListen--PrimaryKey--$($serviceBusNamespaceName)", $($serviceBusSendListenPrimaryKey))
	}
	else
	{
		Write-Output "Service Bus Send Listen Primary Key: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusSendListenSASKeyName']))
	{
		Write-Output "Service Bus Send Listen SAS Key Name: $serviceBusSendListenSASKeyName"
		$kvSecretParameters.Add("ServiceBus--SendListen--SASKeyName--$($serviceBusNamespaceName)", $($serviceBusSendListenSASKeyName))
	}
	else
	{
		Write-Output "Service Bus Send Listen SAS Key Name: []"
	}

	if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusEndpoint']))
	{
		Write-Output "Service Bus Endpoint : $serviceBusEndpoint"
		$kvSecretParameters.Add("ServiceBus--Endpoint--$($serviceBusNamespaceName)", $($serviceBusEndpoint))
	}
	else
	{
		Write-Output "Service Bus Endpoint: []"
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