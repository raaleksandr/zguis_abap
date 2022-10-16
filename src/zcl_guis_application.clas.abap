class ZCL_GUIS_APPLICATION definition
  public
  inheriting from ZCL_GUIS_OLE_OBJECT
  create public .

public section.

  methods GET_CONNECTIONS
    returning
      value(RO_CONNECTIONS) type ref to ZCL_GUIS_CONNECTIONS
    raising
      ZCX_GUIS_ERROR .
  class-methods GET_GUI_APPLICATION
    returning
      value(RO_GUI_APPLICATION) type ref to ZCL_GUIS_APPLICATION
    raising
      ZCX_GUIS_ERROR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GUIS_APPLICATION IMPLEMENTATION.


  method GET_CONNECTIONS.

    DATA: lo_property_value TYPE REF TO zcl_guis_property_value.

    lo_property_value = get_property_value( 'Connections' ).
    CREATE OBJECT ro_connections
      EXPORTING
        i_ole_object = lo_property_value->m_property_as_ole_object.
  endmethod.


  method GET_GUI_APPLICATION.
    DATA: lo_vbscript           TYPE REF TO zcl_guis_vbscript_runner,
          l_sapgui_ole_object   TYPE ole2_object,
          l_gui_application_ole TYPE ole2_object.

    CREATE OBJECT lo_vbscript.
    l_sapgui_ole_object = lo_vbscript->get_object( 'SAPGUI' ).

    IF l_sapgui_ole_object IS INITIAL.
      MESSAGE e017 INTO zcl_guis_utils=>dummy.
      zcl_guis_utils=>raise_exception_from_sy_msg( ).
    ENDIF.

    CALL METHOD OF l_sapgui_ole_object 'GetScriptingEngine' = l_gui_application_ole.

    CREATE OBJECT ro_gui_application
      EXPORTING
        i_ole_object = l_gui_application_ole.
  endmethod.
ENDCLASS.
