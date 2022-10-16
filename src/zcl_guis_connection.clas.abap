"! <p class="shorttext synchronized" lang="en">Connection object of GUI Scripting</p>
class ZCL_GUIS_CONNECTION definition
  public
  inheriting from ZCL_GUIS_OLE_OBJECT
  create public .

public section.

  "! <p class="shorttext synchronized" lang="en">Returns description of connection object</p>
  "!
  "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods GET_DESCRIPTION
    returning
      value(RV_DESCRIPTION) type STRING
    raising
      ZCX_GUIS_ERROR .
  "! <p class="shorttext synchronized" lang="en">Returns collection of SAPGUI sessions of a connection</p>
  "!
  "! @parameter ro_sessions    | <p class="shorttext synchronized" lang="en">Connections list of SAP GUI Scripting</p>
  "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods GET_SESSIONS
    returning
      value(RO_SESSIONS) type ref to ZCL_GUIS_SESSIONS
    raising
      ZCX_GUIS_ERROR .
  "! <p class="shorttext synchronized" lang="en">Returns flag if SAP GUI Scripting is disabled in connection</p>
  "!
  "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
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


  method GET_SESSIONS.

    DATA: lo_property_value TYPE REF TO zcl_guis_property_value.

    lo_property_value = get_property_value( 'Sessions' ).
    CREATE OBJECT ro_sessions
      EXPORTING
        i_ole_object = lo_property_value->m_property_as_ole_object.
  endmethod.


  method IS_DISABLED_BY_SERVER.
    rv_disabled_by_server = get_property_value_as_bool( 'DisabledByServer' ).
  endmethod.

ENDCLASS.
