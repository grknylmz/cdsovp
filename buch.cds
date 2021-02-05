@AbapCatalog.sqlViewName: 'ZCBUCHALSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Demo view'
@VDM.viewType: #CONSUMPTION

@UI.chart: [{
      qualifier: 'Q2',
      title: 'Buchalstatungs status',
      chartType: #DONUT,
      dimensions: ['Matnr'],
      measures: ['TotalCount'],
      dimensionAttributes: [{ dimension: 'Matnr', role: #CATEGORY }],
      measureAttributes: [{ measure: 'TotalCount', role: #AXIS_1, asDataPoint: true }]
      }]


define view ZC_BUCHALSTAT
  as select from ZC_CheckBuchaltungsStatsV2
{


      @UI.lineItem: [{ position: 10, label: 'Company Code', qualifier: 'Q1'}]
  key Matnr,

      @UI.dataPoint:
              {
              targetValueElement: 'Status',
              criticality: 'Criticality' }
      @UI.lineItem: [{ position: 20, label: 'Status', qualifier: 'Q1', type: #AS_DATAPOINT }]
      Status,
      @UI.lineItem: [{ position: 30, label: 'Created On', qualifier: 'Q1'}]
      ersda,

      case Status
      when 'Error' then 1
      when 'Success' then 3
      else 2

      end                      as Criticality,


      @UI.dataPoint: {

          title: 'TotalCountStatus',
          criticalityCalculation: {
              improvementDirection: #TARGET,
              toleranceRangeLowValue: 10,
              deviationRangeHighValue: 17
          }
      }

      @UI.lineItem: [{ position: 30, label: 'Total Status Count' , qualifier: 'Q2', type: #AS_DATAPOINT}]
       case Status
      when 'Error' then 15
      when 'Success' then 30
      else 45

      end as TotalCount
    
}
group by
  aenam,
  ersda,
  Matnr,
  Status
