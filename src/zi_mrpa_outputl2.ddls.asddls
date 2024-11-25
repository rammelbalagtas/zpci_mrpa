@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Output L2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_MRPA_OUTPUTL2
  as select from zmrpa_outputl2
  association        to parent ZI_MRPA_OUTPUT as _OutputL1    on  $projection.Uname    = _OutputL1.Uname
                                                              and $projection.Material = _OutputL1.Material
  association [0..1] to ZI_MRPAPP             as _App         on  $projection.Uname = _App.Uname
  composition [0..*] of ZI_MRPA_OUTPUTL3      as _OutputL3
  association [0..*] to ZCE_POQUANTITY        as _POQuantity1 on  $projection.Material = _POQuantity1.material
                                                              and $projection.Mrp      = _POQuantity1.mrp
  association [0..*] to ZCE_POQUANTITY2       as _POQuantity2 on  $projection.Material = _POQuantity2.material
                                                              and $projection.Mrp      = _POQuantity2.mrp
{
  key uname              as Uname,
      @EndUserText.label: 'Material'
  key material           as Material,
      @EndUserText.label: 'MRP Area'
  key mrp                as Mrp,
      @EndUserText.label: 'Open Delivery'
      dlv                as Dlv,
      @EndUserText.label: 'Back Order'
      bo                 as Bo,
      @EndUserText.label: 'On Hand (Unrestricted)'
      unr                as Unr,
      @EndUserText.label: 'On Hand (New Unrestricted)'
      newunr             as NewUnr,
      @EndUserText.label: 'On Hand (QA)'
      qa                 as Qa,
      @EndUserText.label: 'On Hand (New QA)'
      newqa              as NewQa,
      @EndUserText.label: 'On Hand (Block)'
      block              as Block,
      @EndUserText.label: 'On Hand (New Block)'
      newblock           as NewBlock,
      available          as Available,
      incoming           as Incoming,
      @EndUserText.label: 'Available (Previous Month)'
      previousmonth      as Previousmonth,
      @EndUserText.label: 'Available (Current Month)'
      currentmonth       as Currentmonth,
      createdby          as CreatedBy,
      createdat          as CreatedAt,
      locallastchangedby as LocalLastChangedBy,
      locallastchangedat as LocalLastChangedAt,
      lastchangedat      as LastChangedAt,
      _OutputL1,
      _OutputL3,
      _App,
      _POQuantity1,
      _POQuantity2
}
