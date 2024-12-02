@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Output'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
//@ObjectModel.query.implementedBy:'ABAP:ZCL_CE_MRPA_OUTPUT'
define view entity ZC_MRPA_OUTPUT
  as projection on ZI_MRPA_OUTPUT
{
  key     Uname,
  key     Material,
          Dlv,
          Bo,
          Unr,
          Qa,
          Block,
          Available,
          Incoming,
          Previousmonth,
          Currentmonth,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual CustomField1     : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual CustomField2     : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual virtualDlv       : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual virtualBo        : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual virtualUnr       : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual virtualQa        : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual virtualBlock     : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual virtualAvailable : abap.int4,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_VIRTUAL'
  virtual virtualIncoming  : abap.int4,
          CreatedBy,
          CreatedAt,
          LocalLastChangedBy,
          LocalLastChangedAt,
          LastChangedAt,
          /* Associations */
          _App      : redirected to parent ZC_MRPAPP,
          _Messages : redirected to composition child ZC_MRPA_MESSAGES,
          _OutputL2 : redirected to composition child ZC_MRPA_OUTPUTL2,
          _Delivery,
          _BackOrder
}
