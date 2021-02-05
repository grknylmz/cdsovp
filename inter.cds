@AbapCatalog.sqlViewName: 'ZCFKNTRCOMPS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Fkintercompany'

@UI.chart: [{
      qualifier: 'Q3',
      title: 'Statistics',
      chartType: #COLUMN,
      dimensions: ['Status'],
      measures: ['tot_stat'],
      dimensionAttributes: [{ dimension: 'Status', role: #CATEGORY }],
      measureAttributes: [{ measure: 'tot_stat', role: #AXIS_1, asDataPoint: true }]
      }]
           

define view ZC_FKINTERCOM_PS
  as select from ZC_FKIntercompanyStatV2
{
      //ZC_FKIntercompanyStatV2
  key Carrid,
  key Connid,
  key Fldate,
      @UI.lineItem: [{position: 60, label: 'Billing Document', qualifier: 'Q3' }]
      Status,

      @UI.dataPoint: {title: 'Status count'}
      @UI.lineItem: [{position: 70, label: 'Status Count', qualifier: 'Q3', type:#AS_DATAPOINT }]
      case when Status = 'Error'
            then 6
            when Status = 'Success'
            then 3
            else 1
            end as tot_stat
}

