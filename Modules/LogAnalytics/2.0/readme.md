# Log Analytics

This module deploys Log Analytics.

## Resources

The following Resources are deployed.

+ **Microsoft.OperationalInsights/workspaces**  
+ **Microsoft.OperationsManagement/solutions**

## Parameters

 Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `logAnalyticsWorkspaceName` || **Required** | Specify Log Analytics Workspace Name
| `logAnalyticsRegion` || **Required** | Specify the Log Analytics Region
| `logAnalyticsSku` | PerNode | **Optional** | Specify the SKU for Log Analytics
| `logAnalyticsdataRetention` | 30 | **Optional** |Specify the number of days data will be retained for
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `logAnalyticsName` | The Workspace name of the Log Analytics
| `logAnalyticsResourceId` | The ResourceId of the Log Analytics
| `logAnalyticsResourceGroup` | The name of the Resource Group with the LogAnalytics
| `logAnalyticsWorkspaceId` | The Log Analytics WorkspaceId
| `logAnalyticsPrimarySharedKey` | The Log Analytics Primary Shared Key
  
## Scripts

| Script Name | Description |
| :-          | :-          |
| `LogAnalytics.akv.get.secrets.ps1` | Get Log Analytics Key Secrets
| `LogAnalytics.akv.set.secrets.ps1` | Set Log Analytics Key Secrets
| `LogAnalytics.install.solutions.ps1` | Install Log Analytics Solutions Deployment Automation

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Monitor overview](https://docs.microsoft.com/en-us/azure/azure-monitor/overview)
+ [Microsoft Operational Insights template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.operationalinsights/allversions)
