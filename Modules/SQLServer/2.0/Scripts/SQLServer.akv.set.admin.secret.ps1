<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		sqlServer.akv.set.admin.secret.ps1

		Purpose:	Set Key Vault Secrets for SQL Server Credentials Automation Script

		Version: 	1.0.0.0 - 1st August 2019 - Azure Virtual Datacenter Development Team
		==============================================================================================

	.SYNOPSIS
		Set SQL Server Administrstor Credentials to Key Vault Secret

	.DESCRIPTION
		Set SQL Server Administrstor Credentials to Key Vault Secret

		Deployment steps of the script are outlined below.
		1) Set Azure and SQL KeyVault Parameters
		2) Create Azure KeyVault Secret

		Keys:
		KeyVault Parameters
			Digital--KeyVault--SQLAdminUserPwd

	.PARAMETER keyVaultName
    	Specify the Azure KeyVault Name parameter.

	.PARAMETER keyVaultSecret
    	Specify the Azure KeyVault Secret parameter.

	.EXAMPLE
		Default:
		C:\PS> sqlServer.akv.set.admin.secret.ps1
			-keyVaultName "$(keyVaultName)"
			-keyVaultSecret "$(keyVaultSecret)"
#>

#Requires -Version 5
#Requires -Module AzureRM.KeyVault

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
			$pPattern += get-random -InputObject $aClasses
		}
		if (($pPattern -match 'U' -and $pPattern -match 'L' -and $pPattern -match 'N' -and (-not $specialChars)) -or ($pPattern -match 'U' -and $pPattern -match 'L' -and $pPattern -match 'N' -and $pPattern -match 'S'))
		{
			$notOneOfEach = $false
		}
	}
	foreach ($chr in [char[]]$pPattern) {
		switch ($chr)
		{
			U { $pwd += get-random -InputObject $aUpper; break }
			L { $pwd += get-random -InputObject $aLower; break }
			N { $pwd += get-random -InputObject $aNumber; break }
			S { $pwd += get-random -InputObject $aSCharacter; break }
		}
	}
	return $pwd
}
#endregion

#region - Set Azure and SQL KeyVault Parameters
$kVSecretParameters = @{ }

if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	$paramGetRandomPassword = @{
		Length = 16
	}
	$pwd = Get-RandomPassword @paramGetRandomPassword
	$kVSecretParameters.Add("$keyVaultSecret", $($pwd))

	write-output "keyVault Name : $keyVaultName"
	write-output "KeyVault Secert : $keyVaultSecret , $pwd"
}
else
{
    write-output "Key Vault Name : []"
}
#endregion

#region - Set Azure KeyVault Secret
$kVSecretParameters.Keys | ForEach-Object {
	$key = $psitem
	$value = $kVSecretParameters.Item($psitem)

	if (-not [string]::IsNullOrWhiteSpace($value))
	{
		$paramGetAzureKeyVaultSecret = @{
			VaultName = $keyVaultName
		}
		if (Get-AzureKeyVaultSecret @paramGetAzureKeyVaultSecret | Where-Object { $psitem.Name -eq "$key" })
		{
			Write-Output "The secret for $key already exists"
		}
		else
		{
			Write-Output "Setting Secret for $key"
			$paramSetAzureKeyVaultSecret = @{
				VaultName   = $keyVaultName
				Name	    = $key
				SecretValue = (ConvertTo-SecureString $value -AsPlainText -Force)
			}
			Set-AzureKeyVaultSecret @paramSetAzureKeyVaultSecret -Verbose
		}
	}
	else
	{
		write-output "KeyVault Secert : []"
	}
}
#endregion