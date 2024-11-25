@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Messages'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_mrpa_messages
  as select from zmrpa_messages
  association        to parent ZI_MRPA_OUTPUT as _OutputL1 on  $projection.Uname    = _OutputL1.Uname
                                                           and $projection.Material = _OutputL1.Material
  association [0..1] to ZI_MRPAPP             as _App      on  $projection.Uname = _App.Uname
{
  key uname              as Uname,
  key material           as Material,
  key sequence           as Sequence,
      message            as Message,
      createdby          as Createdby,
      createdat          as Createdat,
      locallastchangedby as Locallastchangedby,
      locallastchangedat as Locallastchangedat,
      lastchangedat      as Lastchangedat,
      _OutputL1,
      _App
}
