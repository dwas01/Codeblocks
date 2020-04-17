<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		EventHub.output.tests.ps1

		Purpose:	Test - Event Hub ARM Template Output Variables

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
		This script contains functionality used to test Event Hub ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Event Hub ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER namespaceName
		Specify the Event Hub Namespace Name output parameter.

	.PARAMETER namespaceResourceId
		Specify the Event Hub Namespace ResourceId output parameter.

	.PARAMETER namespaceResourceGroup
		Specify the Event Hub Namespace ResourceGroup output parameter.

	.PARAMETER namespaceConnectionString
		Specify the Event Hub Namespace Connection String output parameter.

	.PARAMETER namespacePrimaryKey
		Specify the Event Hub Shared Access Policy Primary Key output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\EventHub.output.tests.ps1
			-namespaceName "$(namespaceName)"
			-namespaceResourceId "$(namespaceResourceId)"
			-namespaceResourceGroup "$(namespaceResourceGroup)"
			-namespaceConnectionString "$(namespaceConnectionString)"
			-namespacePrimaryKey "$(namespacePrimaryKey)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$namespaceName,

	[Parameter(Mandatory = $false)]
	[string]$namespaceResourceId,

	[Parameter(Mandatory = $false)]
	[string]$namespaceResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$namespaceConnectionString,

	[Parameter(Mandatory = $false)]
	[string]$namespacePrimaryKey
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespaceName']))
{
	Write-Output "Event Hub Namespace Name: $($namespaceName)"
}
else
{
	Write-Output "Event Hub Namespace Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespaceResourceId']))
{
	Write-Output "Event Hub Namespace ResourceId: $($namespaceResourceId)"
}
else
{
	Write-Output "Event Hub Namespace ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespaceResourceGroup']))
{
	Write-Output "Event Hub Namespace Resource Group: $($namespaceResourceGroup)"
}
else
{
	Write-Output "Event Hub Namespace Resource Group: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespaceConnectionString']))
{
	Write-Output "Event Hub Namespace Connection String: $($namespaceConnectionString)"
}
else
{
	Write-Output "Event Hub Namespace Connection String: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['namespacePrimaryKey']))
{
	Write-Output "Event Hub Shared Access Policy Primary Key: $($namespacePrimaryKey)"
}
else
{
	Write-Output "Event Hub Shared Access Policy Primary Key: []"
}
#endregion