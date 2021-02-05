@AbapCatalog.sqlViewName: 'ZCNACRICSY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZC_NACRICHTEN_SY'

@UI.chart:[{
    qualifier: 'nachStatus',
    chartType: #AREA,
    dimensions: ['Bukrs', 'adrnr', 'Status'],
    measures: ['total_count'],
    dimensionAttributes: [
    {dimension: 'Bukrs', role:#CATEGORY},
    {dimension: 'adrnr', role:#CATEGORY},
    {dimension: 'Status', role:#CATEGORY}
    ],
    measureAttributes: [{measure: 'total_count', role: #AXIS_1, asDataPoint: true}]
 }]

define view ZC_NACRICHTEN_SY
  as select from t001
{
  key bukrs  as Bukrs,
      adrnr,
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: { position: 10, qualifier: 'nachStatus', label: 'Status', type:#AS_DATAPOINT }
      case when waers = 'EUR'
      then 'Success'
      when waers = 'USD'
      then 'Error'
      else 'Processing'
      end    as Status,
      @UI.dataPoint: {title: 'Count'}
      @UI.lineItem: [{position: 20, label: 'Count', qualifier: 'nachStatus', type:#AS_DATAPOINT }]
      case when waers = 'USD'
         then 10
         when waers = 'EUR'
         then 20
         else 30
         end as total_count
}
