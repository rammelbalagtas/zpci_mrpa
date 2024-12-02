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



CLASS ZCL_CALCULATE_VIRTUAL IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    CHECK NOT it_original_data IS INITIAL.

    DATA : lt_calculated_data TYPE STANDARD TABLE OF ZC_MRPA_OUTPUT WITH DEFAULT KEY.

    MOVE-CORRESPONDING it_original_data TO lt_calculated_data.

    LOOP AT lt_calculated_data ASSIGNING FIELD-SYMBOL(<output>).
      <output>-virtualDlv =  100.
      <output>-virtualBo = 100.
      <output>-Dlv = 111.
    ENDLOOP.

    MOVE-CORRESPONDING lt_calculated_data TO ct_calculated_data.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    et_requested_orig_elements = VALUE #( BASE et_requested_orig_elements
                                              ( CONV #( 'DLV' ) )
                                              ( CONV #( 'BO' )  )
                                              ( CONV #( 'UNR'   ) ) ).
    IF 1 = 1.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
