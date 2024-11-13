@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material range'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_MRPA_MATRANGE
  as select from zmrpa_matrange
  association to parent ZI_MRPAPP as _App on $projection.Uname = _App.Uname
{
  key uname              as Uname,
  key paramid            as Paramid,
      @EndUserText.label: 'Material (From)'
      matnrfrom          as MatnrFrom,
      @EndUserText.label: 'Material (To)'
      matnrto            as MatnrTo,
      createdby          as CreatedBy,
      createdat          as CreatedAt,
      locallastchangedby as LocalLastChangedBy,
      locallastchangedat as LocalLastChangedAt,
      lastchangedat      as LastChangedAt,
      _App
}
