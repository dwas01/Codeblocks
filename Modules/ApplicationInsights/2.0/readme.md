# Application Insights

This module deploys Application Insights.

## Resources

The following Resources are deployed.

+ **Microsoft.Insights/components**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `appInsightsName` || **Required** | Name of the Application Insights
| `appInsightsType` | web | **Optional** | Application type
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `appInsightsName` | Application Insights Resource Name
| `appInsightsResourceId` | Application Insights Resource Id
| `appInsightsResourceGroup` | Application Insights ResourceGroup
| `appInsightsKey` | Application Insights Resource Instrumentation Key
| `appInsightsAppId` | Application Insights Application Id

## Scripts

| Output Name | Description |
| :-          | :-          |
| `ApplicationInsights.akv.get.secrets.ps1` | Get Application Insights KeyVault Secrets as Azure DevOps variables
| `ApplicationInsights.akv.set.secrets.ps1` | Set Application Insights KeyVault Secrets
| `ApplicationInsights.continuous.export.ps1` |  Configures Application Insights Continuous Export Configuration

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Microsoft Application Insights Documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/overview)
+ [Microsoft Application Insights template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.insights/allversions)
