# Event Grid

This module deploys Event Grid.

## Resources

The following Resources are deployed.

+ **Microsoft.EventGrid/topics**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `eventGridTopicName` || **Required** | The name of the Event Grid Topic
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `eventGridName` |  Event GridName output parameter
| `eventGridResourceId` | Event Grid ResourceId output parameter
| `eventGridResourceGroup` | Event Grid Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `EventGrid.akv.get.secrets.ps1` | Get Event Grid KeyVault Secrets as Azure DevOps variables
| `EventGrid.akv.set.secrets.ps1` | Set Event Grid KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Event Grid documentation](https://docs.microsoft.com/en-us/azure/event-grid/)
+ [Microsoft EventGrid template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.eventgrid/allversions)
