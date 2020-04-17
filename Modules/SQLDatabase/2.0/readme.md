# SQL Database

This module deploys a SQL database to an existing SQL server.

## Resources

The following Resources are deployed.

+ **Microsoft.Sql/servers/databases**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `databaseNames` || **Required** | SQL databases names to be created
| `skuName` | S1| **Optional** | Name of the SQL Databse sku
| `skuTier` | Standard | **Optional** | Name of the SQL Database tier
| `collation` | SQL_Latin1_General_CP1_CI_AS | **Optional** | The collation of the database
| `maxSizeBytes` | 34359738368 | **Optional** | The max size of the database expressed in bytes
| `sqlServerName` || **Required** | The name of the SQL server on which the database will be created
| `zoneRedundant` | false | **Optional** | Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones
| `licenseType` | LicenseIncluded | **Optional** | The license type to apply for this database. - LicenseIncluded or BasePrice
| `readScale` | Disabled | **Optional** | If the database is a geo-secondary, readScale indicates whether read-only connections are allowed to this database or not. Enabled or Disabled
| `readReplicaCount` | 0 | **Optional** | Number of replicas to be created
| `minCapacity` || **Optional** | Minimal capacity that database will always have allocated, if not paused
| `autoPauseDelay` || **Optional** | Defines the period of time the database must be inactive before it is automatically paused.
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

+ [Microsoft SQL Database template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/2017-10-01-preview/servers/databases)
