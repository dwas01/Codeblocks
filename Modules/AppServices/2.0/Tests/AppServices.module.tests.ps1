<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		AppServices.module.tests.ps1

		Purpose:	Pester - Test Application Web Services ARM Templates

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
		This script contains functionality used to test Application Web ServicesARM template synatax.

	.DESCRIPTION
		This script contains functionality used to test Application Web Services ARM template synatax.

		Deployment steps of the script are outlined below.
		1) Test Template File Syntax
		2) Test Parameter File Syntax
		3) Test Template and Parameter File Compactibility
#>

#Requires -Version 5

#region - Parameters
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$here = Join-Path -Path $here -ChildPath ".."
$template = Split-Path -Leaf $here

#region - Template File Test Cases
$templateFileTestCases = @()
ForEach ($file in (Get-ChildItem (Join-Path -Path "$here" -ChildPath "*.deploy.json") | Select-Object -ExpandProperty Name)) {
	$templateFileTestCases += @{ TemplateFile = $file }
}
#endregion

#region - Parameter File Test Cases
$parameterFileTestCases = @()
ForEach ($file in (Get-ChildItem (Join-Path -Path "$here" -ChildPath "*.parameters*.json") | Select-Object -ExpandProperty Name)) {
	$parameterFileTestCases += @{ ParameterFile = $file }
}
#endregion

#endregion

#region Run Pester Test Script
Describe "Template: $template - Application Web Services" -Tags -Unit {

	#region - Template File Syntax
	Context "Template File Syntax" {

		It "Has a JSON template file" {
			(Join-Path -Path "$here" -ChildPath "*.deploy.json") | Should -Exist
		}

		It "Converts from JSON and has the expected properties" -TestCases $templateFileTestCases {
			param ($templateFile)
			$expectedProperties = '$schema',
			'contentVersion',
			'parameters',
			'variables',
			'resources',
			'outputs' | Sort-Object
			$templateProperties = (Get-Content (Join-Path -Path "$here" -ChildPath "$templateFile") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue) `
				| Get-Member -MemberType NoteProperty `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			$templateProperties | Should -Be $expectedProperties
		}

		It "Converts from JSON and has the expected Azure Resources" -TestCases $templateFileTestCases {
			param ($templateFile)
			$expectedResources = 'Microsoft.Resources/deployments',
			'Microsoft.Web/serverfarms',
			'Microsoft.Web/sites'
			$templateResources = (Get-Content (Join-Path -Path "$here" -ChildPath "$templateFile") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Resources.type
			$templateResources | Should -Be $expectedResources
		}
	}
	#endregion

	#region - Parameter File Syntax
	Context "Parameter File Syntax" {

		It "Has environment parameters file" {
			(Join-Path -Path "$here" -ChildPath "*.parameters*.json") | Should -Exist
		}

		It "Parameter file contains the expected properties" -TestCases $parameterFileTestCases {
			param ($parameterFile)
			$expectedProperties = '$schema',
			'contentVersion',
			'parameters' | Sort-Object
			$templateFileProperties = (Get-Content (Join-Path -Path "$here" -ChildPath "$parameterFile") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue) `
				| Get-Member -MemberType NoteProperty `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			$templateFileProperties | Should -Be $expectedProperties
		}
	}
	#endregion

	#region - Template and Parameter Compactibility
	Context "Template and Parameter Compactibility" {

		BeforeEach {
			$module = [PSCustomObject]@{
				'Template'   = $null
				'Parameters' = $null
			}

			ForEach ($file in (Get-ChildItem (Join-Path -Path "$here" -ChildPath "*.deploy.json") `
				| Select-Object -ExpandProperty Name)) {
				$module.Template = $File
			}

			ForEach ($file in (Get-ChildItem (Join-Path -Path "$here" -ChildPath "*.parameters*.json") `
				| Select-Object -ExpandProperty Name)) {
				$module.Parameters = $file
			}
		}

		It "Is count of required parameters in template file equal or lesser than count of all parameters in parameters file" {
			$requiredParametersInTemplateFile = (Get-Content (Join-Path -Path "$here" -ChildPath "$($module.Template)") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Where-Object -FilterScript { -not ($psitem.Value.PSObject.Properties.Name -eq "defaultValue")} `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			$allparametersInParametersFile = (Get-Content (Join-Path -Path "$here" -ChildPath "$($module.Parameters)") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			$requiredParametersInTemplateFile.Count | Should -Not -BeGreaterThan $allParametersInParametersFile.Count
		}

		It "Has all parameters in parameters file existing in template file" {
			$allParametersInTemplateFile = (Get-Content (Join-Path -Path "$here" -ChildPath "$($module.Template)") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			$allParametersInParametersFile = (Get-Content (Join-Path -Path "$here" -ChildPath "$($module.Parameters)") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			@($allParametersInParametersFile | Where-Object { $allParametersInTemplateFile -notcontains $psitem }).Count | Should -Be 0
		}

		It "Has required parameters in template file existing in parameters file" {
			$requiredParametersInTemplateFile = (Get-Content (Join-Path -Path "$here" -ChildPath "$($module.Template)") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Where-Object -FilterScript { -not ($psitem.Value.PSObject.Properties.Name -eq "defaultValue")} `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			$allParametersInParametersFile = (Get-Content (Join-Path -Path "$here" -ChildPath "$($module.Parameters)") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			@($requiredParametersInTemplateFile | Where-Object { $allParametersInParametersFile -notcontains $psitem }).Count | Should -Be 0
		}
	}
	#endregion
}
#endregion