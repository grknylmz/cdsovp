@AbapCatalog.sqlViewName: 'ZCINTCOMSY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZC_INTERCOMPANY_SY'

@UI.chart:[{
    qualifier: 'intcStatus',
    chartType: #BUBBLE,
    dimensions: ['Status'],
    measures: ['total_count1', 'total_count2', 'total_count3'],
    dimensionAttributes: {dimension: 'Status', role:#SERIES},
    measureAttributes: [
    {measure: 'total_count1', role: #AXIS_1, asDataPoint: true},
    {measure: 'total_count2', role: #AXIS_2, asDataPoint: true},
    {measure: 'total_count3', role: #AXIS_3, asDataPoint: true}
    ]
 }]

define view ZC_INTERCOMPANY_SY
  as select from sflight
{
  key carrid as Carrid,
  key connid as Connid,
  key fldate as Fldate,
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: { position: 10, qualifier: 'intcStatus', label: 'Check Intercompany Status', type:#AS_DATAPOINT }
      case when currency = 'USD'
      then 'Success'
      when currency = 'EUR'
      then 'Error'
      else 'Processing'
      end    as Status,
      @UI.dataPoint: {title: 'Count'}
      @UI.lineItem: [{position: 20, label: 'Count1', qualifier: 'intcStatus', type:#AS_DATAPOINT }]
      case when currency = 'USD'
         then 5
         when currency = 'EUR'
         then 10
         else 15
         end as total_count1,
      @UI.dataPoint: {title: 'Count'}
      @UI.lineItem: [{position: 30, label: 'Count2', qualifier: 'intcStatus', type:#AS_DATAPOINT }]
      case when currency = 'USD'
         then 20
         when currency = 'EUR'
         then 25
         else 30
         end as total_count2,
      @UI.dataPoint: {title: 'Count'}
      @UI.lineItem: [{position: 40, label: 'Count3', qualifier: 'intcStatus', type:#AS_DATAPOINT }]
      case when currency = 'USD'
         then 22
         when currency = 'EUR'
         then 23
         else 24
         end as total_count3
}
