# SQL Server Database

This module deploys SQLServer and Database Instances.

## Resources

The following Resources are deployed.

+ **Microsoft.Sql/servers**
+ **Microsoft.Sql/servers/databases**
+ **Microsoft.Sql/servers/firewallrules**
+ **Microsoft.Sql/servers/virtualNetworkRules**

## Deployment Prerequisites

On the SQL server the [Advanced Data Security](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security) capabilities and the vulnerability assessments are by default enabled.

Vulnerability Assessment is a scanning service built into the Azure SQL Database service.
When this option is enabled, the scan results are stored in a storage account
It is enabled by default for this deployment of the SQL server
The name of an existing storage account is required to deploy an Azure SQL Server with this option.

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `sqlServerName` || **Required** | Enter the SQL Server Name
| `sqlAdministratorLogin` || **Required** | Enter the SQL Server User Name
| `sqlAdministratorLoginPassword` || **Required** | Enter the SQL Server User Password
| `sqlDatabasesName` || **Required** | Enter the SQL databases name to be created
| `sqlDatabaseCollation` | SQL_Latin1_General_CP1_CI_AS | **Optional** | Enter SQL Database collation
| `location` || **Optional** | Location of all the Resources
| `allowAzureIp` | true | **Optional** | Whether the database is accessible by the Azure services
| `firewallvNetruleList` || **Required** | SQL Server firewall vNet rules list"
| `firewallruleList` || **Required** | SQL Server firewall rule list
| `skuName` | Standard | **Optional** | Name of the SQL Databse sku
| `skuTier` | S1 | **Optional** | Name of the SQL Database tier
| `diagnosticStorageAccountAccessKey` || **Required** | Access key for the storage account to be used for security diagnostics
| `retentionDays` | 30 | **Optional** | Specify the number of days data will be retained for
| `diagnosticStorageAccountName` || **Required** | Storage Account for diagnostics
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely
| `sqlServerActiveDirectoryGroupName` || **Required** | Name of the AAD group which will be set as a SQL Administrator
| `sqlServerActiveDirectoryGroupId` || **Required** | object ID of the AAD group which will be set as a SQL Administrator
| `sqlServerTenantId` || **Required** | Azure tenant id where the SQL Server is created
| `cuidId` || **Optional** | Azure Consumption Revenue Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `sqlServerdbName` | SQL Server Database Name output parameter
| `sqlServerdbResourceId` | SQL Server Database ResourceId output parameter
| `sqlServerdbResourceGroup` | SQL Server Database ResourceGroup output parameter

## Scripts

| Script Name | Description |
| :-          | :-          |
| `SQLServerDB.akv.get.secrets.ps1` | Get SQL Server Database Key Vault Secrets
| `SQLServerDB.akv.set.secrets.ps1` | Set SQL Server Database Key Vault Secrets
| `SQLServerDB.akv.admin.secret.ps1` | Set Key Vault Secrets for SQL Server Credentials Automation Script

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Microsoft SQL template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/allversions)
+ [Advanced data security for Azure SQL Database](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security)
+ [Deploy an Azure SQL Server with Auditing enabled to write audit logs to Azure Blob storage account](https://github.com/Azure/azure-quickstart-templates/tree/master/201-sql-auditing-server-policy-to-blob-storage)
+ [Deploy an Azure SQL Server with Auditing enabled to write audit logs to Log Analytics](https://github.com/Azure/azure-quickstart-templates/tree/master/201-sql-auditing-server-policy-to-oms)
+ [Deploy an Azure SQL Server with Auditing enabled to write audit logs to Event Hubs](https://github.com/Azure/azure-quickstart-templates/tree/master/201-sql-auditing-server-policy-to-eventhub)
