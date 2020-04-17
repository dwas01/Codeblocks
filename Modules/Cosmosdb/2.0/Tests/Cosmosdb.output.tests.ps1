<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		Cosmosdb.output.tests.ps1

		Purpose:	Test - Cosmosdb Database Account ARM Template Output Variables

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
		This script contains functionality used to test Cosmosdb Database Account ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Cosmosdb Database Account ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

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

	.PARAMETER cosmosdbsubnetName
		Specify the Cosmosdb Database Account SubNet Name output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\Cosmosdb.output.tests.ps1
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

[CmdletBinding()]
param
(
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

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbName']))
{
	Write-Output "Cosmosdb Database Account Name: $($cosmosdbName)"
}
else
{
	Write-Output "Cosmosdb Database Account Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbResourceId']))
{
	Write-Output "Cosmosdb Database Account ResourceId: $($cosmosdbResourceId)"
}
else
{
	Write-Output "Cosmosdb Database Account ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbResourceGroup']))
{
	Write-Output "Cosmosdb Database Account Resource Group: $($cosmosdbResourceGroup)"
}
else
{
	Write-Output "Cosmosdb Database Account Resource Group: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbEndpoint']))
{
	Write-Output "Cosmosdb Database Account Endpoint: $($cosmosdbEndpoint)"
}
else
{
	Write-Output "Cosmosdb Database Account Endpoint: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbAccountKey']))
{
	Write-Output "Cosmosdb Database Account Primary Master Key: $($cosmosdbAccountKey)"
}
else
{
	Write-Output "Cosmosdb Database Account Primary Master Key: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbConnectionString']))
{
	Write-Output "Cosmosdb Database Account Connection String: $($cosmosdbConnectionString)"
}
else
{
	Write-Output "Cosmosdb Database Account Connection Sting: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbTableApiConnectionString']))
{
	Write-Output "Cosmosdb Database Account Table Api Connection String: $($cosmosdbTableApiConnectionString)"
}
else
{
	Write-Output "Cosmosdb Database Account Table Api Connection Sting: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbvNetResourceGroup']))
{
	Write-Output "Cosmosdb Database Account vNet Resource Group: $($cosmosdbvNetResourceGroup)"
}
else
{
	Write-Output "Cosmosdb Database Account vNet Resource Group: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbvNetResourceName']))
{
	Write-Output "Cosmosdb Database Account vNet Resource Name: $($cosmosdbvNetResourceName)"
}
else
{
	Write-Output "Cosmosdb Database Account vNet Resource Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['cosmosdbSubnetName']))
{
	Write-Output "Cosmosdb Database Account Subnet Name: $($cosmosdbSubnetName)"
}
else
{
	Write-Output "Cosmosdb Database Account Subnet Name: []"
}
#endregion