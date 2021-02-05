@AbapCatalog.sqlViewName: 'ZCBUCHALSY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZC_BUCHALTUNGS_SY'

@UI.chart:[{
    qualifier: 'buchStatus',
    chartType: #COLUMN,
    dimensions: ['Status'],
    measures: ['total_count'],
    dimensionAttributes: {dimension: 'Status', role:#CATEGORY},
    measureAttributes: [{measure: 'total_count', role: #AXIS_1, asDataPoint: true}]
 }]
define view ZC_BUCHALTUNGS_SY
  as select from mara
{

  key matnr  as Matnr,
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: { position: 10, qualifier: 'buchStatus', label: 'Response Monitor Status' }
      case when aenam = 'BPINST'
      then 'Success'
      when aenam = 'AMIHAYLOVA'
      then 'Error'
      else 'Processing'
      end    as Status,
      @UI.dataPoint: {title: 'Count'}
      @UI.lineItem: [{position: 20, label: 'Count', qualifier: 'buchStatus', type:#AS_DATAPOINT }]
      case when aenam = 'BPINST'
         then 11
         when aenam = 'AMIHAYLOVA'
         then 22
         else 33
         end as total_count
}
