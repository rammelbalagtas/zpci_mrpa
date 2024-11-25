@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Messages'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_MRPA_MESSAGES
  as projection on zi_mrpa_messages
{
  key Uname,
  key Material,
  key Sequence,
      Message,
      Createdby,
      Createdat,
      Locallastchangedby,
      Locallastchangedat,
      Lastchangedat,
      /* Associations */
      _App      : redirected to ZC_MRPAPP,
      _OutputL1 : redirected to parent ZC_MRPA_OUTPUT
}
