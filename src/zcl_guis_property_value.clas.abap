class ZCL_GUIS_PROPERTY_VALUE definition
  public
  create public .

public section.

  data M_PROPERTY_AS_OLE_OBJECT type OLE2_OBJECT read-only .
  data MV_PROPERTY_VALUE type STRING read-only .
  data MV_PROPERTY_NAME type OLE_VERB read-only .

  methods IS_OBJECT
    returning
      value(RV_IS_OBJECT) type ABAP_BOOL .
  methods CONSTRUCTOR
    importing
      !I_OLE_OBJECT type OLE2_OBJECT
      !IV_PROPERTY_NAME type CLIKE
    raising
      ZCX_GUIS_ERROR .
  methods GET_VALUE_AS_STRING
    returning
      value(RV_PROPERTY_VALUE) type STRING
    raising
      ZCX_GUIS_ERROR .
protected section.
private section.

  data MV_IS_OBJECT type ABAP_BOOL .
ENDCLASS.



CLASS ZCL_GUIS_PROPERTY_VALUE IMPLEMENTATION.


  method CONSTRUCTOR.
    DATA: lv_property_name TYPE ole_verb,
          ls_property_value_as_ole TYPE ole2_object.

    zcl_guis_utils=>raise_if_ole_object_empty( i_ole_object     = i_ole_object
                                               iv_property_name = iv_property_name ).

    mv_property_name = lv_property_name = iv_property_name.
    GET PROPERTY OF i_ole_object lv_property_name = ls_property_value_as_ole.
    IF ls_property_value_as_ole-type = 'OLE2'.
      mv_is_object = abap_true.
      m_property_as_ole_object = ls_property_value_as_ole.
    ELSE.
      GET PROPERTY OF i_ole_object lv_property_name = mv_property_value.
    ENDIF.
  endmethod.


  method GET_VALUE_AS_STRING.

    IF is_object( ) = abap_true.
      MESSAGE e011 WITH mv_property_name INTO zcl_guis_utils=>dummy.
      zcl_guis_utils=>raise_exception_from_sy_msg( ).
    ENDIF.
    rv_property_value = mv_property_value.
  endmethod.


  method IS_OBJECT.
    rv_is_object = mv_is_object.
  endmethod.
ENDCLASS.
