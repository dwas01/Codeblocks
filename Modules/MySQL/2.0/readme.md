# MySQL Database Server

This module deploys Azure Database for MySQL.

## Resources

The following Resources are deployed.

+ **Microsoft.DBforMySQL/servers**
+ **Microsoft.DBforMySQL/servers/firewallRules**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `serverName` || **Required** | Server Name for Azure database for MySQL
| `administratorLogin` || **Required** | Database administrator login name
| `administratorLoginPassword` || **Required** | Database administrator password
| `skuCapacity` | 2 | **Optional** | Azure database for MySQL compute capacity in vCores (2,4,8,16,32)
| `skuName` | GP_Gen5_2 | **Optional** | Azure database for MySQL sku name
| `SkuSizeMB` | 5120 | **Optional** | Azure database for MySQL Sku Size
| `SkuTier` | GeneralPurpose | **Optional** | Azure database for MySQL pricing tier
| `skuFamily` | Gen5 | **Optional** | Azure database for MySQL sku family
| `mysqlVersion` | 5.7 | **Optional** | MySQL version
| `location` || **Optional** | Location for all resources
| `backupRetentionDays` | 7 | **Optional** | MySQL Server backup retention days
| `geoRedundantBackup` | Disabled | **Optional** | Geo-Redundant Backup setting
| `virtualNetworkName` || **Required** | Virtual Network Name
| `subnetName` || **Required** | Subnet Name
| `virtualNetworkruleName` | AllowSubnet | Virtual Network RuleName
| `firewallruleList` || **Required** | MySQL Server firewall rule list
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `mySQLName` |  MySQL Database Name output parameter
| `mySQLResourceId` | MySQL Database Services ResourceId output parameter
| `mySQLResourceGroup` | MySQL Database Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `MySQL.akv.get.secrets.ps1` | Get MySQL Database Key Secrets as Azure DevOps variables
| `MySQL.akv.set.secrets.ps1` | Set MySQL Database Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Database for MySQL documentation](https://docs.microsoft.com/en-us/azure/mysql/)
+ [Microsoft Database for MySQL template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.dbformysql/allversions)
