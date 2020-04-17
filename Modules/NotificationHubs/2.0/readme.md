# Notification Hubs

This module deploys Notification Hubs.

## Resources

The following Resources are deployed.

+ **Microsoft.NotificationHubs/namespaces**
+ **Microsoft.NotificationHubs/namespaces/notificationHubs**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `namespaceName` || **Required** | The name of the Notification Hubs namespace
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `notificationHubsName` |  Notification Hubs Name output parameter
| `notificationHubsResourceId` | Notification Hubs ResourceId output parameter
| `notificationHubsResourceGroup` | Notification Hubs Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `NotificationHubs.akv.get.secrets.ps1` | Get Notification Hubs Key Secrets as Azure DevOps variables
| `NotificationHubs.akv.set.secrets.ps1` | Set Notification Hubs Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Notification Hubs Documentation](https://docs.microsoft.com/en-us/azure/notification-hubs/)
+ [Microsoft Notification Hub template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.notificationhubs/allversions)
