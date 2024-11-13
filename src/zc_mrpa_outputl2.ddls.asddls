@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material by MRP'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_MRPA_OUTPUTL2
  as projection on ZI_MRPA_OUTPUTL2
{
  key Uname,
  key Material,
  key Mrp,
      Dlv,
      Bo,
      Unr,
      NewUnr,
      Qa,
      NewQa,
      Block,
      NewBlock,
      Previousmonth,
      Currentmonth,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _App: redirected to ZC_MRPAPP,
      _OutputL1: redirected to parent ZC_MRPA_OUTPUT,
      _OutputL3: redirected to composition child ZC_MRPA_OUTPUTL3
}
