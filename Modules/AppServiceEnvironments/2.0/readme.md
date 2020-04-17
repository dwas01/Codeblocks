# Application Server Environment (ASE)

This module deploys Application Server Environment (ASE).

## Resources

The following Resources are deployed.

+ **Microsoft.Web/hostingEnvironments**
+ **Microsoft.Web/serverfarms**
+ **Microsoft.Web/sites**
+ **Microsoft.Insights/autoscalesettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `aseName` || **Required** | Name of the Application Service Environment
| `location` || **Optional** | Location for all Resources
| `aseIPSSLAddressCount` | 0 | **Optional** | Number of IP addresses for the IP-SSL address pool.  This value *must* be zero when internalLoadBalancing mode is set to either 1 or 3
| `aseInternalLoadBalancingMode` | 1 | **Optional** | 0 = public VIP only, 1 = only ports 80/443 are mapped to ILB VIP, 2 = only FTP ports are mapped to ILB VIP, 3 = both ports 80/443 and FTP ports are mapped to an ILB VIP
| `dnsSuffix` || **Required** | Used *only* when deploying an ILB enabled ASE.  Set this to the root domain associated with the ASE.  For example: contoso.com
| `appInsightsKey` || **Required** | Instrumentation Key the Application Insights Resource
| `webServicePlanName` || **Required** | Name of the Web Application Service Plan
| `webAppPortalName` || **Required** | Name of the Web Application Portal Name
| `webworkerpool` | 1 | **Optional** | Defines which worker pool's (1=Small, 2=Medium, 3=Large) resources will be used for the application service plan
| `webWorkers` | 2 | **Optional** | Defines the number of workers from the worker pool that will be used by the application service plan
| `vnetResourceGroupName` || **Required** | The resource group name that contains the vnet
| `vnetResourceName` || **Required** | The name of the virtual network
| `subnetName` || **Required** | Subnet name that will contain the App Service Environment
| `frontEndSize` | Medium | **Optional** | Instance size for the front-end pool. Maps to P2,P3,P4
| `frontEndCount` | 2 | **Optional** | Number of instances in the front-end pool. Minimum of two
| `minimumCapacityProfile` | 5 | **Optional** | The minimum capacity. Autoscale engine will ensure the instance count is at least this value
| `maximumCapacityProfile` | 20 | **Optional** | The maximum capacity. Autoscale engine will ensure the instance count is not greater than this value
| `defaultCapacityProfile` | 5 | **Optional** | The default capacity. Autoscale engine will preventively set the instance count to be this value if it can not find any metric data
| `metricName` | CpuPercentage | **Optional** | The metric name "CpuPercentage"
| `metricThresholdToScaleOut` | 60 | **Optional** | The metric upper threshold.  If the metric value is above this threshold then autoscale engine will initiate scale out action
| `metricThresholdToScaleIn` | 10 | **Optional** | The metric lower threshold.  If the metric value is below this threshold then autoscale engine will initiate scale in action
| `changePercentScaleOut` | 20 | **Optional** | The percentage to increase the instance count when autoscale engine is initiating scale out action
| `changePercentScaleIn` | 10 | **Optional** | The percentage to decrease the instance count when autoscale engine is initiating scale in action
| `autoscaleEnabled` | true | **Optional** | A boolean to indicate whether the autoscale policy is enabled or disabled  
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `appServiceEnvironmentName` |  Application Service Environment Name output parameter
| `appServiceEnvironmentResourceId` | Application Service Environment ResourceId output parameter
| `appServiceEnvironmentResourceGroup` | Application Service Environment Resource Group output parameter
| `appServiceEnvironmentwebPortalURL` | Application Service Environment Web Application Portal URL

## Scripts

| Name | Description |
| :-   | :-          |
| `AppServiceEnvironments.akv.get.secrets.ps1` | Get Application Service Environment KeyVault Secrets as Azure DevOps variables
| `AppServiceEnvironments.akv.set.secrets.ps1` | Set Application Service Environment KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [App Service Documentation](https://docs.microsoft.com/en-us/azure/app-service/)
+ [Microsoft Web template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.web/allversions)
