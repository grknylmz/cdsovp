@AbapCatalog.sqlViewName: 'ZCNACHRITENSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Demo view'
@VDM.viewType: #CONSUMPTION
@UI.chart: [{
      qualifier: 'Q3',
      title: 'Buchalstatungs status bubbleTry',
      chartType: #BUBBLE,
      dimensions: ['Status'],
      measures: ['Measeure1','Measeure2','Measeure3'],
      dimensionAttributes: [{ dimension: 'Status', role: #SERIES }],
      measureAttributes: [
      { measure: 'Measeure1', role: #AXIS_1, asDataPoint: true },
      { measure: 'Measeure2', role: #AXIS_2, asDataPoint: true },
      { measure: 'Measeure3', role: #AXIS_3, asDataPoint: true }]
      }]
define view ZC_NACHRITENSTAT
  as select from ZC_CheckNacrichtenStatsV2
{

      //ZC_CheckNacrichtenStatsV2
      @UI.lineItem: [{ position: 10, label: 'Company Code', qualifier: 'Q1'}]
  key Bukrs,
      @UI.dataPoint:
                 {
                 targetValueElement: 'Status',
                 criticality: 'Criticality' }

      @UI.lineItem: [{ position: 20, label: 'Status', qualifier: 'Q1', type: #AS_DATAPOINT}]
      Status,
      
      case Status
      when 'Error' then 1
      when 'Success' then 3
      else 2
      end         as Criticality,


      @UI.dataPoint:{title: 'Measure1'}
      @UI.lineItem: [{ position: 30, label: 'Measure1', qualifier: 'Q3', type: #AS_DATAPOINT}]
      case Bukrs when 'RU01' then 10
      when 'QA01' then 20
      when  'TW01' then 30
      else 40 end as Measeure1,

      @UI.dataPoint:{title: 'Measure2'}
      @UI.lineItem: [{ position: 40, label: 'Measure2', qualifier: 'Q3', type: #AS_DATAPOINT}]
      case Bukrs when 'RU01' then 15
      when 'QA01' then 25
      when  'TW01' then 35
      else 45 end as Measeure2,

      @UI.dataPoint:{title: 'Measure3'}
      @UI.lineItem: [{ position: 50, label: 'Measure3', qualifier: 'Q3', type: #AS_DATAPOINT}]

      case Bukrs when 'RU01' then 13
      when 'QA01' then 23
      when  'TW01' then 33
      else 44 end as Measeure3




}
