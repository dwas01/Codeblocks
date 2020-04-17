# PostgreSQL

This module deploys PostgreSQL.

## Resources

The following Resources are deployed.

+ **Microsoft.DBforPostgreSQL/servers**
+ **Microsoft.DBforPostgreSQL/servers/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `serverName` || **Required** | Azure database for PostgreSQL Server Name
| `databaseName` || **Required** | Azure database for PostgreSQL Database Name
| `administratorLogin` || **Required** | Azure database for PostgreSQL administrator login name
| `administratorLoginPassword` || **Required** | Azure database for PostgreSQL administrator password
| `databaseSkuCapacity` | 2 | **Optional** | Azure database for PostgreSQL compute capacity in vCores (2,4,8,16,32)
| `databaseSkuName` | GP_Gen5_2 | **Optional** | Azure database for PostgreSQL sku name
| `databaseSkuSizeMB` | 51200 | **Optional** | Azure database for PostgreSQL Sku Size
| `databaseSkuTier` | GeneralPurpose | **Optional** | Azure database for PostgreSQL pricing tier
| `databaseskuFamily` | Gen5 | **Optional** | Azure database for PostgreSQL sku family
| `postgresqlVersion` | 11 | **Optional** | PostgreSQL version
| `backupRetentionDays` | 5 |**Optional** | Specifies the Backup retention number of days
| `location` || **Optional** | Location for all Resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `postgreSQLName` |  PostgreSQL Server Name output parameter
| `postgreSQLDBName` |  PostgreSQL Database Name output parameter
| `postgreSQLResourceId` | PostgreSQL ResourceId output parameter
| `postgreSQLResourceGroup` | PostgreSQL Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `postgreSQL.akv.get.secrets.ps1` | Get PostgreSQL Key Secrets as Azure DevOps variables
| `postgreSQL.akv.set.secrets.ps1` | Set PostgreSQL Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Database for PostgreSQL documentation](https://docs.microsoft.com/en-us/azure/postgresql/)
+ [Microsoft DB for PostgreSQL template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.dbforpostgresql/allversions)
+ [Logs in Azure Database for PostgreSQL - Single Server](https://docs.microsoft.com/en-us/azure/postgresql/concepts-server-logs#diagnostic-logs)
