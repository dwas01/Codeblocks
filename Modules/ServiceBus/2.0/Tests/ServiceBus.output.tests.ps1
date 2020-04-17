<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ServiceBus.output.tests.ps1

		Purpose:	Test - Service Bus ARM Template Output Variables

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
		This script contains functionality used to test Service Bus ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Service Bus ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

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
		Specify the Service Bus EndPoint output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\ServiceBus.output.tests.ps1
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

[CmdletBinding()]
param
(
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

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusNamespaceName']))
{
	Write-Output "ServiceBus Namespace Name: $($serviceBusNamespaceName)"
}
else
{
	Write-Output "ServiceBus Namespace Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusResourceId']))
{
	Write-Output "ServiceBus ResourceId: $($serviceBusResourceId)"
}
else
{
	Write-Output "ServiceBus ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusResourceGroup']))
{
	Write-Output "ServiceBus Resource Group: $($serviceBusResourceGroup)"
}
else
{
	Write-Output "ServiceBus Resource Group: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusConnectionString']))
{
	Write-Output "ServiceBus Connection String: $($serviceBusConnectionString)"
}
else
{
	Write-Output "ServiceBus Connection String: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusPrimaryKey']))
{
	Write-Output "ServiceBus Primary Key: $($serviceBusPrimaryKey)"
}
else
{
	Write-Output "ServiceBus Primary Key: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusSendListenConnectionString']))
{
	Write-Output "ServiceBus Send Listen Connection String: $($serviceBusSendListenConnectionString)"
}
else
{
	Write-Output "ServiceBus Send Listen Connection String: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusSendListenPrimaryKey']))
{
	Write-Output "ServiceBus Send Listen Primary Key: $($serviceBusSendListenPrimaryKey)"
}
else
{
	Write-Output "ServiceBus Send Listen Primary Key: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusSendListenSASKeyName']))
{
	Write-Output "ServiceBus Send Listen SAS Key Name: $($serviceBusSendListenSASKeyName)"
}
else
{
	Write-Output "ServiceBus Send Listen SAS Key Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['serviceBusEndpoint']))
{
	Write-Output "ServiceBus Endpoint: $($serviceBusEndpoint)"
}
else
{
	Write-Output "Service Bus Endpoint: []"
}
#endregion