CLASS zcl_bgpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_serializable_object .
    INTERFACES if_bgmc_operation .
    INTERFACES if_bgmc_op_single .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bgpf IMPLEMENTATION.


  METHOD if_bgmc_op_single~execute.
    DATA lt_user TYPE STANDARD TABLE OF zmrpa_user.
    DATA ls_user LIKE LINE OF lt_user.
    ls_user-bname = 'USER1'.
    APPEND ls_user TO lt_user.
    INSERT zmrpa_user FROM TABLE @lt_user.
  ENDMETHOD.
ENDCLASS.
