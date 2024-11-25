@EndUserText.label: 'Purchase Order'
@ObjectModel.query.implementedBy:'ABAP:ZCL_CE_MRPA2'
//@UI.headerInfo: {
//    typeName: '',
//    typeNamePlural: 'Delivery'
//}

define custom entity ZCE_POQUANTITY
{

      @EndUserText.label: 'Material'
      @UI.lineItem  : [ { position: 10, importance: #HIGH } ]
  key material      : abap.char(10);
      @EndUserText.label: 'MRP Area'
      @UI.lineItem  : [ { position: 11, importance: #HIGH } ]
  key mrp           : abap.char(10);
  key sequence      : abap.numc( 3 );
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
}
