@AbapCatalog.sqlViewName: 'ZCMONITOR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Demo view'
@VDM.viewType: #CONSUMPTION
@UI.headerInfo: {

typeName: 'Billing Document: Item Data',

typeNamePlural: 'Billing Documents: Item Data',

//imageUrl: 'mytestImg',

 title: {

    label: 'Sales Order',

    value: 'vbeln'

  },

  description: {

    label: 'Status',

    value: 'Status'

  }}
define view ZC_Monitor

  as select from ZC_ResponseMonitorStatsV2
{


      @UI.lineItem: [{ position: 10, label: 'Billing Document', qualifier: 'Q1'}]
  key vbeln,
      @UI.lineItem: [{ position: 20, label: 'Billing Item', qualifier: 'Q1'}]
  key posnr,

      @UI.dataPoint:
             {
             targetValueElement: 'Status',
             criticality: 'Criticality' }

      @UI.lineItem: [{ position: 30, label: 'Status' , qualifier: 'Q1' ,type: #AS_DATAPOINT}]
      Status,
      
      case Status
      when 'Error' then 1
      when 'Success' then 3
      else 2
      end as Criticality
}
