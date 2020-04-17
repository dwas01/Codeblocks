# HDInsight - Cluster

This module deploys HDInsights Cluster.

## Resources

The following Resources are deployed.

+ **Microsoft.HDInsight/clusters**
+ **Microsoft.HDInsight/clusters/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `clusterName` || **Required** | The name of the HDInsight cluster
| `clusterLoginUserName` || **Required** | These credentials can be used to submit jobs to the cluster and to log into cluster dashboards
| `clusterLoginPassword` || **Required** | The password must be at least 10 characters in length and must contain at least one digit, one non-alphanumeric character, and one upper or lower case letter
| `clusterType` | hadoop | **Optional** | The type of the HDInsight cluster to create
| `clusterKind ` | hadoop | **Optional** | The kind of the HDInsight cluster to create
| `clusterVersion` | 3.6 | **Optional** |  HDInsight cluster version
| `sshUserName` || **Required** | These credentials can be used to remotely access the cluster
| `sshPublicKey` || **Required** | The password must be at least 10 characters in length and must contain at least one digit, one non-alphanumeric character, and one upper or lower case letter 
| `clusterWorkerNodeCount` | 4 | **Optional** | The number of nodes in the HDInsight cluster
| `clusterStorageAccountName` || **Required** | The name of the Azure storage account
| `filesystem` | defaultfilesystem | **Optional** | The filesystem, only to be specified for Azure Data Lake Storage type Gen 2
| `storageaccountResourceId` || **Required** | Resource identifier of the Cluster Storage Account
| `managedIdentityResourceId` || **Required** | Resource identifier of the Cluster Managed Identity
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `hdInsightClusterName` |  HDInsight Cluster Name output parameter
| `hdInsightClusterResourceId` | HDInsight Cluster ResourceId output parameter
| `hdInsightClusterResourceGroup` | HDInsight Cluster Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `HDInsightCluster.akv.set.secrets.ps1` | Get HDInsight Cluster KeyVault Secrets as Azure DevOps variables
| `HDInsightCluster.akv.get.secrets.ps1` | Set HDInsight Cluster KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure HDInsight documentation](https://docs.microsoft.com/en-us/azure/hdinsight/)
+ [Microsoft HDInsight template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.hdinsight/allversions)
