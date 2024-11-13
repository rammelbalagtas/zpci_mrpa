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

ENDCLASS.

CLASS lhc_App IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD clearInput.
  ENDMETHOD.

  METHOD extractData.

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
    ls_matnr_r-sign = 'I'.
    ls_matnr_r-option = 'BT'.
    LOOP AT lt_materials INTO DATA(ls_material).
      ls_matnr_r-low = ls_material-MatnrFrom.
      ls_matnr_r-high = ls_material-MatnrTo.
      APPEND ls_matnr_r TO lr_matnr.
    ENDLOOP.

    "MRP filter
    ls_mrp_r-sign = 'I'.
    ls_mrp_r-option = 'BT'.
    LOOP AT lt_mrp INTO DATA(ls_mrp).
      ls_mrp_r-low = ls_mrp-mrpfrom.
      ls_mrp_r-high = ls_mrp-mrpto.
      APPEND ls_mrp_r TO lr_mrp.
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

      DATA(lv_tabix) = 0.
      CLEAR: ls_output, lv_tabix.
      LOOP AT GROUP <lt_group> ASSIGNING FIELD-SYMBOL(<data>).
        IF lv_tabix IS INITIAL.
          ls_output-material = <data>-material.
        ENDIF.
        lv_tabix = 1.
        ls_output-dlv = ls_output-dlv + <data>-dlv.
        ls_output-bo = ls_output-bo + <data>-bo.
        ls_output-unr = ls_output-unr + <data>-unr.
        ls_output-qa = ls_output-qa + <data>-qa.
        ls_output-block = ls_output-block + <data>-block.
        ls_output-previousmonth = ls_output-previousmonth + <data>-previousmonth.
        ls_output-currentmonth = ls_output-currentmonth + <data>-currentmonth.
      ENDLOOP.
      APPEND ls_output TO lt_output.
    ENDLOOP.

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
                                                                               previousmonth = output-previousmonth
                                                                               currentmonth = output-currentmonth
                                                                               %control = VALUE #( uname       = if_abap_behv=>mk-on
                                                                                                   material    = if_abap_behv=>mk-on
                                                                                                   dlv       = if_abap_behv=>mk-on
                                                                                                   bo    = if_abap_behv=>mk-on
                                                                                                   unr = if_abap_behv=>mk-on
                                                                                                   qa   = if_abap_behv=>mk-on
                                                                                                   block     = if_abap_behv=>mk-on
                                                                                                   previousmonth       = if_abap_behv=>mk-on
                                                                                                   currentmonth     = if_abap_behv=>mk-on ) ) ) ) ).


*** Output L2
    DATA lt_outputl2 TYPE STANDARD TABLE OF zmrpa_outputl2.
    DATA ls_outputl2 LIKE LINE OF lt_outputl2.
    SORT lt_data BY material mrp.
    LOOP AT lt_data INTO ls_data
                   GROUP BY ( material = ls_data-material mrp = ls_data-mrp )
                   ASCENDING
                   ASSIGNING FIELD-SYMBOL(<lt_groupl2>).

      lv_tabix = 0.
      CLEAR: ls_outputl2, lv_tabix.
      LOOP AT GROUP <lt_groupl2> ASSIGNING FIELD-SYMBOL(<data_l2>).
        IF lv_tabix IS INITIAL.
          ls_outputl2-material = <data_l2>-material.
          ls_outputl2-mrp = <data_l2>-mrp.
        ENDIF.
        lv_tabix = 1.
        ls_outputl2-dlv = ls_outputl2-dlv + <data_l2>-dlv.
        ls_outputl2-bo = ls_outputl2-bo + <data_l2>-bo.
        ls_outputl2-unr = ls_outputl2-unr + <data_l2>-unr.
        ls_outputl2-qa = ls_outputl2-qa + <data_l2>-qa.
        ls_outputl2-block = ls_outputl2-block + <data_l2>-block.
        ls_outputl2-previousmonth = ls_outputl2-previousmonth + <data_l2>-previousmonth.
        ls_outputl2-currentmonth = ls_outputl2-currentmonth + <data_l2>-currentmonth.
      ENDLOOP.
      APPEND ls_outputl2 TO lt_outputl2.
    ENDLOOP.

    DATA lt_mrp_outputl2 TYPE TABLE FOR CREATE ZI_MRPA_OUTPUT\_OutputL2.
    lt_mrp_outputl2 = VALUE #( (
                                %cid_ref  = keys[ 1 ]-%cid_ref
                                %is_draft = keys[ 1 ]-%is_draft
                                uname  = keys[ 1 ]-uname
                                %target   = VALUE #( FOR outputl2 IN lt_outputl2 ( %is_draft = keys[ 1 ]-%is_draft
                                                                               uname = keys[ 1 ]-uname
                                                                               material = outputl2-material
                                                                               mrp = outputl2-mrp
                                                                               dlv = outputl2-dlv
                                                                               bo = outputl2-bo
                                                                               unr = outputl2-unr
                                                                               qa = outputl2-qa
                                                                               block = outputl2-block
                                                                               previousmonth = outputl2-previousmonth
                                                                               currentmonth = outputl2-currentmonth
                                                                               %control = VALUE #( uname       = if_abap_behv=>mk-on
                                                                                                   material    = if_abap_behv=>mk-on
                                                                                                   mrp    = if_abap_behv=>mk-on
                                                                                                   dlv       = if_abap_behv=>mk-on
                                                                                                   bo    = if_abap_behv=>mk-on
                                                                                                   unr = if_abap_behv=>mk-on
                                                                                                   qa   = if_abap_behv=>mk-on
                                                                                                   block     = if_abap_behv=>mk-on
                                                                                                   previousmonth       = if_abap_behv=>mk-on
                                                                                                   currentmonth     = if_abap_behv=>mk-on ) ) ) ) ).

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

    APPEND VALUE #( %tky = lt_app[ 1 ]-%tky ) TO mapped-app.
    APPEND VALUE #(  %tky = ls_app_temp-%tky
                     %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                       text = 'Records were extracted. Check the Results tab' )
                   ) TO reported-app.

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

ENDCLASS.

CLASS lsc_ZI_MRPAPP DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_MRPAPP IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
