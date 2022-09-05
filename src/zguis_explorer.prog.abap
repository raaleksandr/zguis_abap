*&---------------------------------------------------------------------*
*& Report ZGUIS_EXPLORER
*&---------------------------------------------------------------------*
*& Program to explore SAP GUI Scripting sessions and elements
*&---------------------------------------------------------------------*
REPORT zguis_explorer MESSAGE-ID zguiscript_abap.

CLASS lcl_application DEFINITION DEFERRED.
DATA: gv_ok_code_100 TYPE syucomm,
      go_application TYPE REF TO lcl_application.

CLASS lcl_application DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor,
      on_status_0100,
      on_user_command_0100.

  PRIVATE SECTION.
    DATA: go_container_0100 TYPE REF TO cl_gui_custom_container,
          go_alv_0100       TYPE REF TO cl_salv_table,
          go_model          TYPE REF TO zcl_guis_explorer_model,
          gt_sessions_list  TYPE zcl_guis_explorer_model=>ty_sessions.

    METHODS: _show_error IMPORTING io_error TYPE REF TO cx_root,
             _prepare_alv100_before_show IMPORTING io_alv TYPE REF TO cl_salv_table
                                         RAISING cx_salv_not_found,
             _prepare_alv100_columns IMPORTING io_alv TYPE REF TO cl_salv_table
                                         RAISING cx_salv_not_found,
             _prepare_alv100_events IMPORTING io_alv TYPE REF TO cl_salv_table,
             _main_alv_double_click FOR EVENT double_click OF cl_salv_events_table
                                    IMPORTING row column.
ENDCLASS.

START-OF-SELECTION.
  CREATE OBJECT go_application.
  CALL SCREEN 100.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  go_application->on_user_command_0100( ).
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  go_application->on_status_0100( ).
ENDMODULE.

CLASS lcl_application IMPLEMENTATION.

  METHOD constructor.
    CREATE OBJECT go_model.
  ENDMETHOD.

  METHOD on_status_0100.

    DATA: lo_error         TYPE REF TO cx_root.

    SET PF-STATUS '0100'.
    SET TITLEBAR '0100'.

    IF go_container_0100 IS NOT BOUND.
      CREATE OBJECT go_container_0100
        EXPORTING
          container_name = 'START_ALV'.
    ENDIF.

    IF go_alv_0100 IS NOT BOUND.

      TRY.
          gt_sessions_list = go_model->get_list_of_sessions( ).
          cl_salv_table=>factory( EXPORTING r_container  = go_container_0100
                                  IMPORTING r_salv_table = go_alv_0100
                                  CHANGING  t_table      = gt_sessions_list ).

          _prepare_alv100_before_show( go_alv_0100 ).

          go_alv_0100->display( ).
        CATCH cx_root INTO lo_error.
          _show_error( lo_error ).
      ENDTRY.
    ENDIF.
  ENDMETHOD.

  METHOD on_user_command_0100.
    CASE gv_ok_code_100.
      WHEN 'BACK' OR 'EXIT' OR 'CANC'.
        SET SCREEN 0.
    ENDCASE.

    CLEAR gv_ok_code_100.
  ENDMETHOD.

  METHOD _show_error.

    DATA: lv_text_of_error TYPE string.

    lv_text_of_error = io_error->get_text( ).
    MESSAGE lv_text_of_error TYPE 'E' DISPLAY LIKE 'I'.
  ENDMETHOD.

  METHOD _prepare_alv100_before_show.
    _prepare_alv100_columns( io_alv ).
    _prepare_alv100_events( io_alv ).
  ENDMETHOD.

  METHOD _prepare_alv100_columns.
    DATA: lo_columns TYPE REF TO cl_salv_columns_table,
          lo_column  TYPE REF TO cl_salv_column.

    lo_columns = io_alv->get_columns( ).
    lo_column = lo_columns->get_column( 'CONNECTION_NAME' ).
    lo_column->set_short_text( 'Conn.' ).
    lo_column->set_medium_text( 'Connection' ).

    lo_column = lo_columns->get_column( 'IS_GUI_SCRIPTING_ENABLED' ).
    lo_column->set_short_text( 'Enabled' ).
    lo_column->set_medium_text( 'GuiScrEnabled' ).
    lo_column->set_long_text( 'Is Gui Scripting Enabled' ).

    lo_column = lo_columns->get_column( 'APPLICATION_SERVER' ).
    lo_column->set_short_text( 'AppSrv' ).
    lo_column->set_medium_text( 'ApplicationServ' ).
    lo_column->set_long_text( 'Application Server' ).

    lo_column = lo_columns->get_column( 'CLIENT' ).
    lo_column->set_short_text( 'Clnt' ).
    lo_column->set_medium_text( 'Client' ).
    lo_column->set_long_text( 'Client' ).

    lo_column = lo_columns->get_column( 'LANGUAGE' ).
    lo_column->set_short_text( 'Lang' ).
    lo_column->set_medium_text( 'Language' ).
    lo_column->set_long_text( 'Language' ).

    lo_column = lo_columns->get_column( 'PROGRAM' ).
    lo_column->set_short_text( 'Prog' ).
    lo_column->set_medium_text( 'Program' ).
    lo_column->set_long_text( 'ABAP Program' ).

    lo_column = lo_columns->get_column( 'SCREEN_NUMBER' ).
    lo_column->set_short_text( 'ScrNm' ).
    lo_column->set_medium_text( 'ScreenNum' ).
    lo_column->set_long_text( 'Screen Number' ).

    lo_column = lo_columns->get_column( 'SESSION_NUMBER' ).
    lo_column->set_short_text( 'SessNr' ).
    lo_column->set_medium_text( 'SessionNum' ).
    lo_column->set_long_text( 'Session Number' ).

    lo_column = lo_columns->get_column( 'SYSTEM_NAME' ).
    lo_column->set_short_text( 'Sys' ).
    lo_column->set_medium_text( 'SysName' ).
    lo_column->set_long_text( 'System name (SID)' ).

    lo_column = lo_columns->get_column( 'SYSTEM_SESSION_ID' ).
    lo_column->set_short_text( 'SessId' ).
    lo_column->set_medium_text( 'SessionId' ).
    lo_column->set_long_text( 'System session ID' ).

    lo_column = lo_columns->get_column( 'TRANSACTION' ).
    lo_column->set_short_text( 'Tran' ).
    lo_column->set_medium_text( 'Transaction' ).
    lo_column->set_long_text( 'Transaction' ).

    lo_column = lo_columns->get_column( 'USER' ).
    lo_column->set_short_text( 'Usr' ).
    lo_column->set_medium_text( 'User' ).
    lo_column->set_long_text( 'User' ).

    lo_column = lo_columns->get_column( 'SESSION_ID' ).
    lo_column->set_short_text( 'SessId' ).
    lo_column->set_medium_text( 'SessionId' ).
    lo_column->set_long_text( 'Session Id' ).

    lo_columns->set_optimize( abap_true ).
  ENDMETHOD.

  METHOD _prepare_alv100_events.
    DATA: lo_salv_events TYPE REF TO CL_SALV_EVENTS_TABLE.

    lo_salv_events = io_alv->get_event( ).
    SET HANDLER _main_alv_double_click FOR lo_salv_events.
  ENDMETHOD.

  METHOD _main_alv_double_click.

    DATA: lo_session TYPE REF TO zcl_guis_session.

    FIELD-SYMBOLS: <ls_session_row> LIKE LINE OF gt_sessions_list.

    READ TABLE gt_sessions_list INDEX row ASSIGNING <ls_session_row>.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    IF <ls_session_row>-is_gui_scripting_enabled <> abap_true.
      MESSAGE i015 WITH <ls_session_row>-connection_name.
      RETURN.
    ENDIF.

    IF <ls_session_row>-busy = abap_true.
      MESSAGE i016.
      RETURN.
    ENDIF.

    lo_session = go_model->get_session_by_id( <ls_session_row>-session_id ).

    MESSAGE |all ok { lo_session->get_name( ) }| TYPE 'I'.
  ENDMETHOD.
ENDCLASS.
