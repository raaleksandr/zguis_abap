"! <p class="shorttext synchronized" lang="en">Model class for GUI Explorer program</p>
CLASS zcl_guis_explorer_model DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_session,
        connection_name          TYPE string,
        is_gui_scripting_enabled TYPE abap_bool,
        busy                     TYPE abap_bool,
        system_name              TYPE string,
        client                   TYPE string,
        session_number           TYPE string,
        application_server       TYPE string,
        language                 TYPE string,
        system_session_id        TYPE string,
        user                     TYPE string,
        transaction              TYPE string,
        program                  TYPE string,
        screen_number            TYPE string,
      END OF ty_session .
    TYPES:
      ty_sessions TYPE STANDARD TABLE OF ty_session WITH KEY connection_name session_number .

    "! <p class="shorttext synchronized" lang="en">Returns list of SAP GUI Scripting Sessions</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS get_list_of_sessions
      RETURNING
        VALUE(rt_list_of_sessions) TYPE ty_sessions
      RAISING
        zcx_guis_error .
  PROTECTED SECTION.
  PRIVATE SECTION.

    "! <p class="shorttext synchronized" lang="en">Adds data of one connection to sessions list</p>
    "!
    "! @parameter io_connection  | <p class="shorttext synchronized" lang="en">Connection object of GUI Scripting</p>
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS _add_data_of_connection
      IMPORTING
        !io_connection       TYPE REF TO zcl_guis_connection
      CHANGING
        !ct_list_of_sessions TYPE ty_sessions
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Adds data of one session to list</p>
    "!
    "! @parameter iv_connection_name  | <p class="shorttext synchronized" lang="en">Name of GUI Scripting connection</p>
    "! @parameter iv_gui_scripting_enabled  | <p class="shorttext synchronized" lang="en">Flag that GUI Scripting is enabled for connection</p>
    "! @parameter io_session  | <p class="shorttext synchronized" lang="en">Session object of GUI Scripting</p>
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS _add_data_of_session
      IMPORTING
        !iv_connection_name             TYPE string
        VALUE(iv_gui_scripting_enabled) TYPE abap_bool
        !io_session                     TYPE REF TO zcl_guis_session
      CHANGING
        !ct_list_of_sessions            TYPE ty_sessions
      RAISING
        zcx_guis_error .
ENDCLASS.



CLASS zcl_guis_explorer_model IMPLEMENTATION.


  METHOD get_list_of_sessions.

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
  ENDMETHOD.


  METHOD _add_data_of_connection.

    DATA: lo_sessions TYPE REF TO zcl_guis_sessions,
          lo_session  TYPE REF TO zcl_guis_session.

    FIELD-SYMBOLS: <ls_one_session> TYPE ty_session.

    lo_sessions = io_connection->get_sessions( ).
    lo_session = lo_sessions->get_first( ).
    WHILE lo_session IS BOUND.

      _add_data_of_session(
        EXPORTING
          iv_connection_name       = io_connection->get_description( )
          iv_gui_scripting_enabled = io_connection->is_disabled_by_server( )
          io_session               = lo_session
        CHANGING
          ct_list_of_sessions      = ct_list_of_sessions ).

      lo_session = lo_sessions->get_next( ).
    ENDWHILE.

  ENDMETHOD.

  METHOD _add_data_of_session.

    DATA: lo_info TYPE REF TO zcl_guis_session_info.

    FIELD-SYMBOLS: <ls_one_session> TYPE ty_session.

    APPEND INITIAL LINE TO ct_list_of_sessions ASSIGNING <ls_one_session>.
    <ls_one_session>-connection_name = iv_connection_name.
    <ls_one_session>-is_gui_scripting_enabled =
        zcl_guis_utils=>boolean_not( iv_gui_scripting_enabled ).

    <ls_one_session>-busy = io_session->is_busy( ).
    IF <ls_one_session>-busy = abap_true.
      RETURN.
    ENDIF.

    lo_info = io_session->info( ).
    <ls_one_session>-application_server = lo_info->application_server( ).
    <ls_one_session>-client = lo_info->client( ).
    <ls_one_session>-language = lo_info->language( ).
    <ls_one_session>-program = lo_info->program( ).
    <ls_one_session>-screen_number = lo_info->screen_number( ).
    <ls_one_session>-session_number = lo_info->session_number( ).
    <ls_one_session>-system_name = lo_info->system_name( ).
    <ls_one_session>-system_session_id = lo_info->system_session_id( ).
    <ls_one_session>-transaction = lo_info->transaction( ).
    <ls_one_session>-user = lo_info->user( ).
  ENDMETHOD.
ENDCLASS.
