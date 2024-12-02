CLASS zmrpa_datagenerator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMRPA_DATAGENERATOR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "submit to
    DATA lt_values TYPE STANDARD TABLE OF zmrpmat WITH EMPTY KEY.
    DELETE FROM zmrpmat.
    lt_values = VALUE #(
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP1' customer = 'CUSTOMER1' material = 'MATERIAL1' dlv = 11 bo = 11 unr = 11 qa = 11 block = 11 available = 111 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP1' customer = 'CUSTOMER2' material = 'MATERIAL1' dlv = 22 bo = 22 unr = 22 qa = 22 block = 22 available = 0 incoming = 222 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER1' material = 'MATERIAL1' dlv = 33 bo = 33 unr = 33 qa = 33 block = 33 available = 333 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER2' material = 'MATERIAL1' dlv = 44 bo = 44 unr = 44 qa = 44 block = 44 available = 444 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER3' material = 'MATERIAL1' dlv = 55 bo = 55 unr = 55 qa = 55 block = 55 available = 555 incoming = 0 )

                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP1' customer = 'CUSTOMER1' material = 'MATERIAL2' dlv = 11 bo = 11 unr = 11 qa = 11 block = 11 available = 111 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP1' customer = 'CUSTOMER2' material = 'MATERIAL2' dlv = 22 bo = 22 unr = 22 qa = 22 block = 22 available = 0 incoming = 222 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER1' material = 'MATERIAL2' dlv = 33 bo = 33 unr = 33 qa = 33 block = 33 available = 333 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER2' material = 'MATERIAL2' dlv = 44 bo = 44 unr = 44 qa = 44 block = 44 available = 444 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER3' material = 'MATERIAL2' dlv = 55 bo = 55 unr = 55 qa = 55 block = 55 available = 555 incoming = 0 )

                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP1' customer = 'CUSTOMER1' material = 'MATERIAL3' dlv = 11 bo = 11 unr = 11 qa = 11 block = 11 available = 111 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP1' customer = 'CUSTOMER2' material = 'MATERIAL3' dlv = 22 bo = 22 unr = 22 qa = 22 block = 22 available = 0 incoming = 222 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER1' material = 'MATERIAL3' dlv = 33 bo = 33 unr = 33 qa = 33 block = 33 available = 333 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER2' material = 'MATERIAL3' dlv = 44 bo = 44 unr = 44 qa = 44 block = 44 available = 444 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZA' mrp = 'MRP2' customer = 'CUSTOMER3' material = 'MATERIAL3' dlv = 55 bo = 55 unr = 55 qa = 55 block = 55 available = 555 incoming = 0 )

                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP1' customer = 'CUSTOMER1' material = 'MATERIAL1' dlv = 11 bo = 11 unr = 11 qa = 11 block = 11 available = 111 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP1' customer = 'CUSTOMER2' material = 'MATERIAL1' dlv = 22 bo = 22 unr = 22 qa = 22 block = 22 available = 0 incoming = 222 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER1' material = 'MATERIAL1' dlv = 33 bo = 33 unr = 33 qa = 33 block = 33 available = 333 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER2' material = 'MATERIAL1' dlv = 44 bo = 44 unr = 44 qa = 44 block = 44 available = 444 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER3' material = 'MATERIAL1' dlv = 55 bo = 55 unr = 55 qa = 55 block = 55 available = 555 incoming = 0 )

                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP1' customer = 'CUSTOMER1' material = 'MATERIAL2' dlv = 11 bo = 11 unr = 11 qa = 11 block = 11 available = 111 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP1' customer = 'CUSTOMER2' material = 'MATERIAL2' dlv = 22 bo = 22 unr = 22 qa = 22 block = 22 available = 0 incoming = 222 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER1' material = 'MATERIAL2' dlv = 33 bo = 33 unr = 33 qa = 33 block = 33 available = 333 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER2' material = 'MATERIAL2' dlv = 44 bo = 44 unr = 44 qa = 44 block = 44 available = 444 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER3' material = 'MATERIAL2' dlv = 55 bo = 55 unr = 55 qa = 55 block = 55 available = 555 incoming = 0 )

                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP1' customer = 'CUSTOMER1' material = 'MATERIAL3' dlv = 11 bo = 11 unr = 11 qa = 11 block = 11 available = 111 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP1' customer = 'CUSTOMER2' material = 'MATERIAL3' dlv = 22 bo = 22 unr = 22 qa = 22 block = 22 available = 0 incoming = 222 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER1' material = 'MATERIAL3' dlv = 33 bo = 33 unr = 33 qa = 33 block = 33 available = 333 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER2' material = 'MATERIAL3' dlv = 44 bo = 44 unr = 44 qa = 44 block = 44 available = 444 incoming = 0 )
                         ( region = 'REGION1' plant = 'YYZB' mrp = 'MRP2' customer = 'CUSTOMER3' material = 'MATERIAL3' dlv = 55 bo = 55 unr = 55 qa = 55 block = 55 available = 555 incoming = 0 )

                        ).
    INSERT zmrpmat FROM TABLE @lt_values.

    DATA lt_user TYPE STANDARD TABLE OF zmrpa_user.
    DATA ls_user LIKE LINE OF lt_user.
    DELETE FROM zmrpa_user.
    ls_user-bname = sy-uname.
    APPEND ls_user TO lt_user.
    ls_user-bname = 'CB9980001268'.
    APPEND ls_user TO lt_user.
    INSERT zmrpa_user FROM TABLE @lt_user.

*    DELETE FROM zdmrpapp WHERE uname = @sy-uname.
*    DELETE FROM zdmrpa_matrange WHERE uname = @sy-uname.
*    DELETE FROM zdmrpa_mrprange WHERE uname = @sy-uname.
*    DELETE FROM zdmrpa_messages WHERE uname = @sy-uname.
*    DELETE FROM zdmrpa_output WHERE uname = @sy-uname.
*    DELETE FROM zdmrpa_outputl2 WHERE uname = @sy-uname.
*    DELETE FROM zdmrpa_outputl3 WHERE uname = @sy-uname.
*    DELETE FROM zmrpa_input WHERE uname = @sy-uname.
*    DELETE FROM zmrpa_matrange WHERE uname = @sy-uname.
*    DELETE FROM zmrpa_mrprange WHERE uname = @sy-uname.
*    DELETE FROM zmrpa_messages WHERE uname = @sy-uname.
*    DELETE FROM zmrpa_output WHERE uname = @sy-uname.
*    DELETE FROM zmrpa_outputl2 WHERE uname = @sy-uname.
*    DELETE FROM zmrpa_outputl3 WHERE uname = @sy-uname.

*     DATA lt_app TYPE STANDARD TABLE OF ZDMRPAPP.
*     DATA ls_app LIKE LINE OF lt_app.
*     ls_app-uname = sy-uname.
*     ls_app-draftentityoperationcode = 'N'.
*     ls_app-hasactiveentity = 'X'.
*     APPEND ls_app to lt_app.
*     INSERT ZDMRPAPP FROM TABLE @lt_app.

* TRY.
*        "Get instance of lock object
*        DATA(lock) = cl_abap_lock_object_factory=>get_instance( iv_name = 'ZI_MRPAPP' ).
*        IF 1 = 1.
*        ENDIF.
*        "Enqueue(lock) the record / group of records
**        lock->enqueue(
**            it_parameter  = VALUE #( (  name = 'PLANT' value = REF #( 'DE82' ) ) )
**        ).
*        "lock error
*      CATCH cx_abap_lock_failure INTO DATA(ex_lock_failure).
*        "Depends on implementation if You need to let it dump
*        IF 1 = 1.
*        ENDIF.
*        "foreign lock
*      CATCH cx_abap_foreign_lock INTO DATA(ex_foreign_lock).
*        "This user is locking already
*        DATA(iam_locking_it) = ex_foreign_lock->user_name.
*    ENDTRY.

  ENDMETHOD.
ENDCLASS.
