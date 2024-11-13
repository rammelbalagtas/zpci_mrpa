CLASS zcl_mrpa_singleton DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO zcl_mrpa_singleton.
    METHODS set_data
      IMPORTING
        iv_value TYPE string.
    METHODS set_filter
      IMPORTING
        it_filters TYPE if_rap_query_filter=>tt_name_range_pairs.
    METHODS get_data
      RETURNING
        VALUE(rv_value) TYPE string.
    METHODS get_filters
      RETURNING
        VALUE(rt_filters) TYPE if_rap_query_filter=>tt_name_range_pairs.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA go_instance TYPE REF TO zcl_mrpa_singleton.
    DATA gv_value TYPE string.
    DATA gt_filters TYPE if_rap_query_filter=>tt_name_range_pairs.
ENDCLASS.

CLASS zcl_mrpa_singleton IMPLEMENTATION.
  METHOD get_instance.
    IF go_instance IS BOUND.
      ro_instance = go_instance.
    ELSE.
      ro_instance = NEW zcl_mrpa_singleton(  ).
    ENDIF.
    go_instance = ro_instance.
  ENDMETHOD.

  METHOD set_data.
    gv_value = iv_value.
  ENDMETHOD.

  METHOD set_filter.
    gt_filters = it_filters.
  ENDMETHOD.

  METHOD get_data.
    rv_value = gv_value.
  ENDMETHOD.

  METHOD get_filters.
    rt_filters = gt_filters.
  ENDMETHOD.
ENDCLASS.
