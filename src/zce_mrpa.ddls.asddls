@EndUserText.label: 'Custom entity of ZMRPA'
@ObjectModel.query.implementedBy:'ABAP:ZCL_CE_MRPA'
@UI.headerInfo: {
    typeName: 'Materials',
    typeNamePlural: 'Materials'
}

define root custom entity ZCE_MRPA
{

      @UI.facet     : [
      {
          id        : 'RESULTBYMRP',
          purpose   : #STANDARD,
          position  : 20,
          label     : 'Materials by MRP Area',
          type      :  #LINEITEM_REFERENCE,
          targetElement: '_MRPA_BY_MRP'
      }]

      @EndUserText.label: 'Material'
      @UI.lineItem  : [ { position: 10, importance: #HIGH } ]
      @UI.selectionField: [ { position: 10 } ]
  key material      : abap.char(10);
      @EndUserText.label: 'Region'
      @UI.selectionField: [ { position: 40 } ]
      region        : abap.char(10);
      @EndUserText.label: 'Plant'
      @UI.selectionField: [ { position: 10} ]
      plant         : abap.char(10);
      @EndUserText.label: 'MRP Area'
      @UI.selectionField: [ { position: 30} ]
      mrp           : abap.char(10);
      @UI.lineItem  : [ { position: 20, label: 'Open Delivery', importance: #HIGH } ]
      dlv           : abap.int4;
      @UI.lineItem  : [ { position: 30, label: 'Back Order', importance: #HIGH } ]
      bo            : abap.int4;
      @UI.lineItem  : [ { position: 40, label: 'On-Hand (UNR)', importance: #HIGH } ]
      unr           : abap.int4;
      @UI.lineItem  : [ { position: 50, label: 'On-Hand (QA)', importance: #HIGH } ]
      qa            : abap.int4;
      @UI.lineItem  : [ { position: 60, label: 'On-Hand (Block)', importance: #HIGH } ]
      block         : abap.int4;
      @UI.lineItem  : [ { position: 70, label: 'Available (Previous Month)', importance: #HIGH } ]
      previousmonth : abap.int4;
      @UI.lineItem  : [ { position: 80, label: 'Available (Current Month)', importance: #HIGH } ]
      currentmonth  : abap.int4;
//       @UI.selectionField: [{ element: '_MRPA_BY_MRP.MRP', position : 50 }]
      _MRPA_BY_MRP  : composition [0..*] of ZCE_MRPA_BY_MRP;
}
