@EndUserText.label: 'Materials by MRP Area'
@ObjectModel.query.implementedBy:'ABAP:ZCL_CE_MRPA'
@UI.headerInfo: {
    typeName: 'Materials by MRP Area',
    typeNamePlural: 'Materials by MRP Area'
}

define custom entity ZCE_MRPA_BY_MRP
{
      @UI.lineItem  : [ { position: 10, label: 'Material', importance: #HIGH } ]
  key material      : abap.char(10);
      @UI.lineItem  : [ { position: 20, label: 'MRP Area', importance: #HIGH } ]
  key mrp           : abap.char(10);
      @UI.lineItem  : [ { position: 30, label: 'Open Delivery', importance: #HIGH } ]
      dlv           : abap.int4;
      @UI.lineItem  : [ { position: 40, label: 'Back Order', importance: #HIGH } ]
      bo            : abap.int4;
      @UI.lineItem  : [ { position: 50, label: 'On-Hand (Curr UNR)', importance: #HIGH } ]
      unr           : abap.int4;
      @UI.lineItem  : [ { position: 60, label: 'On-Hand (New UNR)', importance: #HIGH } ]
      new_unr           : abap.int4;
      @UI.lineItem  : [ { position: 70, label: 'On-Hand (Curr QA)', importance: #HIGH } ]
      qa            : abap.int4;
      @UI.lineItem  : [ { position: 80, label: 'On-Hand (New QA)', importance: #HIGH } ]
      new_qa           : abap.int4;
      @UI.lineItem  : [ { position: 90, label: 'On-Hand (Curr Block)', importance: #HIGH } ]
      block        : abap.int4;
      @UI.lineItem  : [ { position: 100, label: 'On-Hand (New Block)', importance: #HIGH } ]
      new_block           : abap.int4;
      @UI.lineItem  : [ { position: 110, label: 'Available (Previous Month)', importance: #HIGH } ]
      previousmonth : abap.int4;
      @UI.lineItem  : [ { position: 120, label: 'Available (Current Month)', importance: #HIGH } ]
      currentmonth  : abap.int4;
   
      _MRPA         : association to parent ZCE_MRPA on $projection.material = _MRPA.material;
}
