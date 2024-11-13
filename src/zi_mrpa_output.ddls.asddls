@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MRPA - Main output'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_MRPA_OUTPUT
  as select from zmrpa_output
  association to parent ZI_MRPAPP        as _App on $projection.Uname = _App.Uname
  composition [0..*] of ZI_MRPA_OUTPUTL2 as _OutputL2
{
  key uname              as Uname,
      @EndUserText.label: 'Material'
  key material           as Material,
      @EndUserText.label: 'Open Delivery'
      dlv                as Dlv,
      @EndUserText.label: 'Back Order'
      bo                 as Bo,
      @EndUserText.label: 'On Hand (Unrestricted)'
      unr                as Unr,
      @EndUserText.label: 'On Hand (QA)'
      qa                 as Qa,
      @EndUserText.label: 'On Hand (Block)'
      block              as Block,
      @EndUserText.label: 'Available (Previous Month)'
      previousmonth      as Previousmonth,
      @EndUserText.label: 'Available (Current Month)'
      currentmonth       as Currentmonth,
      createdby          as CreatedBy,
      createdat          as CreatedAt,
      locallastchangedby as LocalLastChangedBy,
      locallastchangedat as LocalLastChangedAt,
      lastchangedat      as LastChangedAt,
      _App,
      _OutputL2
}
