# Service Bus

This module deploys Service Bus.

## Resources

The following resources are deployed.

+ **Microsoft.ServiceBus/namespaces***
+ **Microsoft.ServiceBus/namespaces/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `serviceBusNamespaceName` || **Required** | Name of the Service Bus namespace
| `serviceBusTopicName` || **Required** | Name of the Service Bus Topic
| `serviceBusSku` | Standard | **Optional** | The messaging tier for service Bus namespace
| `sendListenSASKeyName` || **Required** | Name of the Send Listen Namespace Authorization Rule
| `location` || **Optional** | Location for all resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `serviceBusNamespaceName` |  Service Bus Namespace Name output parameter
| `serviceBusResourceId` | Service Bus ResourceId output parameter
| `serviceBusResourceGroup` | Service Bus ResourceGroup output parameter
| `serviceBusConnectionString` | Service Bus Connection String
| `serviceBusPrimaryKey` | Service Bus Primary Key
| `serviceBusSendListenConnectionString` | Service Bus Send Listen Connection String
| `serviceBusSendListenPrimaryKey` | Service Bus Send Listen Primary Key
| `serviceBusSendListenSASKeyName` | Service Bus Send SAS Key Name
| `serviceBusEndpoint"`| Service Bus EndPoint URL

## Scripts

| Script Name | Description |
| :-          | :-          |
| `ServiceBus.akv.get.secrets.ps1` | Get Service Bus Key Vault Secrets
| `ServiceBus.akv.set.secrets.ps1` | Set Service Bus Key Vault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Service Bus Documentation](https://docs.microsoft.com/en-us/azure/service-bus/)
+ [Microsoft Service Bus template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.servicebus/allversions)
+ [Microsoft Service Bus diagnostic settings reference](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-diagnostic-logs)
