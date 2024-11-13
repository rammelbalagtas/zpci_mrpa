@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMRPA Application'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_MRPAPP
  as select from    zmrpa_user  as _User
    left outer join zmrpa_input as _Parameters on _User.bname = _Parameters.uname
  composition [0..*] of ZI_MRPA_MATRANGE as _Materials
  composition [0..*] of ZI_MRPA_MRPRANGE as _MRP
  composition [0..*] of ZI_MRPA_OUTPUT   as _Output
{
  key _User.bname                    as Uname,
      @EndUserText.label: 'Application'
      'ZMRPA'                        as AppName,
      @EndUserText.label: 'Plant'
      _Parameters.plant              as Plant,
      @EndUserText.label: 'Perform Update?'
      _Parameters.updatedata         as Updatedata,
      @EndUserText.label: 'Region'
      _Parameters.region              as Region,
      _Parameters.localcreatedby     as Localcreatedby,
      _Parameters.localcreatedat     as Localcreatedat,
      _Parameters.locallastchangedby as Locallastchangedby,
      _Parameters.locallastchangedat as Locallastchangedat,
      _Parameters.lastchangedat      as Lastchangedat,
      _Materials,
      _MRP,
      _Output
}
