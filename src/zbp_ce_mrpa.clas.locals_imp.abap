CLASS lhc_ZCE_MRPA DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zce_mrpa RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zce_mrpa.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zce_mrpa.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zce_mrpa.

    METHODS read FOR READ
      IMPORTING keys FOR READ zce_mrpa RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zce_mrpa.

    METHODS rba_Mrpa_by_mrp FOR READ
      IMPORTING keys_rba FOR READ zce_mrpa\_Mrpa_by_mrp FULL result_requested RESULT result LINK association_links.

    METHODS cba_Mrpa_by_mrp FOR MODIFY
      IMPORTING entities_cba FOR CREATE zce_mrpa\_Mrpa_by_mrp.

ENDCLASS.

CLASS lhc_ZCE_MRPA IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Mrpa_by_mrp.
  ENDMETHOD.

  METHOD cba_Mrpa_by_mrp.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZCE_MRPA_BY_MRP DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zce_mrpa_by_mrp.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zce_mrpa_by_mrp.

    METHODS read FOR READ
      IMPORTING keys FOR READ zce_mrpa_by_mrp RESULT result.

    METHODS rba_Mrpa FOR READ
      IMPORTING keys_rba FOR READ zce_mrpa_by_mrp\_Mrpa FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZCE_MRPA_BY_MRP IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Mrpa.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZCE_MRPA DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCE_MRPA IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
