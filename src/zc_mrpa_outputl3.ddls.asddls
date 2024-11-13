@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material by Customer'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_MRPA_OUTPUTL3
  as projection on ZI_MRPA_OUTPUTL3
{
  key Uname,
  key Material,
  key Mrp,
  key Customer,
      Previousmonth,
      NewPreviousmonth,
      Currentmonth,
      NewCurrentmonth,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _App: redirected to ZC_MRPAPP,
      _OutputL2: redirected to parent ZC_MRPA_OUTPUTL2
}
