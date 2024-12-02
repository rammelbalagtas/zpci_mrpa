CLASS zcl_i_mrp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_I_MRP IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA lt_mrp TYPE TABLE OF z_c_mrp.
    DATA(lo_paging) = io_request->get_paging( ).
    TRY.
        "Filter not needed, because we all calculate fields in Backend
        DATA(lo_filter) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range.
    ENDTRY.

    IF lo_filter IS INITIAL.
      SELECT * FROM zmrpmat WHERE plant = 'YYZA' INTO CORRESPONDING FIELDS OF TABLE @lt_mrp.

      io_response->set_total_number_of_records( 15 ).
      io_response->set_data( lt_mrp ).
    ELSE.
      SELECT * FROM zmrpmat  INTO CORRESPONDING FIELDS OF TABLE @lt_mrp UP TO 1 ROWS.
      io_response->set_total_number_of_records( 1 ).
      io_response->set_data( lt_mrp ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
