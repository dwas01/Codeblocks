# App Services

This module deploys an Application Web Services.

## Resources

The following Resources are deployed.

+ **Microsoft.Web/serverfarms**
+ **Microsoft.Web/sites**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `hostingPlanName` || **Required** | Name of the Application Service Plan
| `sku` | Standard | **Optional** | The sku name of the Aapp service plan to create
| `skuCode` | S1 | **Optional** | Defines which worker pool's (S1=Small, S2=Medium, S3=Large) resources will be used for the app service plan
| `appWorkers` | 2 | **Optional** | Defines the number of workers from the worker pool that will be used by the app service plan
| `webAppPortalName` || **Required** |Name of the Web Application Portal Name
| `location` || **Optional** | Location for all Resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `appServicesName` |  Application Web Services Name output parameter
| `appServicesResourceId` | Application Web Services - Web ResourceId output parameter
| `appServicesResourceGroup` | Application Web Services - Web Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `AppServices.akv.get.secrets.ps1` | Get Application Web Services - Web KeyVault Secrets as Azure DevOps variables
| `AppServices.akv.set.secrets.ps1` | Set Application Web Services - Web KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [App Service Documentation](https://docs.microsoft.com/en-us/azure/app-service/)
+ [Microsoft Web template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.web/allversions)
