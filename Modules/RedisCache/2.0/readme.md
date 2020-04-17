# Azure Cache for Redis

This module deploys Azure Cache for Redis.

## Resources

The following Resources are deployed.

+ **Microsoft.Cache/Redis**
+ **Microsoft.Cache/redis/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `redisCacheName` || **Required** | The name of the Azure Cache for Redis
| `redisCachesku` | Premium | **Optional** | The type of Redis cache to deploy. Valid values: (Basic, Standard, Premium)
| `redisCacheFamily` | P | **Optional** | The sku family to use. Valid values: (C = Basic/Standard, P = Premium)
| `redisCacheCapacity` | 1 | **Optional** | The size of the Redis cache to deploy. Valid values: for C (Basic/Standard) family (0, 1, 2, 3, 4, 5, 6), for P (Premium) family (1, 2, 3, 4)
| `enableNonSSLPort` | false | **Optional** | A boolean value that indicates whether to allow access via non-SSL ports
| `vNetResourceGroup` || **Required** | The resource group Name of the existing Virtual Network
| `vNetResourceName` || **Required** | The name of the existing Virtual Network
| `subnetName` || **Required** | The name of the existing subnet
| `location` || **Optional** | Location for all Resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| :-          | :-          |
| `redisCacheName` |  Azure Cache for Redis Name output parameter
| `redisCacheResourceId` | Azure Cache for Redis ResourceId output parameter
| `redisCacheResourceGroup` | Azure Cache for Redis Resource Group output parameter
| `redisCacheKey` | Azure Cache for Redis Primary Key
| `redisCacheConnectionString` | Azure Cache for Redis Connection String
  
## Scripts

| Name | Description |
| :-   | :-          |
| `RedisCache.akv.get.secrets.ps1` | Get Azure Cache for Redis Key Secrets as Azure DevOps variables
| `RedisCache.akv.set.secrets.ps1` | Set Azure Cache for Redis Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Cache for Redis Documentation](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/)
+ [Microsoft Cache template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.cache/allversions)
+ [How to monitor Azure Cache for Redis](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-monitor#operations-and-alerts)
