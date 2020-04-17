# SQL Data Warehouse

This module deploys a SQL Data Warehouse Database.

## Deployed Resources

The following Resources are deployed.

+ **Microsoft.Sql/servers/databases**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `sqlDatabasesNames` || **Required** | Enter the SQL databases names to be created
| `sqlDatabaseCollation` | SQL_Latin1_General_CP1_CI_AS | **Optional** | Enter SQL Database collation
| `sqlServerName` || **Required** | Enter the SQL Server Name
| `sku` || **Required** | Array to pass through name and tier
| `transparentDataEncryption` | Enabled | **Optional** | Enable/Disable Transparent Data Encryption
| `serverKeyType` | ServiceManaged | **Optional** |The key type of the server (akv or service managed)
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Azure Resource Tags object

## Outputs

+ There is no Outputs in this Module

## Scripts

+ There is no Scripts in this Module

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Microsoft SQL template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/allversions)
