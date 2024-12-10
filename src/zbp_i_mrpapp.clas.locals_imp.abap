CLASS lhc_outputl1 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR OutputL1 RESULT result.

    METHODS validateInput FOR MODIFY
      IMPORTING keys FOR ACTION OutputL1~validateInput RESULT result.

ENDCLASS.

CLASS lhc_outputl1 IMPLEMENTATION.

  METHOD get_global_authorizations.
    IF 1 = 1.
    ENDIF.
  ENDMETHOD.

  METHOD validateInput.
    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
       ENTITY OutputL1
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT DATA(lt_outputl1).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_outputl2 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS onModifyOnHand FOR DETERMINE ON MODIFY
      IMPORTING keys FOR OutputL2~onModifyOnHand.

ENDCLASS.

CLASS lhc_outputl2 IMPLEMENTATION.

  METHOD onModifyOnHand.

    DATA lv_prorate TYPE int4.
    DATA lv_total TYPE int4.
    DATA lv_sum TYPE int4.

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
       ENTITY OutputL2
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT DATA(lt_outputl2).

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
     ENTITY OutputL2
     BY \_OutputL3
     ALL FIELDS WITH
     CORRESPONDING #( keys )
     RESULT DATA(lt_outputl3).

    LOOP AT lt_outputl2 INTO DATA(ls_outputl2).
      lv_total = ls_outputl2-newunr + ls_outputl2-newqa + ls_outputl2-newblock.
      DATA(lv_count) = lines( lt_outputl3 ).
      lv_prorate = lv_total / lv_count.
      LOOP AT lt_outputl3 ASSIGNING FIELD-SYMBOL(<fs_outputl3>).
        IF sy-tabix < lv_count.
          <fs_outputl3>-newavailable = lv_prorate.
          lv_sum = lv_sum + lv_prorate.
        ELSE.
          <fs_outputl3>-newavailable = lv_total - lv_sum.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
               ENTITY OutputL3
                 UPDATE
                   FIELDS ( NewAvailable )
                   WITH VALUE #( FOR outputl3 IN lt_outputl3
                                   ( %tky         = outputl3-%tky
                                     NewAvailable = outputl3-NewAvailable
                                     %control-NewAvailable = if_abap_behv=>mk-on ) )
               MAPPED DATA(upd_mapped)
               FAILED DATA(upd_failed)
               REPORTED DATA(upd_reported).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_App DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR App RESULT result.

    METHODS clearInput FOR MODIFY
      IMPORTING keys FOR ACTION App~clearInput RESULT result.

    METHODS extractData FOR MODIFY
      IMPORTING keys FOR ACTION App~extractData RESULT result.

    METHODS validateEntries FOR MODIFY
      IMPORTING keys FOR ACTION App~validateEntries RESULT result.
    METHODS exportToExcel FOR MODIFY
      IMPORTING keys FOR ACTION App~exportToExcel RESULT result.
    METHODS refreshScreen FOR MODIFY
      IMPORTING keys FOR ACTION App~refreshScreen RESULT result.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE App.
    METHODS Edit FOR MODIFY
      IMPORTING keys FOR ACTION App~Edit.

    METHODS Resume FOR MODIFY
      IMPORTING keys FOR ACTION App~Resume.
    METHODS refreshEntity FOR MODIFY
      IMPORTING keys FOR ACTION App~refreshEntity RESULT result.

ENDCLASS.

CLASS lhc_App IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD clearInput.
  ENDMETHOD.

  METHOD extractData.

*    DATA(new) = NEW zcl_bgpf(  ).
*    DATA background_process TYPE REF TO if_bgmc_process_single_op.
*    TRY.
*        background_process = cl_bgmc_process_factory=>get_default(  )->create(  ).
*        background_process->set_operation( new ).
*        background_process->save_for_execution(  ).
*      CATCH cx_bgmc INTO DATA(exception).
*        "handle exception
*    ENDTRY.

*    TRY.
*
*        DATA job_template_name TYPE cl_apj_rt_api=>ty_template_name VALUE 'ZAPP_DEMO_01_TEMPLATE'.
*
*        DATA job_start_info TYPE cl_apj_rt_api=>ty_start_info.
*        DATA job_parameters TYPE cl_apj_rt_api=>tt_job_parameter_value.
*        DATA job_parameter TYPE cl_apj_rt_api=>ty_job_parameter_value.
*        DATA range_value TYPE cl_apj_rt_api=>ty_value_range.
*        DATA job_name TYPE cl_apj_rt_api=>ty_jobname.
*        DATA job_count TYPE cl_apj_rt_api=>ty_jobcount.
*
*        " job_start_info-start_immediately MUST NOT BE USED in on premise systems
*        " since it performs a commit work which would cause a dump
*
*        GET TIME STAMP FIELD DATA(start_time_of_job).
**          job_start_info-timestamp = start_time_of_job.
*        job_start_info-start_immediately = abap_true.
*
*        job_parameter-name = 'INVENT'.
*        range_value-sign = 'I'.
*        range_value-option = 'EQ'.
*        range_value-low = '111'.
*        APPEND range_value TO job_parameter-t_value.
*        APPEND job_parameter TO job_parameters.
*
*
*        cl_apj_rt_api=>schedule_job(
*            EXPORTING
*            iv_job_template_name = job_template_name
*            iv_job_text = |Calculate inventory of|
*            is_start_info = job_start_info
*            it_job_parameter_value = job_parameters
*            IMPORTING
*            ev_jobname  = job_name
*            ev_jobcount = job_count
*            ).
*
**        UPDATE zapp_inven_01 SET job_count = @job_count , job_name = @job_name WHERE uuid = @update_inventory-uuid.
*
*      CATCH cx_apj_rt INTO DATA(job_scheduling_error).
*      CATCH cx_root INTO DATA(root_exception).
*    ENDTRY.

    DATA(lo_singleton) = zcl_mrpa_singleton=>get_instance( ).
    lo_singleton->set_data( 'Test' ).

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
           ENTITY App
              ALL FIELDS
             WITH CORRESPONDING #(  keys  )
           RESULT DATA(lt_app)
           ENTITY App BY \_Materials
             ALL FIELDS
             WITH CORRESPONDING #(  keys  )
           RESULT DATA(lt_materials)
           ENTITY App BY \_mrp
             ALL FIELDS
             WITH CORRESPONDING #(  keys  )
           RESULT DATA(lt_mrp).

    LOOP AT lt_app INTO DATA(ls_app_temp).
      IF ls_app_temp-Plant IS INITIAL.
        APPEND VALUE #(  %tky = ls_app_temp-%tky ) TO failed-app.
        APPEND VALUE #(  %tky = ls_app_temp-%tky
                         %state_area         = 'VALIDATE_PLANT'
                         %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                           text = 'Plant is mandatory' )
                         %element-Plant   = if_abap_behv=>mk-on
                       ) TO reported-app.
        RETURN.
      ENDIF.
      DATA(lv_plant) = ls_app_temp-Plant.
    ENDLOOP.

    DATA: lr_matnr   TYPE RANGE OF zzmrpa_matnr,
          ls_matnr_r LIKE LINE OF lr_matnr,
          lr_mrp     TYPE RANGE OF zzmrpa_mrp,
          ls_mrp_r   LIKE LINE OF lr_mrp.

    "Material filter

    DELETE lt_materials WHERE MatnrFrom IS INITIAL AND MatnrTo IS INITIAL.
    LOOP AT lt_materials INTO DATA(ls_material).
      IF ls_material-MatnrFrom IS INITIAL AND
        ls_material-Matnrto IS INITIAL.
        CONTINUE.
      ENDIF.
      ls_matnr_r-sign = 'I'.
      ls_matnr_r-low = ls_material-MatnrFrom.
      ls_matnr_r-high = ls_material-MatnrTo.
      IF ls_matnr_r-high IS NOT INITIAL.
        ls_matnr_r-option = 'BT'.
      ELSE.
        ls_matnr_r-option = 'EQ'.
      ENDIF.
      APPEND ls_matnr_r TO lr_matnr.
      CLEAR ls_matnr_r.
    ENDLOOP.

    "MRP filter
    LOOP AT lt_mrp INTO DATA(ls_mrp).
      IF ls_mrp-mrpfrom IS INITIAL AND
      ls_mrp-mrpto IS INITIAL.
        CONTINUE.
      ENDIF.
      ls_mrp_r-sign = 'I'.
      ls_mrp_r-low = ls_mrp-mrpfrom.
      ls_mrp_r-high = ls_mrp-mrpto.
      IF ls_mrp_r-high IS NOT INITIAL.
        ls_mrp_r-option = 'BT'.
      ELSE.
        ls_mrp_r-option = 'EQ'.
      ENDIF.
      APPEND ls_mrp_r TO lr_mrp.
      CLEAR ls_mrp_r.
    ENDLOOP.

    SELECT * FROM zmrpmat
            WHERE plant EQ @lv_plant
              AND mrp IN @lr_mrp
              AND material IN @lr_matnr
             ORDER BY material
             INTO TABLE @DATA(lt_data).

    DATA lt_output TYPE STANDARD TABLE OF zmrpa_output.
    DATA ls_output LIKE LINE OF lt_output.

*** Output L1
    LOOP AT lt_data INTO DATA(ls_data)
                   GROUP BY ( material = ls_data-material )
                   ASCENDING
                   ASSIGNING FIELD-SYMBOL(<lt_group>).

      DATA(lv_first) = abap_false.
      CLEAR: ls_output, lv_first.
      LOOP AT GROUP <lt_group> ASSIGNING FIELD-SYMBOL(<data>).
        IF lv_first IS INITIAL.
          ls_output-material = <data>-material.
        ENDIF.
        lv_first = abap_true.
        ls_output-dlv = ls_output-dlv + <data>-dlv.
        ls_output-bo = ls_output-bo + <data>-bo.
        ls_output-unr = ls_output-unr + <data>-unr.
        ls_output-qa = ls_output-qa + <data>-qa.
        ls_output-block = ls_output-block + <data>-block.
        ls_output-available = ls_output-available + <data>-available.
        ls_output-incoming = ls_output-incoming + <data>-incoming.
      ENDLOOP.
      APPEND ls_output TO lt_output.
    ENDLOOP.

*    DATA(lv_tabix) = 0.
*    DO 1000 TIMES.
*        lv_tabix = lv_tabix + 1.
*        ls_output-material = |Mat { lv_tabix }|.
*        APPEND ls_output TO lt_output.
*    ENDDO.

    DATA lt_mrp_output TYPE TABLE FOR CREATE zi_mrpapp\_Output.
    lt_mrp_output = VALUE #( (
                                %cid_ref  = keys[ 1 ]-%cid_ref
                                %is_draft = keys[ 1 ]-%is_draft
                                uname  = keys[ 1 ]-uname
                                %target   = VALUE #( FOR output IN lt_output ( %is_draft = keys[ 1 ]-%is_draft
                                                                               uname = keys[ 1 ]-uname
                                                                               material = output-material
                                                                               dlv = output-dlv
                                                                               bo = output-bo
                                                                               unr = output-unr
                                                                               qa = output-qa
                                                                               block = output-block
                                                                               available = output-available
                                                                               incoming = output-incoming
                                                                               %control = VALUE #( uname       = if_abap_behv=>mk-on
                                                                                                   material    = if_abap_behv=>mk-on
                                                                                                   dlv       = if_abap_behv=>mk-on
                                                                                                   bo    = if_abap_behv=>mk-on
                                                                                                   unr = if_abap_behv=>mk-on
                                                                                                   qa   = if_abap_behv=>mk-on
                                                                                                   block     = if_abap_behv=>mk-on
                                                                                                   available       = if_abap_behv=>mk-on
                                                                                                   incoming     = if_abap_behv=>mk-on ) ) ) ) ).


*** Output L2
    DATA lt_outputl2 TYPE STANDARD TABLE OF zmrpa_outputl2.
    DATA ls_outputl2 LIKE LINE OF lt_outputl2.
    SORT lt_data BY material mrp.
    LOOP AT lt_data INTO ls_data
                   GROUP BY ( material = ls_data-material mrp = ls_data-mrp )
                   ASCENDING
                   ASSIGNING FIELD-SYMBOL(<lt_groupl2>).

      CLEAR: ls_outputl2, lv_first.
      LOOP AT GROUP <lt_groupl2> ASSIGNING FIELD-SYMBOL(<data_l2>).
        IF lv_first IS INITIAL.
          ls_outputl2-material = <data_l2>-material.
          ls_outputl2-mrp = <data_l2>-mrp.
        ENDIF.
        lv_first = abap_true.
        ls_outputl2-dlv = ls_outputl2-dlv + <data_l2>-dlv.
        ls_outputl2-bo = ls_outputl2-bo + <data_l2>-bo.
        ls_outputl2-unr = ls_outputl2-unr + <data_l2>-unr.
        ls_outputl2-qa = ls_outputl2-qa + <data_l2>-qa.
        ls_outputl2-block = ls_outputl2-block + <data_l2>-block.
        ls_outputl2-available = ls_outputl2-available + <data_l2>-available.
        ls_outputl2-incoming = ls_outputl2-incoming + <data_l2>-incoming.
      ENDLOOP.
      APPEND ls_outputl2 TO lt_outputl2.
    ENDLOOP.

    DATA lt_mrp_outputl2 TYPE TABLE FOR CREATE zi_mrpa_output\_OutputL2.
    DATA ls_mrp_outputl2 LIKE LINE OF lt_mrp_outputl2.

    LOOP AT lt_output INTO ls_output.
      ls_mrp_outputl2-%cid_ref = keys[ 1 ]-%cid_ref.
      ls_mrp_outputl2-%is_draft = keys[ 1 ]-%is_draft.
      ls_mrp_outputl2-uname  = keys[ 1 ]-uname.
      ls_mrp_outputl2-Material = ls_output-material.
      LOOP AT lt_outputl2 INTO ls_outputl2 WHERE material = ls_output-material.
        APPEND INITIAL LINE TO ls_mrp_outputl2-%target ASSIGNING FIELD-SYMBOL(<fs_target_l2>).
        IF sy-subrc EQ 0.
          <fs_target_l2>-%is_draft = keys[ 1 ]-%is_draft.
          <fs_target_l2>-uname = keys[ 1 ]-uname.
          <fs_target_l2>-material = ls_outputl2-material.
          <fs_target_l2>-mrp = ls_outputl2-mrp.
          <fs_target_l2>-dlv = ls_outputl2-dlv.
          <fs_target_l2>-bo = ls_outputl2-bo.
          <fs_target_l2>-unr = ls_outputl2-unr.
          <fs_target_l2>-qa = ls_outputl2-qa.
          <fs_target_l2>-block = ls_outputl2-block.
          <fs_target_l2>-available = ls_outputl2-available.
          <fs_target_l2>-incoming = ls_outputl2-incoming.
          <fs_target_l2>-%control-uname = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-material = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-mrp    = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-dlv       = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-bo    = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-unr = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-qa   = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-block     = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-available       = if_abap_behv=>mk-on.
          <fs_target_l2>-%control-incoming     = if_abap_behv=>mk-on.
        ENDIF.
      ENDLOOP.
      APPEND ls_mrp_outputl2 TO lt_mrp_outputl2.
      CLEAR ls_mrp_outputl2.
    ENDLOOP.

*** Output L3
    DATA lt_outputl3 TYPE STANDARD TABLE OF zmrpa_outputl3.
    DATA ls_outputl3 LIKE LINE OF lt_outputl3.
    SORT lt_data BY material mrp customer.
    LOOP AT lt_data INTO ls_data
                   GROUP BY ( material = ls_data-material mrp = ls_data-mrp customer = ls_data-customer )
                   ASCENDING
                   ASSIGNING FIELD-SYMBOL(<lt_groupl3>).

      CLEAR: ls_outputl3, lv_first.
      LOOP AT GROUP <lt_groupl3> ASSIGNING FIELD-SYMBOL(<data_l3>).
        IF lv_first IS INITIAL.
          ls_outputl3-material = <data_l3>-material.
          ls_outputl3-mrp = <data_l3>-mrp.
          ls_outputl3-customer = <data_l3>-customer.
        ENDIF.
        lv_first = abap_true.
        ls_outputl3-available = ls_outputl3-available + <data_l3>-available.
        ls_outputl3-incoming = ls_outputl3-incoming + <data_l3>-incoming.
      ENDLOOP.
      APPEND ls_outputl3 TO lt_outputl3.
    ENDLOOP.

    DATA lt_mrp_outputl3 TYPE TABLE FOR CREATE zi_mrpa_outputl2\_outputl3.
    DATA ls_mrp_outputl3 LIKE LINE OF lt_mrp_outputl3.

    LOOP AT lt_outputl2 INTO ls_outputl2.
      ls_mrp_outputl3-%cid_ref = keys[ 1 ]-%cid_ref.
      ls_mrp_outputl3-%is_draft = keys[ 1 ]-%is_draft.
      ls_mrp_outputl3-uname  = keys[ 1 ]-uname.
      ls_mrp_outputl3-Material = ls_outputl2-material.
      ls_mrp_outputl3-mrp = ls_outputl2-mrp.
      LOOP AT lt_outputl3 INTO ls_outputl3 WHERE material = ls_outputl2-material
                                             AND mrp      = ls_outputl2-mrp.
        APPEND INITIAL LINE TO ls_mrp_outputl3-%target ASSIGNING FIELD-SYMBOL(<fs_target_l3>).
        IF sy-subrc EQ 0.
          <fs_target_l3>-%is_draft = keys[ 1 ]-%is_draft.
          <fs_target_l3>-uname = keys[ 1 ]-uname.
          <fs_target_l3>-material = ls_outputl3-material.
          <fs_target_l3>-mrp = ls_outputl3-mrp.
          <fs_target_l3>-customer = ls_outputl3-customer.
          <fs_target_l3>-available = ls_outputl3-available.
          <fs_target_l3>-incoming = ls_outputl3-incoming.
          <fs_target_l3>-%control-uname = if_abap_behv=>mk-on.
          <fs_target_l3>-%control-material = if_abap_behv=>mk-on.
          <fs_target_l3>-%control-mrp    = if_abap_behv=>mk-on.
          <fs_target_l3>-%control-customer    = if_abap_behv=>mk-on.
          <fs_target_l3>-%control-available       = if_abap_behv=>mk-on.
          <fs_target_l3>-%control-incoming     = if_abap_behv=>mk-on.
        ENDIF.
      ENDLOOP.
      APPEND ls_mrp_outputl3 TO lt_mrp_outputl3.
      CLEAR ls_mrp_outputl3.
    ENDLOOP.

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
     ENTITY App
     BY \_Output
     ALL FIELDS WITH
     CORRESPONDING #( keys )
     RESULT DATA(lt_bo_output).

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
     ENTITY OutputL1
     BY \_OutputL2
     ALL FIELDS WITH
     CORRESPONDING #( keys )
     RESULT DATA(lt_bo_outputl2).

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
     ENTITY OutputL2
     BY \_OutputL3
     ALL FIELDS WITH
     CORRESPONDING #( keys )
     RESULT DATA(lt_bo_outputl3).

    "Delete already existing entries from child entity
    MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
    ENTITY OutputL1
    DELETE FROM VALUE #( FOR ls_bo_output IN lt_bo_output (  %is_draft = ls_bo_output-%is_draft
                                                                 %key  = ls_bo_output-%key ) )
    MAPPED DATA(lt_mapped_delete)
    REPORTED DATA(lt_reported_delete)
    FAILED DATA(lt_failed_delete).

    "Delete already existing entries from child entity
    MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
    ENTITY OutputL2
    DELETE FROM VALUE #( FOR ls_bo_outputl2 IN lt_bo_outputl2 (  %is_draft = ls_bo_outputl2-%is_draft
                                                                 %key      = ls_bo_outputl2-%key ) )
    MAPPED DATA(lt_mapped_delete_l2)
    REPORTED DATA(lt_reported_delete_l2)
    FAILED DATA(lt_failed_delete_l2).

    "Delete already existing entries from child entity
    MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
    ENTITY Outputl3
    DELETE FROM VALUE #( FOR ls_bo_outputl3 IN lt_bo_outputl3 (  %is_draft = ls_bo_outputl3-%is_draft
                                                                 %key      = ls_bo_outputl3-%key ) )
    MAPPED DATA(lt_mapped_delete_l3)
    REPORTED DATA(lt_reported_delete_l3)
    FAILED DATA(lt_failed_delete_l3).

    "Create records from newly extract data
    MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
    ENTITY App
    CREATE BY \_Output
    AUTO FILL CID
    WITH lt_mrp_output
    MAPPED DATA(lt_mapped_create)
    REPORTED DATA(lt_mapped_reported)
    FAILED DATA(lt_mapped_failed).

    MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
    ENTITY OutputL1
    CREATE BY \_OutputL2
    AUTO FILL CID
    WITH lt_mrp_outputl2
    MAPPED DATA(lt_mapped_create_l2)
    REPORTED DATA(lt_mapped_reported_l2)
    FAILED DATA(lt_mapped_failed_l2).

    MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
    ENTITY OutputL2
    CREATE BY \_OutputL3
    AUTO FILL CID
    WITH lt_mrp_outputl3
    MAPPED DATA(lt_mapped_create_l3)
    REPORTED DATA(lt_mapped_reported_l3)
    FAILED DATA(lt_mapped_failed_l3).

    IF lt_output IS NOT INITIAL.
      APPEND VALUE #( %tky = lt_app[ 1 ]-%tky ) TO mapped-app.
      APPEND VALUE #(  %tky = ls_app_temp-%tky
                       %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                         text = 'Records were extracted. Check the Results tab' )
                     ) TO reported-app.
    ELSE.
      APPEND VALUE #( %tky = lt_app[ 1 ]-%tky ) TO failed-app.
      APPEND VALUE #(  %tky = ls_app_temp-%tky
                       %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                         text = 'No records found.' )
                     ) TO reported-app.
    ENDIF.

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
        ENTITY App
           ALL FIELDS
          WITH CORRESPONDING #(  keys  )
        RESULT lt_app.

    result = VALUE #( FOR ls_app IN lt_app
                          ( %tky   = ls_app-%tky
                            %param = ls_app ) ).

  ENDMETHOD.

  METHOD validateEntries.
  ENDMETHOD.

  METHOD exportToExcel.

    TYPES:
      BEGIN OF ty_excel,
        material TYPE c LENGTH 18,
      END OF ty_excel.

    DATA lt_excel TYPE STANDARD TABLE OF ty_excel.
    DATA ls_excel LIKE LINE OF lt_excel.

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
      ENTITY App
         ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_app)
      ENTITY App BY \_Output
        ALL FIELDS
      WITH CORRESPONDING #(  keys  )
      RESULT DATA(lt_item).

    LOOP AT lt_item INTO DATA(ls_item).
      ls_excel-material = ls_item-material.
      APPEND ls_excel TO lt_excel.
    ENDLOOP.

    IF lt_excel IS INITIAL.
      ls_excel-material = 'Sample file'.
      APPEND ls_excel TO lt_excel.
    ENDIF.

    DATA(lo_xlsx) = xco_cp_xlsx=>document->empty( )->write_access(  ).
    DATA(lo_worksheet) = lo_xlsx->get_workbook( )->worksheet->at_position( 1 ).

    DATA(lv_count) = lines( lt_excel ).
    IF lv_count IS INITIAL.
      lv_count = 1.
    ENDIF.
    "from and to is required for performance purposes
    DATA(lo_selection_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(
    )->from_column( xco_cp_xlsx=>coordinate->for_alphabetic_value( 'A' )
    )->from_row( xco_cp_xlsx=>coordinate->for_numeric_value( 1 )
    )->to_column( xco_cp_xlsx=>coordinate->for_alphabetic_value( 'B' )
    )->to_row( xco_cp_xlsx=>coordinate->for_numeric_value( lv_count )
    )->get_pattern( ).

    "Write rows of internal table it_data to worksheet
    lo_worksheet->select( lo_selection_pattern
    )->row_stream(
    )->operation->write_from( REF #( lt_excel )
    )->set_value_transformation( xco_cp_xlsx_write_access=>value_transformation->best_effort
    )->execute( ).

    DATA(lv_file_content) = lo_xlsx->get_file_content( ).

    MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
     ENTITY App
       UPDATE
         FIELDS ( Attachment MimeType Filename )
        WITH VALUE #( FOR app IN lt_app
                         ( %tky             = app-%tky
                           Attachment = lv_file_content
                           MimeType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                           Filename = 'Sample export file.xlsx'
                           %control-Attachment  = if_abap_behv=>mk-on
                           %control-MimeType  = if_abap_behv=>mk-on
                           %control-Filename  = if_abap_behv=>mk-on ) )
     MAPPED mapped
     FAILED failed
     REPORTED reported.

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
       ENTITY App
          ALL FIELDS
       WITH CORRESPONDING #( keys )
       RESULT lt_app.

    result = VALUE #( FOR app IN lt_app
                        ( %tky   = app-%tky
                          %param = app ) ).

    IF failed-app IS INITIAL.
      APPEND VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                        text = 'Export file has been generated.' )

                    ) TO reported-app.
    ENDIF.

  ENDMETHOD.

  METHOD refreshScreen.

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
          ENTITY App
             ALL FIELDS
            WITH CORRESPONDING #(  keys  )
          RESULT DATA(lt_app).

    result = VALUE #( FOR ls_app IN lt_app
                          ( %tky   = ls_app-%tky
                            %param = ls_app ) ).

  ENDMETHOD.

  METHOD precheck_update.
    IF 1 = 1.
    ENDIF.
  ENDMETHOD.

  METHOD Edit.
  ENDMETHOD.

  METHOD Resume.
    DATA(lv_test) = abap_true.
    IF 1 = 1.
    ENDIF.
  ENDMETHOD.

  METHOD refreshEntity.

    DATA(lo_singleton) = zcl_mrpa_singleton=>get_instance( ).
    lo_singleton->set_data( 'Open' ).

    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
          ENTITY App
             ALL FIELDS
            WITH  VALUE #( ( %key-uname = sy-uname ) )
          RESULT DATA(lt_app).

    SELECT * FROM zdmrpapp WHERE uname = @sy-uname INTO TABLE @DATA(lt_draft).
    IF sy-subrc EQ 0.
      READ TABLE lt_app ASSIGNING FIELD-SYMBOL(<fs_data>) INDEX 1.
      IF sy-subrc EQ 0.
        <fs_data>-%is_draft = '01'. "01 - draft
      ENDIF.
*      MODIFY ENTITIES OF zi_mrpapp IN LOCAL MODE
*      ENTITY App
*      DELETE FROM VALUE #( (  %is_draft = <fs_data>-%is_draft
*                                  %key  = <fs_data>-%key ) )
*      MAPPED DATA(lt_mapped_delete)
*      REPORTED DATA(lt_reported_delete)
*      FAILED DATA(lt_failed_delete).
    ENDIF.

*    READ ENTITIES OF zi_mrpapp IN LOCAL MODE
*          ENTITY App
*             ALL FIELDS
*            WITH  VALUE #( ( %key-uname = sy-uname ) )
*          RESULT lt_app.

    READ TABLE keys INTO DATA(ls_key) INDEX 1.
    result = VALUE #( FOR ls_app IN lt_app
                       (  %cid   = ls_key-%cid
                          %param = ls_app ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_MRPAPP DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_MRPAPP IMPLEMENTATION.

  METHOD save_modified.
    DATA lt_input TYPE STANDARD TABLE OF zmrpa_input.
    DATA ls_input LIKE LINE OF lt_input.

    DATA(lo_singleton) = zcl_mrpa_singleton=>get_instance( ).
    DATA(lv_value) = lo_singleton->get_data(  ).
    IF lv_value EQ 'Open'.
      SELECT * FROM zdmrpapp WHERE uname = @sy-uname INTO TABLE @DATA(lt_mrpapp).
      IF sy-subrc EQ 0.
        LOOP AT lt_mrpapp ASSIGNING FIELD-SYMBOL(<fs_app>).
          CLEAR: <fs_app>-plant, <fs_app>-region, <fs_app>-updatedata, <fs_app>-attachment, <fs_app>-mimetype, <fs_app>-filename.
        ENDLOOP.
        MODIFY zdmrpapp FROM TABLE @lt_mrpapp.
      ELSE.
        DELETE FROM zdmrpapp WHERE uname = @sy-uname.
      ENDIF.
*      DELETE FROM zdmrpapp WHERE uname = @sy-uname.
      DELETE FROM zdmrpa_matrange WHERE uname = @sy-uname.
      DELETE FROM zdmrpa_mrprange WHERE uname = @sy-uname.
      DELETE FROM zdmrpa_messages WHERE uname = @sy-uname.
      DELETE FROM zdmrpa_output WHERE uname = @sy-uname.
      DELETE FROM zdmrpa_outputl2 WHERE uname = @sy-uname.
      DELETE FROM zdmrpa_outputl3 WHERE uname = @sy-uname.
      DELETE FROM zmrpa_input WHERE uname = @sy-uname.
      DELETE FROM zmrpa_matrange WHERE uname = @sy-uname.
      DELETE FROM zmrpa_mrprange WHERE uname = @sy-uname.
      DELETE FROM zmrpa_messages WHERE uname = @sy-uname.
      DELETE FROM zmrpa_output WHERE uname = @sy-uname.
      DELETE FROM zmrpa_outputl2 WHERE uname = @sy-uname.
      DELETE FROM zmrpa_outputl3 WHERE uname = @sy-uname.
    ELSE.
       IF create-app IS NOT INITIAL.
         READ TABLE create-app ASSIGNING FIELD-SYMBOL(<app>) INDEX 1.
         IF sy-subrc EQ 0.
            MOVE-CORRESPONDING <app> TO ls_input.
            APPEND ls_input TO lt_input.
            MODIFY zmrpa_input FROM TABLE @lt_input.
         ENDIF.
       ENDIF.
       IF update-app IS NOT INITIAL.
         READ TABLE update-app ASSIGNING <app> INDEX 1.
         IF sy-subrc EQ 0.
            MOVE-CORRESPONDING <app> TO ls_input.
            APPEND ls_input TO lt_input.
            MODIFY zmrpa_input FROM TABLE @lt_input.
         ENDIF.
       ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
