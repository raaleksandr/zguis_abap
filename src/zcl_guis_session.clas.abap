"! <p class="shorttext synchronized" lang="en">Session object of GUI Scripting</p>
class ZCL_GUIS_SESSION definition
  public
  inheriting from ZCL_GUIS_OLE_OBJECT
  create public .

public section.

  "! <p class="shorttext synchronized" lang="en">Returns busy state of session</p>
  "!
  "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods IS_BUSY
    returning
      value(RV_IS_BUSY) type ABAP_BOOL
    raising
      ZCX_GUIS_ERROR .
  "! <p class="shorttext synchronized" lang="en">Returns object with info of session</p>
  "!
  "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods INFO
    returning
      value(RO_INFO) type ref to ZCL_GUIS_SESSION_INFO
    raising
      ZCX_GUIS_ERROR .
  "! <p class="shorttext synchronized" lang="en">Create new session like /o pressed</p>
  "!
  "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods create_new_session
    returning
      value(RO_session) type ref to ZCL_GUIS_SESSION
    raising
      ZCX_GUIS_ERROR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GUIS_SESSION IMPLEMENTATION.


  method info.
    DATA: lo_property_value TYPE REF TO zcl_guis_property_value.

    lo_property_value = get_property_value( 'Info' ).

    IF lo_property_value->is_object( ) <> abap_true.
      MESSAGE e013 WITH 'Info' INTO zcl_guis_utils=>dummy.
      zcl_guis_utils=>raise_exception_from_sy_msg( ).
    ENDIF.

    CREATE OBJECT ro_info
      EXPORTING
        i_ole_object = lo_property_value->m_property_as_ole_object.
  endmethod.


  method is_busy.
    rv_is_busy = get_property_value_as_bool( 'Busy' ).
  endmethod.

  method create_new_session.
    DATA: l_ole_object  TYPE ole2_object.

    CALL METHOD OF m_ole_object 'CreateSession' = l_ole_object.
    CREATE OBJECT ro_session
      EXPORTING
        i_ole_object = l_ole_object.
  endmethod.
ENDCLASS.
