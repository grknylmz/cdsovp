@AbapCatalog.sqlViewName: 'ZCRESMONSY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZC_RESPONSEMONITOR_SY'

@UI.chart:[{
    qualifier: 'resmStatus',
    chartType: #DONUT,
    dimensions: ['posnr'],
    measures: ['total_count'],
    dimensionAttributes: { dimension: 'posnr', role:#CATEGORY },
    measureAttributes: [{ measure: 'total_count', role: #AXIS_1, asDataPoint: true }]
 }]

define view ZC_RESPONSEMONITOR_SY
  as select from vbrp
{
  key posnr,
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: { position: 10, qualifier: 'resmStatus', label: 'Status', type:#AS_DATAPOINT }
      case when posnr = '000010'
      then 'Success'
      when posnr = '000020'
      then 'Error'
      else 'Processing'
      end      as Status,
      @UI.dataPoint: { title: 'Count' }
      @UI.lineItem: [{ position: 20, label: 'Count', qualifier: 'resmStatus', type:#AS_DATAPOINT }]
      count(*) as total_count
}
group by
  posnr
