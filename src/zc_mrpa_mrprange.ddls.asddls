@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MRP Area'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_MRPA_MRPRANGE
  as projection on ZI_MRPA_MRPRANGE
{
  key Uname,
  key Paramid,
      MrpFrom,
      MrpTo,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _App: redirected to parent ZC_MRPAPP
}
