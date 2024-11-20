@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Output L3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_MRPA_OUTPUTL3
  as select from zmrpa_outputl3
  association        to parent ZI_MRPA_OUTPUTL2 as _OutputL2 on  $projection.Uname    = _OutputL2.Uname
                                                             and $projection.Material = _OutputL2.Material
                                                             and $projection.Mrp      = _OutputL2.Mrp
  association [0..1] to ZI_MRPAPP               as _App      on  $projection.Uname = _App.Uname
{
  key uname              as Uname,
      @EndUserText.label: 'Material'
  key material           as Material,
      @EndUserText.label: 'MRP Area'
  key mrp                as Mrp,
      @EndUserText.label: 'Customer'
  key customer           as Customer,
      available          as Available,
      newavailable       as NewAvailable,
      incoming           as Incoming,
      newincoming        as newIncoming,
      @EndUserText.label: 'Available (Previous Month)'
      previousmonth      as Previousmonth,
      @EndUserText.label: 'Available (New Previous Month)'
      newpreviousmonth   as NewPreviousmonth,
      @EndUserText.label: 'Available (Current Month)'
      currentmonth       as Currentmonth,
      @EndUserText.label: 'Available (New Current Month)'
      newcurrentmonth    as NewCurrentmonth,
      createdby          as CreatedBy,
      createdat          as CreatedAt,
      locallastchangedby as LocalLastChangedBy,
      locallastchangedat as LocalLastChangedAt,
      lastchangedat      as LastChangedAt,
      _OutputL2,
      _App
}
