@AbapCatalog.sqlViewName: 'ZCCHCKBUCLPS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Check buchaltungs'

@UI.chart: [{
      qualifier: 'Q4',
      title: 'Statistics',
      chartType: #WATERFALL,
      dimensions: ['Status'],
      measures: ['tot_stat'],
      dimensionAttributes: [{ dimension: 'Status', role: #CATEGORY }],
      measureAttributes: [{ measure: 'tot_stat', role: #AXIS_1, asDataPoint: true }]
      }]

define view ZC_CHECKBUCHAL_PS
  as select from ZC_CheckBuchaltungsStatsV2
{

  key  Matnr,
       @UI.dataPoint: {title: 'Count',
          criticalityCalculation: {
          improvementDirection: #TARGET,
          toleranceRangeLowValue: 2,
          deviationRangeHighValue: 4
          }}
       @UI.lineItem: [{position: 90, label: 'Count', qualifier: 'Q2', type:#AS_DATAPOINT }]
       case when Status = 'Error'
            then 6
            when Status = 'Success'
            then 3
            else 1
            end as total,
       @UI.lineItem: [{position: 50, label: 'Progress', qualifier: 'Q2' }]
       Status,

       @UI.dataPoint: {title: 'Status count'}
       @UI.lineItem: [{position: 100, label: 'Status Count', qualifier: 'Q4', type:#AS_DATAPOINT }]
       case when Status = 'Error'
         then 6
         when Status = 'Success'
         then 3
         else 1
         end    as tot_stat
}

