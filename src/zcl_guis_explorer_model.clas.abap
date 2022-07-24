class ZCL_GUIS_EXPLORER_MODEL definition
  public
  create public .

public section.

  types:
    BEGIN OF TY_SESSION,
           description  TYPE string,
           is_gui_scripting_enabled TYPE abap_bool,
         END OF ty_session .
  types:
    ty_sessions TYPE STANDARD TABLE OF ty_session WITH KEY description .

  methods GET_LIST_OF_SESSIONS
    returning
      value(RT_LIST_OF_SESSIONS) type TY_SESSIONS
    raising
      ZCX_GUIS_ERROR .
protected section.
private section.

  methods _ADD_DATA_OF_CONNECTION
    importing
      !IO_CONNECTION type ref to ZCL_GUIS_CONNECTION
    changing
      !CT_LIST_OF_SESSIONS type TY_SESSIONS
    raising
      ZCX_GUIS_ERROR .
ENDCLASS.



CLASS ZCL_GUIS_EXPLORER_MODEL IMPLEMENTATION.


  method GET_LIST_OF_SESSIONS.

    DATA: lo_gui_application TYPE REF TO zcl_guis_application,
          lo_connections     TYPE REF TO zcl_guis_connections,
          lo_connection      TYPE REF TO zcl_guis_connection.

    lo_gui_application = zcl_guis_application=>get_gui_application( ).
    lo_connections = lo_gui_application->get_connections( ).

    lo_connection = lo_connections->get_first( ).
    WHILE lo_connection IS BOUND.
      _add_data_of_connection( EXPORTING io_connection       = lo_connection
                               CHANGING  ct_list_of_sessions = rt_list_of_sessions ).

      lo_connection = lo_connections->get_next( ).
    ENDWHILE.
  endmethod.


  method _ADD_DATA_OF_CONNECTION.
    FIELD-SYMBOLS: <ls_one_session> TYPE ty_session.

    APPEND INITIAL LINE TO ct_list_of_sessions ASSIGNING <ls_one_session>.
    <ls_one_session>-description = io_connection->get_description( ).
    <ls_one_session>-is_gui_scripting_enabled =
      zcl_guis_utils=>boolean_not( io_connection->is_disabled_by_server( ) ).
  endmethod.
ENDCLASS.
