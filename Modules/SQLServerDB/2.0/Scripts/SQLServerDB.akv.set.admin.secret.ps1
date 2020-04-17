<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		SQLServerDB.akv.set.admin.secret.ps1

		Purpose:	Set SQL Server Administrstor Credentials to Key Vault Secret

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
		Set SQL Server Administrstor Credentials to Key Vault Secret

	.DESCRIPTION
		Set SQL Server Administrstor Credentials to Key Vault Secret

		Deployment steps of the script are outlined below.
		1) Set Azure and SQL KeyVault Parameters
		2) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER keyVaultSecret
		Specify the Azure KeyVault Secret parameter.

	.EXAMPLE
		Default:
		C:\PS>.\SQLServerDB.akv.set.admin.secret.ps1
			-keyVaultName "$(keyVaultName)"
			-keyVaultSecret "$(keyVaultSecret)"
#>

#Requires -Version 5
#Requires -Module Az.KeyVault

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$keyVaultName,

	[Parameter(Mandatory = $false)]
	[string]$keyVaultSecret
)

#region - functions
function Get-RandomPassword
{
	param
	(
		[parameter()]
		[ValidateRange(8, 100)]
		[int]$Length = 12,

		[parameter()]
		[switch]$SpecialChars
	)

	$aUpper = [char[]]'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	$aLower = [char[]]'abcdefghijklmnopqrstuvwxyz'
	$aNumber = [char[]]'1234567890'
	$aSCharacter = [char[]]'!@#$%^&*()_+|~-=\{}[]:;<>,./'
	$aClasses = [char[]]'ULN'
	$Pwd = ""

	if ($SpecialChars)
	{
		$aClasses += 'S'
	}

	$notOneOfEach = $true
	while ($notOneOfEach)
	{
		$pPattern = ''
		for ($i = 0; $i -lt $Length; $i++)
		{
			$pPattern += Get-Random -InputObject $aClasses
		}
		if (($pPattern -match 'U' -and $pPattern -match 'L' -and $pPattern -match 'N' -and (-not $specialChars)) -or ($pPattern -match 'U' -and $pPattern -match 'L' -and $pPattern -match 'N' -and $pPattern -match 'S'))
		{
			$notOneOfEach = $false
		}
	}
	foreach ($chr in [char[]]$pPattern) {
		switch ($chr)
		{
			U { $pwd += Get-Random -InputObject $aUpper; break }
			L { $pwd += Get-Random -InputObject $aLower; break }
			N { $pwd += Get-Random -InputObject $aNumber; break }
			S { $pwd += Get-Random -InputObject $aSCharacter; break }
		}
	}
	return $pwd
}
#endregion

#region - Set Azure and SQL KeyVault Parameters
$kvSecretParameters = @{ }

if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	$paramGetRandomPassword = @{
		Length = 16
	}
	$pwd = Get-RandomPassword @paramGetRandomPassword
	$kvSecretParameters.Add("$keyVaultSecret", $($pwd))

	Write-Output "keyVault Name : $keyVaultName"
	Write-Output "KeyVault Secret : $keyVaultSecret , $pwd"
}
else
{
	Write-Output "keyVault Name : []"
}
#endregion

#region - Set Azure KeyVault Secret
$kVSecretParameters.Keys | ForEach-Object {
	$key = $psitem
	$value = $kVSecretParameters.Item($psitem)

	if (-not [string]::IsNullOrWhiteSpace($value))
	{
		$paramGetAzKeyVaultSecret = @{
			VaultName = $keyVaultName
		}
		if (Get-AzKeyVaultSecret @paramGetAzKeyVaultSecret | Where-Object { $psitem.Name -eq "$key" })
		{
			Write-Output "The secret for $key already exists"
		}
		else
		{
			Write-Output "Setting Secret for $key"
			$paramSetAzKeyVaultSecret = @{
				VaultName   = $keyVaultName
				Name        = $key
				SecretValue = (ConvertTo-SecureString $value -AsPlainText -Force)
			}
			Set-AzKeyVaultSecret @paramSetAzKeyVaultSecret -Verbose
		}
	}
	else
	{
		Write-Output "KeyVault Secret Value : []"
	}
}
#endregion