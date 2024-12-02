CLASS zcl_ce_mrpa2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CE_MRPA2 IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    CASE io_request->get_entity_id( ).
      WHEN 'ZCE_MRPA2' OR 'ZCE_DELIVERY' OR 'ZCE_BACKORDER' OR 'ZCE_POQUANTITY' OR 'ZCE_POQUANTITY2'.

        "filter
        DATA(lv_sql_filter) = io_request->get_filter( )->get_as_sql_string( ).
        TRY.
            DATA(lt_filter) = io_request->get_filter( )->get_as_ranges( ).
          CATCH cx_rap_query_filter_no_range.
            "handle exception
        ENDTRY.

        IF io_request->is_data_requested( ).
          "paging
          DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
          DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
          DATA(lv_max_rows) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited
                                      THEN 0 ELSE lv_page_size ).
          "sorting
          DATA(sort_elements) = io_request->get_sort_elements( ).
          DATA(lt_sort_criteria) = VALUE string_table( FOR sort_element IN sort_elements
                                                     ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true THEN ` descending`
                                                                                                                                     ELSE ` ascending` ) ) ).
          DATA(lv_sort_string)  = COND #( WHEN lt_sort_criteria IS INITIAL THEN `primary key`
                                                                           ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
          "requested elements
          DATA(lt_req_elements) = io_request->get_requested_elements( ).
          DATA(lv_req_elements)  = concat_lines_of( table = lt_req_elements sep = `, ` ).

          DATA lt_data TYPE STANDARD TABLE OF zce_mrpa.
          DATA ls_data LIKE LINE OF lt_data.
          DATA lv_tabix TYPE i.

          SELECT * FROM zmrpmat WHERE (lv_sql_filter)
                                ORDER BY (lv_sort_string)
                                INTO TABLE @DATA(lt_mrp).

          SORT lt_mrp BY material.

          LOOP AT lt_mrp INTO DATA(ls_mrp)
                         GROUP BY ( material = ls_mrp-material )
                         ASCENDING
                         ASSIGNING FIELD-SYMBOL(<lt_group>).

            CLEAR: ls_data, lv_tabix.
            LOOP AT GROUP <lt_group> ASSIGNING FIELD-SYMBOL(<data>).
              IF lv_tabix IS INITIAL.
                ls_data-material = <data>-material.
              ENDIF.
              lv_tabix = 1.
              ls_data-dlv = ls_data-dlv + <data>-dlv.
              ls_data-bo = ls_data-bo + <data>-bo.
              ls_data-unr = ls_data-unr + <data>-unr.
              ls_data-qa = ls_data-qa + <data>-qa.
              ls_data-block = ls_data-block + <data>-block.
              ls_data-previousmonth = ls_data-previousmonth + <data>-previousmonth.
              ls_data-currentmonth = ls_data-currentmonth + <data>-currentmonth.
            ENDLOOP.
            APPEND ls_data TO lt_data.

          ENDLOOP.

          io_response->set_data( lt_data ).

          IF io_request->is_total_numb_of_rec_requested( ).
            DATA lv_total_rows TYPE int8.
            lv_total_rows = lines( lt_data ).
            io_response->set_total_number_of_records( lv_total_rows ).
          ENDIF.

        ENDIF.

      WHEN 'ZCE_MRPA_BY_MRP'.

        "filter
        lv_sql_filter = io_request->get_filter( )->get_as_sql_string( ).
        TRY.
            lt_filter = io_request->get_filter( )->get_as_ranges( ).
          CATCH cx_rap_query_filter_no_range.
            "handle exception
        ENDTRY.

        IF io_request->is_data_requested( ).
          "paging
          lv_offset = io_request->get_paging( )->get_offset( ).
          lv_page_size = io_request->get_paging( )->get_page_size( ).
          lv_max_rows = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited
                                      THEN 0 ELSE lv_page_size ).
          "sorting
          sort_elements = io_request->get_sort_elements( ).
          lt_sort_criteria = VALUE string_table( FOR sort_element IN sort_elements
                                                     ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true THEN ` descending`
                                                                                                                                     ELSE ` ascending` ) ) ).
          lv_sort_string  = COND #( WHEN lt_sort_criteria IS INITIAL THEN `primary key`
                                                                           ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
          "requested elements
          lt_req_elements = io_request->get_requested_elements( ).
          lv_req_elements  = concat_lines_of( table = lt_req_elements sep = `, ` ).

          DATA lt_data_by_mrp TYPE STANDARD TABLE OF zce_mrpa_by_mrp.
          DATA ls_data_by_mrp LIKE LINE OF lt_data_by_mrp.

          SELECT * FROM zmrpmat WHERE (lv_sql_filter)
                                ORDER BY (lv_sort_string)
                                INTO TABLE @lt_mrp.

          SORT lt_mrp BY mrp material.

          LOOP AT lt_mrp INTO ls_mrp
                         GROUP BY ( mrp = ls_mrp-mrp material = ls_mrp-material )
                         ASCENDING
                         ASSIGNING FIELD-SYMBOL(<lt_group_by_mrp>).

            CLEAR: ls_data_by_mrp, lv_tabix.
            LOOP AT GROUP <lt_group_by_mrp> ASSIGNING FIELD-SYMBOL(<data_by_mrp>).
              IF lv_tabix IS INITIAL.
                ls_data_by_mrp-material = <data_by_mrp>-material.
                ls_data_by_mrp-mrp = <data_by_mrp>-mrp.
              ENDIF.
              lv_tabix = 1.
              ls_data_by_mrp-dlv = ls_data_by_mrp-dlv + <data_by_mrp>-dlv.
              ls_data_by_mrp-bo = ls_data_by_mrp-bo + <data_by_mrp>-bo.
              ls_data_by_mrp-unr = ls_data_by_mrp-unr + <data_by_mrp>-unr.
              ls_data_by_mrp-qa = ls_data_by_mrp-qa + <data_by_mrp>-qa.
              ls_data_by_mrp-block = ls_data_by_mrp-block + <data_by_mrp>-block.
              ls_data_by_mrp-previousmonth = ls_data_by_mrp-previousmonth + <data_by_mrp>-previousmonth.
              ls_data_by_mrp-currentmonth = ls_data_by_mrp-currentmonth + <data_by_mrp>-currentmonth.
            ENDLOOP.
            APPEND ls_data_by_mrp TO lt_data_by_mrp.

          ENDLOOP.

          io_response->set_data( lt_data_by_mrp ).

          IF io_request->is_total_numb_of_rec_requested( ).
            lv_total_rows = lines( lt_data_by_mrp ).
            io_response->set_total_number_of_records( lv_total_rows ).
          ENDIF.

        ENDIF.

    ENDCASE.
  ENDMETHOD.
ENDCLASS.
