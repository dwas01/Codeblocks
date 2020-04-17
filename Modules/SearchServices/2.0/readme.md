# Azure Cognitive Search

This module deploys Azure Cognitive Search.

## Resources

The following Resources are deployed.

+ **Microsoft.Search/searchServices**
+ **Microsoft.Search/searchServices/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `serviceName` || **Required** | Azure Cognitive Search Name
| `sku` | standard | **Optional** |  The sku of the search service e.g. free or standard
| `replicaCount` | 1 | **Optional** | Replicas distribute search workloads across the service. You need 2 or more to support high availability (applies to Basic and Standard only)
| `partitionCount` | 1 | **Optional** | Partitions allow for scaling of document count as well as faster indexing by sharding your index over multiple Azure Search units
| `hostingMode` | default | **Optional** | Applicable only for sku set to standard. You can set this property to enable a single, high density partition that allows up to 1000 indexes, which is much higher than the maximum indexes allowed for any other SKU
| `location` || **Optional** | Location for all Resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `azureSearchName` |  Azure Cognitive Search Name output parameter
| `azureSearchResourceId` | Azure Cognitive Search ResourceId output parameter
| `azureSearchResourceGroup` | Azure Cognitive Search Resource Group output parameter
  
## Scripts

| Name | Description |
| :-   | :-          |
| `SearchServices.akv.get.secrets.ps1` | Get Azure Cognitive Search Key Secrets as Azure DevOps variables
| `SearchServices.akv.set.secrets.ps1` | Set Azure Cognitive Search Key Secrets
| `SearchServices.search.index.profile.ps1` | Sample script to configure Azure Cognitive Search index  

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Cognitive Search documentation](https://docs.microsoft.com/en-us/azure/search/)
+ [Microsoft Search template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.search/allversions)
