<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ContainerRegistries.output.tests.ps1

		Purpose:	Test - Container Registries ARM Template Output Variables

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
		This script contains functionality used to test Container Registries ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Container Registries ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

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
		C:\PS>.\ContainerRegistries.output.tests.ps1
			-containerRegistryName "$(containerRegistryName)"
			-containerRegistryResourceId "$(containerRegistryResourceId)"
			-containerRegistryResourceGroup "$(containerRegistryResourceGroup)"
			-containerRegistryLoginServer "$(containerRegistryLoginServer)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$containerRegistryName,

	[Parameter(Mandatory = $false)]
	[string]$containerRegistryResourceId,

	[Parameter(Mandatory = $false)]
	[string]$containerRegistryResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$containerRegistryLoginServer
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['containerRegistryName']))
{
	Write-Output "Container Registries Name: $($containerRegistryName)"
}
else
{
	Write-Output "Container Registries Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['containerRegistryResourceId']))
{
	Write-Output "Container Registries ResourceId: $($containerRegistryResourceId)"
}
else
{
	Write-Output "Container Registries ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['containerRegistryResourceGroup']))
{
	Write-Output "Container Registries Resource Group: $($containerRegistryResourceGroup)"
}
else
{
	Write-Output "Container Registries Resource Group: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['containerRegistryLoginServer']))
{
	Write-Output "Container Registries Login Server: $($containerRegistryLoginServer)"
}
else
{
	Write-Output "Container Registries Login Server: []"
}
#endregion