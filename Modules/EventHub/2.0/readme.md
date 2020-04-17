# Event Hub

This module deploys Event Hub Namespace.

## Resources

The following Resources are deployed.

+ **Microsoft.EventHub/namespaces**
+ **Microsoft.EventHub/namespaces/providers/diagnosticSettings**
+ **Microsoft.EventHub/namespaces/AuthorizationRules**
+ **Microsoft.EventHub/namespaces/eventhubs**
+ **Microsoft.EventHub/namespaces/eventhubs/consumergroups**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `namespaceName` || **Required** | The name of the EventHub namespace
| `eventHubName` || **Required** | The name of the EventHub
| `messageRetentionInDays` | 1 | **Optional** | How long to retain the data in Event Hub
| `partitionCount` | 4 | **Optional** | Number of partitions chosen
| `location` || **Optional** | Location for all Resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `namespaceName` |  Event Hub Namespace Name output parameter
| `namespaceResourceId` | Event Hub Namespace ResourceId output parameter
| `namespaceResourceGroup` | Event Hub Namespace ResourceGroup output parameter
| `namespaceConnectionString` | Event Hub Namespace Connection String
| `namespacePrimaryKey` | Event Hub Namespace Shared Access Policy Primary Key

## Scripts

| Name | Description |
| :-   | :-          |
| `EventHub.akv.get.secrets.ps1` | Get Event Hub KeyVault Secrets as Azure DevOps variables
| `EventHub.akv.set.secrets.ps1` | Set Event Hub KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Event Hubs documentation](https://docs.microsoft.com/en-us/azure/event-hubs/)
+ [Microsoft EventHub template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.eventhub/allversions)
+ [Set up diagnostic logs for an Azure event hub](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-diagnostic-logs)
