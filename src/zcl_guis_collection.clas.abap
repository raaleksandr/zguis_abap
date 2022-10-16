class ZCL_GUIS_COLLECTION definition
  public
  inheriting from ZCL_GUIS_OLE_OBJECT
  create public .

public section.

  methods GET_COUNT
    returning
      value(RV_COUNT) type I
    raising
      ZCX_GUIS_ERROR .
  methods GET_FIRST
    returning
      value(RO_OBJECT) type ref to ZCL_GUIS_OLE_OBJECT
    raising
      ZCX_GUIS_ERROR .
  methods GET_NEXT
    returning
      value(RO_OBJECT) type ref to ZCL_GUIS_OLE_OBJECT .
  class-methods object_is_collection
    IMPORTING
      io_ole_object TYPE REF TO zcl_guis_ole_object
    RETURNING VALUE(rv_is_collection) TYPE abap_bool
    raising ZCX_GUIS_ERROR.
protected section.
private section.

  data MV_CURRENT_POSITION type I .
  data MV_COUNT_OF_CURRENT_CYCLE type I .

  methods _GET_OBJECT_AT_POSITION
    importing
      !IV_POSITION_STARING_FROM_0 type I
    returning
      value(RO_OLE_OBJECT) type ref to ZCL_GUIS_OLE_OBJECT .
  methods _GET_OLE_OBJECT_AT_POSITION
    importing
      !IV_POSITION_STARING_FROM_0 type I
    returning
      value(R_OLE_OBJECT) type OLE2_OBJECT .
ENDCLASS.

CLASS ZCL_GUIS_COLLECTION IMPLEMENTATION.

  method GET_COUNT.
    rv_count = get_property_value_as_string( 'Count' ).
  endmethod.


  method GET_FIRST.
    mv_count_of_current_cycle = get_count( ).
    mv_current_position = 0.

    IF mv_count_of_current_cycle > 0.
      ro_object = _get_object_at_position( mv_current_position ).
      mv_current_position = mv_current_position + 1.
    ENDIF.
  endmethod.


  method GET_NEXT.
    IF mv_current_position < mv_count_of_current_cycle.
      ro_object = _get_object_at_position( mv_current_position ).
      mv_current_position = mv_current_position + 1.
    ENDIF.
  endmethod.

  method object_is_collection.

    DATA: lv_type TYPE string.
    lv_type = io_ole_object->get_type( ).
    IF lv_type = 'GuiCollection' Or lv_type = 'GuiComponentCollection'.
        rv_is_collection = abap_true.
    ENDIF.
  endmethod.

  method _GET_OBJECT_AT_POSITION.

    DATA: l_ole_object TYPE ole2_object.

    l_ole_object = _get_ole_object_at_position( mv_current_position ).
    CREATE OBJECT ro_ole_object
      EXPORTING
        i_ole_object = l_ole_object.
  endmethod.


  method _GET_OLE_OBJECT_AT_POSITION.
    GET PROPERTY OF m_ole_object 'Item' = r_ole_object
      EXPORTING
        #1 = iv_position_staring_from_0.
  endmethod.
ENDCLASS.
