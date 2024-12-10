@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMRPA Application'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@ObjectModel: {
  semanticKey: [ 'Uname' ]
}
define root view entity ZI_MRPAPP
  as select from    zmrpa_user  as _User
    left outer join zmrpa_input as _Parameters on _User.bname = _Parameters.uname
  composition [0..*] of ZI_MRPA_MATRANGE as _Materials
  composition [0..*] of ZI_MRPA_MRPRANGE as _MRP
  composition [0..*] of ZI_MRPA_OUTPUT   as _Output
  association [0..*] to ZCE_MRPA2        as _Results on $projection.Plant = _Results.plant
{
  key _User.bname                    as Uname,
      @EndUserText.label: 'Application'
      'ZMRPA'                        as AppName,
      @EndUserText.label: 'Plant'
      _Parameters.plant              as Plant,
      @EndUserText.label: 'Perform Update?'
      _Parameters.updatedata         as Updatedata,
      _Parameters.hideresult         as HideResult,
      @EndUserText.label: 'Region'
      _Parameters.region             as Region,
      _Parameters.attachment         as Attachment,
      _Parameters.filename           as Filename,
      _Parameters.mimetype           as Mimetype,
      @Semantics.user.createdBy: true
      _Parameters.localcreatedby     as Localcreatedby,
      @Semantics.systemDateTime.createdAt: true
      _Parameters.localcreatedat     as Localcreatedat,
      @Semantics.user.localInstanceLastChangedBy: true
      _Parameters.locallastchangedby as Locallastchangedby,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      _Parameters.locallastchangedat as Locallastchangedat,
      @Semantics.systemDateTime.lastChangedAt: true
      _Parameters.lastchangedat      as Lastchangedat,
      _Materials,
      _MRP,
      _Output,
      _Results
}

where
  _User.bname = $session.user
