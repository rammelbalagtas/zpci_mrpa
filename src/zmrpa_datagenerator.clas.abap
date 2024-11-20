CLASS zmrpa_datagenerator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmrpa_datagenerator IMPLEMENTATION.

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
     APPEND ls_user to lt_user.
     INSERT zmrpa_user FROM TABLE @lt_user.

  ENDMETHOD.
ENDCLASS.
