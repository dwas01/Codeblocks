<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		SearchServices.search.index.profile.ps1

		Purpose:	Configures Azure Cognitive Search Index Profiles in a Comosdb Account

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
		This script configures Azure Cognitive Search Index Profiles

	.DESCRIPTION
		This script configures Azure Cognitive Search Index Profiles

		Deployment steps of the script are outlined below.
		1) Azure Cognitive Search Parameters
		2) Create the API Headers
		3) Invoke API Calls into Azure Search

	.PARAMETER azureSearchName
		Specify the Azure Cognitive Search Name parameter.

	.PARAMETER azureSearchResourceGroup
		Specify the Azure Cognitive Search Resource Group Name parameter.

	.PARAMETER cosmosdbAccountName
		Specify the Cosmosdb Account Name parameter.

	.PARAMETER cosmosdbAccountKey
		Specify the Cosmosdb Account Key parameter.

	.PARAMETER cosmosdbName
		Specify the Comosdb Database Name parameter.

	.PARAMETER cosmosdbContainerName
		Specify the Comosdb Database Container Name parameter.

	.EXAMPLE

		C:\PS>.\SearchServices.search.index.profile.ps1
			-azureSearchName "$(azureSearchName)"
			-azureSearchResourceGroup "$(azureSearchResourceGroup)"
			-cosmosdbAccountName "$(CosmosdbAccountName)"
			-cosmosdbAccountKey "$(cosmosdbAccountKey)"
			-cosmosdbName "$(cosmosdbName)"
			-cosmosdbContainerName "$(cosmosdbContainerName)"
#>

#Requires -Version 5
#Requires -Module Az.Resources

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$azureSearchName,

	[Parameter(Mandatory = $true)]
	[string]$azureSearchResourceGroup,

	[Parameter(Mandatory = $true)]
	[string]$cosmosdbAccountName,

	[Parameter(Mandatory = $true)]
	[string]$cosmosdbAccountKey,

	[Parameter(Mandatory = $true)]
	[string]$cosmosdbName,

	[Parameter(Mandatory = $true)]
	[string]$cosmosdbContainerName
)

#region - Parameter Configuration
Write-Output "Azure Search Service Name:    $azureSearchName"
Write-Output "Azure Search Resource Group:  $azureSearchResourceGroup"
Write-Output "Cosmosdb Account Name:        $cosmosdbAccountName"
Write-Output "Cosmosdb Account Key:         $cosmosdbAccountKey"
Write-Output "Cosmosdb Database Name:       $cosmosdbName"
Write-Output "Cosmosdb Container Name:      $cosmosdbContainerName"

$paramGetAzResource = @{
	ResourceType  = "Microsoft.Search/searchServices"
	ResourceGroup = $azureSearchResourceGroup
	Name          = "$azureSearchName"
}
$resource = Get-AzResource @paramGetAzResource

$paramInvokeAzResourceAction = @{
	Action     = 'listAdminKeys'
	ResourceId = $resource.ResourceId
	ApiVersion = '2015-08-19'
	Force      = $true
}
$azureSearchApiKey = (Invoke-AzResourceAction @paramInvokeAzResourceAction).PrimaryKey
#endregion

#region - API Parameters
$datasourceName = "rulesets-$($cosmosdbContainerName.ToLower())-data-source"
$targetIndexName = "rulesets-$($cosmosdbContainerName.ToLower())-index"
$indexerName = "rulesets-$($cosmosdbContainerName.ToLower())-indexer"

Write-Output "rulesets datasource name: $datasourceName"
Write-Output "rulesets index namee:     $targetIndexName"
Write-Output "rulesets indexer name:    $indexerName"

$headers = @{
	'cache-control'=  'no-cache'
	'Content-Type'  = 'application/json'
	'api-key' = "$($azureSearchApiKey)"
}

$createDataSourceRequest = @"
{
    "name": "$($datasourceName)",
    "type": "documentdb",
    "credentials": {
        "connectionString": "AccountEndpoint=https://$($cosmosdbAccountName).documents.azure.com;AccountKey=$($cosmosdbAccountKey);Database=$($cosmosdbName)"
    },
    "container": {
        "name": "$($cosmosdbContainerName)",
        "query": null
    },
    "dataChangeDetectionPolicy": {
        "@odata.type": "#Microsoft.Azure.Search.HighWaterMarkChangeDetectionPolicy",
        "highWaterMarkColumnName": "_ts"
    }
}
"@;

$createIndexRequest = @"
	 {
        name: '$($targetIndexName)',
        fields:
        [
            {
                name: 'Identifier',
                type: 'Edm.String',
                retrievable: true,
                sortable: true,
                searchable: true,
                filterable: true,
                facetable: true
            },
            {
                name: 'Version',
                type: 'Edm.Int64',
                searchable: false,
                retrievable: true,
                sortable: true,
                filterable: true,
                facetable: false
            },
            {
                name: 'Description',
                type: 'Edm.String',
                searchable: true,
                retrievable: true,
                sortable: false,
                filterable: false,
                facetable: false
            },
            {
                name: 'Active',
                type: 'Edm.Boolean',
                searchable: false,
                retrievable: true,
                sortable: false,
                filterable: true,
                facetable: false
            },
            {
                name: 'IsPublished',
                type: 'Edm.Boolean',
                searchable: false,
                retrievable: true,
                sortable: false,
                filterable: true,
                facetable: false
            },
            {
                name: 'Pipeline',
                type: 'Collection(Edm.String)',
                searchable: true,
                retrievable: true,
                filterable: false,
                sortable: false,
                facetable: false
            },
            {
                name: 'ApplicableDateUtc',
                type: 'Edm.DateTimeOffset',
                retrievable: true,
                filterable: true,
                searchable: false,
                sortable: true,
                facetable: false
            },
            {
                name: 'CreatedAtUtc',
                type: 'Edm.DateTimeOffset',
                retrievable: true,
                filterable: true,
                searchable: false,
                sortable: true,
                facetable: false
            },
            {
                name: 'UpdatedAtUtc',
                type: 'Edm.DateTimeOffset',
                retrievable: true,
                filterable: true,
                searchable: false,
                sortable: true,
                facetable: false
            },
            {
                name: 'rid',
                key: true,
                type: 'Edm.String',
                retrievable: true,
                filterable: true,
                searchable: true,
                sortable: false,
                facetable: false
            }
        ]
    }
"@;

$createIndexerRequest = @"
    {
        name: '$($indexerName)',
        dataSourceName: '$($datasourceName)',
        targetIndexName: '$($targetIndexName)',
        schedule: { interval: 'PT5M' }
    }
"@;
#endregion

#region - REST API
$paramInvokeRestMethod = @{
	Uri         = "https://$($azureSearchName).search.windows.net/datasources/$($datasourceName)?api-version=2017-11-11"
	Method      = 'PUT'
	Body        = $createDataSourceRequest
	Headers     = $headers
	ContentType = "application/json"
	Verbose     = $true
	ErrorAction = 'Stop'
}
Invoke-RestMethod @paramInvokeRestMethod

$paramInvokeRestMethod = @{
	Uri         = "https://$($azureSearchName).search.windows.net/indexes/$($targetIndexName)?api-version=2017-11-11"
	Method      = 'PUT'
	Body        = $createIndexRequest
	Headers     = $headers
	ContentType = "application/json"
	Verbose     = $true
	ErrorAction = 'Stop'
}
Invoke-RestMethod @paramInvokeRestMethod

$paramInvokeRestMethod = @{
	Uri         = "https://$($azureSearchName).search.windows.net/indexers/$($indexerName)?api-version=2017-11-11"
	Method      = 'PUT'
	Body        = $createIndexerRequest
	Headers     = $headers
	ContentType = "application/json"
	Verbose     = $true
	ErrorAction = 'Stop'
}
Invoke-RestMethod @paramInvokeRestMethod

$paramInvokeRestMethod = @{
	Uri         = "https://$($azureSearchName).search.windows.net/indexers/$($indexerName)/run?api-version=2017-11-11"
	Method      = 'POST'
	Headers     = $headers
	Verbose     = $true
	ErrorAction = 'Stop'
}
Invoke-RestMethod @paramInvokeRestMethod
#endregion