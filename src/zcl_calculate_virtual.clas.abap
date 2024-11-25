CLASS zcl_calculate_virtual DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_calculate_virtual IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    FIELD-SYMBOLS: <fs_data> TYPE any.
    DATA(lv_test) = abap_true.
    LOOP AT ct_calculated_data ASSIGNING FIELD-SYMBOL(<fs_calculated_data>).
      ASSIGN COMPONENT 'CUSTOMFIELD1' OF STRUCTURE <fs_calculated_data> TO <fs_Data>.
      IF sy-subrc EQ 0.
        <fs_Data> = 1234.
      ENDIF.
      ASSIGN COMPONENT 'CUSTOMFIELD2' OF STRUCTURE <fs_calculated_data> TO <fs_Data>.
      IF sy-subrc EQ 0.
        <fs_Data> = 1234.
      ENDIF.
    ENDLOOP.
    DATA(lo_singleton) = zcl_mrpa_singleton=>get_instance( ).
    lo_singleton->set_data( 'Test' ).

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    DATA(lv_test) = abap_true.
    IF 1 = 1.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
