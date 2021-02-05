@AbapCatalog.sqlViewName: 'ZCRESPMNPS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Response monitor stats'
@UI.chart: [{
      qualifier: 'Q5',
      title: 'Statistics',
      chartType: #DONUT,
      dimensions: ['posnr'],
      measures: ['total'],
      dimensionAttributes: [{ dimension: 'posnr', role: #CATEGORY }],
      measureAttributes: [{ measure: 'total', role: #AXIS_1, asDataPoint: true }]
      }]

define view ZC_RESPMON_PS
  as select from ZC_ResponseMonitorStatsV2
{
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{position: 10, label: 'Billing Document', qualifier: 'Q1' }]
  key posnr,
      @UI.dataPoint: {title: 'Status count',
      criticalityCalculation: {
      improvementDirection: #TARGET,
      toleranceRangeLowValue: 10,
      deviationRangeHighValue: 17
      }}
      @UI.lineItem: [{position: 20, label: 'Status Count', qualifier: 'Q5', type:#AS_DATAPOINT }]
  key count(*) as total,
      @UI.dataPoint: {title: 'Count', criticality: 'Criticality'}
      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{position: 30, label: 'Status', qualifier: 'Q1', type:#AS_DATAPOINT }]
      case when posnr = '000010'
           then 'Success'
           when posnr = '000020'
           then 'Error'
           else 'Processing'
           end as Status,

      case when posnr = '000020'
      then '1'
      when posnr = '000010'
      then '3'
      else '2'
      end      as Criticality
}
group by
  posnr
