# Stream Analytics

This module deploys a Standard Stream Analytics Job

## Resources

The following Resources are deployed.

+ **Microsoft.StreamAnalytics/StreamingJobs**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `streamAnalyticsJobName` || **Required** | Stream Analytics Job Name
| `numberOfStreamingUnits` | 1 | **Optional** | Number of Streaming Units
| `location` || **Optional** | Location of the Azure Analysis Services server
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `streamAnalyticsName` | Stream Analytics Name output parameter
| `streamAnalyticsResourceId` | Stream Analytics ResourceId output parameter
| `streamAnalyticsResourceGroup` | Stream Analytics Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `StreamAnalytics.akv.get.secrets.ps1` | Get Stream Analytics Key Secrets as Azure DevOps variables
| `StreamAnalytics.akv.set.secrets.ps1` | Set Stream Analytics Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Azure Stream Analytics documentation](https://docs.microsoft.com/en-us/azure/stream-analytics/)
+ [Microsoft Stream Analytics template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.streamanalytics/allversions)
