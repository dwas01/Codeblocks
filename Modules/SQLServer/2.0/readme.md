# SQL Database Server

This module deploys the logical SQL server where SQL databases can deployed to.

## Resources

The following Resources are deployed.

+ **Microsoft.Sql/servers**
+ **Microsoft.Sql/servers/firewallrules**
+ **Microsoft.Sql/servers/virtualNetworkRules**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `sqlServerName` || **Required** | The name of the SQL server on which the database will be created
| `sqlAdministratorLogin` || **Required** |  Administrator username for the server
| `sqlAdministratorLoginPassword` || **Required** | The password given to the Server Administrator User
| `location` || **Optional** | Location of SQL Server Resources
| `allowAzureIp` | true | **Optional** | Whether the database is accessible by the Azure services
| `firewallVnetruleList` || **Required** | SQL Server firewall vNet rules list"
| `firewallruleList` || **Required** | SQL Server firewall rule list
| `diagnosticStorageAccountName` || **Required** | The storage account name where the vulnerability assesments scan results will be stored
| `diagnosticStorageAccountAccessKey` || **Required** | Access key for the storage account to be used for security diagnostics
| `retentionDays` | 30 | **Optional** | Specify the number of days data will be retained for
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `sqlServerName` |  SQL Server Name output parameter
| `sqlServerResourceId` | SQL Server ResourceId output parameter
| `sqlServerResourceGroup` | SQL Server Resource Group output parameter


## Scripts

| Name | Description |
| :-   | :-          |
| `SQLServer.akv.get.secrets.ps1` | Get SQL Server Key Secrets as Azure DevOps variables
| `SQLServer.akv.set.secrets.ps1` | Set SQL Server Key Secrets

## Deployment Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Microsoft SQL template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/allversions)
+ [Deploy an Azure SQL Server with Auditing enabled to write audit logs to Azure Blob storage account](https://github.com/Azure/azure-quickstart-templates/tree/master/201-sql-auditing-server-policy-to-blob-storage)
+ [Deploy an Azure SQL Server with Auditing enabled to write audit logs to Log Analytics](https://github.com/Azure/azure-quickstart-templates/tree/master/201-sql-auditing-server-policy-to-oms)
+ [Deploy an Azure SQL Server with Auditing enabled to write audit logs to Event Hubs](https://github.com/Azure/azure-quickstart-templates/tree/master/201-sql-auditing-server-policy-to-eventhub)
