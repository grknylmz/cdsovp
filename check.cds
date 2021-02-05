@AbapCatalog.sqlViewName: 'ZCCHEKNCRCHPS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Check Nacrich'

@UI.headerInfo: {
typeName: 'Check Nacrich',
typeNamePlural: 'Check Nacrichs',
 title: {
    label: 'Company Code',
    value: 'Bukrs'
  },
  description: {
    label: 'Status',
    value: 'Status',
    criticality: 'Criticality'
  }}

@UI.chart: [{
    qualifier: 'Q6',
    title: 'Statistics',
    chartType: #BUBBLE,
    dimensions: ['Status'],
    measures: ['Criticality', 'tot_stat', 'total_status'],
    dimensionAttributes: [{ dimension: 'Status', role: #SERIES }],
    measureAttributes: [
    { measure: 'Criticality', role: #AXIS_1, asDataPoint:true },
    { measure: 'tot_stat', role: #AXIS_2, asDataPoint:true},
    { measure: 'total_status', role: #AXIS_3, asDataPoint:true } ]
    }]


define view ZC_CHECKNACRICH_PS
  as select from ZC_CheckNacrichtenStatsV2
{
      //ZC_CheckNacrichtenStatsV2
  key Bukrs,
      @UI.lineItem: [{position: 80, label: 'Status' }]
      Status,
      @UI.dataPoint: {title: 'Count1'}
      @UI.lineItem: [{position: 130, label: 'Count1', qualifier: 'Q6', type:#AS_DATAPOINT }]
      case when Status = 'Error'
       then 1
       when Status = 'Success'
       then 3
       else 2
       end   as Criticality,

      @UI.dataPoint: {title: 'Count2'}
      @UI.lineItem: [{position: 100, label: 'Count2', qualifier: 'Q6', type:#AS_DATAPOINT }]
      case when Status = 'Error'
       then 6
       when Status = 'Success'
       then 3
       else 5
       end   as tot_stat,

      @UI.dataPoint: {title: 'Count3'}
      @UI.lineItem: [{position: 110, label: 'Count3', qualifier: 'Q6', type:#AS_DATAPOINT }]
      case when Status = 'Error'
         then 2
         when Status = 'Success'
         then 3
         else 4
         end as total_status


}
