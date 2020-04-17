# Cosmosdb

This module deploys a Cosmosdb Database Account.

## Resources

The following Resources are deployed.

+ **Microsoft.DocumentDB/databaseAccounts**
+ **Microsoft.DocumentDB/databaseAccounts/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `databaseAccountName` || **Required** | Cosmosdb Database Account Name
| `apiType` | SQL | **Optional** | Cosmosdb Database Account API type
| `tier` | Standard | **Optional** | Cosmosdb Database Account tier
| `location` || **Optional** | Location for all Resources
| `vNetResourceGroup` || **Required** | The resource group Name of the existing Virtual Network
| `vNetResourceName` || **Required** | The name of the existing Virtual Network
| `subnetName` || **Required** | The name of the existing subnet
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `cosmosdbAccountName` | Cosmosdb Database Account Name output parameter
| `cosmosdbResourceId` | Cosmosdb Database Account ResourceId output parameter
| `cosmosdbResourceGroup` | Cosmosdb Database Account ResourceGroup output parameter
| `cosmosdbEndpoint` | Cosmosdb Database Account Endpoint
| `cosmosdbAccountKey` | Cosmosdb Database Account Primary Master Key
| `cosmosdbConnectionString` | Cosmosdb Database Account Connection String
| `cosmosdbTableApiConnectionString` | Cosmosdb Database Account TableAPI ConnectionString
| `cosmosdbvNetResourceGroup` | Cosmosdb Database Account vNet Resource Group Name
| `cosmosdbvNetResourceName` | Cosmosdb Database Account vNet Resource Name
| `cosmosdbSubnetName` | Cosmosdb Database Account subnet name

## Scripts

| Name | Description |
| :-   | :-          |
| `Cosmosdb.akv.get.secrets.ps1` | Get Cosmosdb Database Account KeyVault Secrets as Azure DevOps variables
| `Cosmosdb.akv.set.secrets.ps1` | Set Cosmosdb Database Account KeyVault Secrets
| `Cosmosdb.firewall.ps1` | Cosmosdb Database Account autoamtion script to enable firewall
| `Cosmosdb.provision.rule.setcollection.ps1` | Cosmosdb Database Account automation script to set collection within a Cosmosdb Account

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Azure CosmosDB documentation](https://docs.microsoft.com/en-us/azure/cosmos-db/)
+ [Microsoft Documentdb template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.documentdb/allversions)
+ [Diagnostic logging in Azure CosmosDB](https://docs.microsoft.com/en-us/azure/cosmos-db/logging)
