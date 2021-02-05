@AbapCatalog.sqlViewName: 'ZCFKINTERCOMPANY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Inteconmapy view for demo purposes'
@VDM.viewType: #CONSUMPTION

@UI.headerInfo: {
  typeNamePlural: 'InterCompany',
  typeName: 'InterCompanies',
  title: {
    label: 'Airline Code',
    value: 'Carrid',
    criticality: 'Criticality'
  },
  description: {
    label: 'Status',
    value: 'Status',
    criticality: 'Criticality'
  }
}
define view ZC_FKINTERCOMPANY
  as select from ZC_FKIntercompanyStatV2
{




      @UI.lineItem: [{ position: 10, label: 'Airline Code', qualifier: 'Q1'}]
  key Carrid,
      @UI.lineItem: [{ position: 20, label: 'Flight Connection Number', qualifier: 'Q1'}]
  key Connid,
      @UI.lineItem: [{ position: 30, label: 'Flight date', qualifier: 'Q1'}]
  key Fldate,



      @UI.lineItem: [{ position: 40, label: 'Status', qualifier: 'Q1' }]
      Status,

      case Status
      when 'Error' then 1
      when 'Success' then 3
      else 2
      end as Criticality
}
