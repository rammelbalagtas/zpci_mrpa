CLASS lhc_app DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS extractData2 FOR MODIFY
      IMPORTING keys FOR ACTION App~extractData2 RESULT result.
    METHODS augment_update FOR MODIFY
      IMPORTING entities FOR UPDATE App.

ENDCLASS.

CLASS lhc_app IMPLEMENTATION.

  METHOD extractData2.
    DATA(lv_test) = abap_true.
    IF 1 = 1. ENDIF.
  ENDMETHOD.

  METHOD augment_update.
    DATA(lv_test) = abap_true.
    IF 1 = 1. ENDIF.
  ENDMETHOD.

ENDCLASS.
