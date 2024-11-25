@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMRPA Application'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_MRPAPP
  provider contract transactional_query
  as projection on ZI_MRPAPP
{
  key Uname,
      AppName,
      Plant,
      Region,
      Updatedata,
      @Semantics.largeObject: {
        acceptableMimeTypes: [ 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
        cacheControl.maxAge: #MEDIUM,
        contentDispositionPreference: #INLINE , // #ATTACHMENT - download as file
                                                // #INLINE - open in new window
        fileName: 'Filename',
        mimeType: 'Mimetype'
      }
      Attachment,
      @Semantics.mimeType: true
      Mimetype,
      Filename,

      Localcreatedby,
      Localcreatedat,
      Locallastchangedby,
      Locallastchangedat,
      Lastchangedat,
      /* Associations */
      _Materials : redirected to composition child ZC_MRPA_MATRANGE,
      _MRP       : redirected to composition child ZC_MRPA_MRPRANGE,
      _Output    : redirected to composition child ZC_MRPA_OUTPUT,
      _Results
}
