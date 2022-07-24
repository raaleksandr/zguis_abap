class ZCL_GUIS_CONNECTION definition
  public
  inheriting from ZCL_GUIS_OLE_OBJECT
  create public .

public section.

  methods GET_DESCRIPTION
    returning
      value(RV_DESCRIPTION) type STRING
    raising
      ZCX_GUIS_ERROR .
  methods IS_DISABLED_BY_SERVER
    returning
      value(RV_DISABLED_BY_SERVER) type ABAP_BOOL
    raising
      ZCX_GUIS_ERROR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GUIS_CONNECTION IMPLEMENTATION.


  method GET_DESCRIPTION.
    rv_description = get_property_value_as_string( 'Description' ).
  endmethod.


  method IS_DISABLED_BY_SERVER.
    DATA: lv_is_disabled TYPE i.

    lv_is_disabled = get_property_value_as_string( 'DisabledByServer' ).
    IF lv_is_disabled = 1.
      rv_disabled_by_server = abap_true.
    ENDIF.
  endmethod.
ENDCLASS.
