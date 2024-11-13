@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Materials'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_MRPA_MATRANGE
  as projection on ZI_MRPA_MATRANGE
{
  key Uname,
  key Paramid,
      MatnrFrom,
      MatnrTo,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _App: redirected to parent ZC_MRPAPP
}
