@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MRP Range'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_MRPA_MRPRANGE
  as select from zmrpa_mrprange
  association to parent ZI_MRPAPP as _App on $projection.Uname = _App.Uname
{
  key uname              as Uname,
  key paramid            as Paramid,
      @EndUserText.label: 'MRP (From)'
      mrpfrom            as MrpFrom,
      @EndUserText.label: 'MRP (To)'
      mrpto              as MrpTo,
      createdby          as CreatedBy,
      createdat          as CreatedAt,
      locallastchangedby as LocalLastChangedBy,
      locallastchangedat as LocalLastChangedAt,
      lastchangedat      as LastChangedAt,
      _App
}
