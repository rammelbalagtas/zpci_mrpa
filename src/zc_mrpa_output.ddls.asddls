@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Output'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_MRPA_OUTPUT
  as projection on ZI_MRPA_OUTPUT
{
  key Uname,
  key Material,
      Dlv,
      Bo,
      Unr,
      Qa,
      Block,
      Previousmonth,
      Currentmonth,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _App: redirected to parent ZC_MRPAPP,
      _OutputL2: redirected to composition child ZC_MRPA_OUTPUTL2
}
