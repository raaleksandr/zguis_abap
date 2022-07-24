*&---------------------------------------------------------------------*
*& Report ZGUIS_EXPLORER
*&---------------------------------------------------------------------*
*& Program to explore SAP GUI Scripting sessions and elements
*&---------------------------------------------------------------------*
REPORT zguis_explorer.

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
          go_model          TYPE REF TO zcl_guis_explorer_model.

    METHODS: _show_error IMPORTING io_error TYPE REF TO cx_root,
             _prepare_alv100_before_show IMPORTING io_alv TYPE REF TO cl_salv_table
                                         RAISING cx_salv_not_found.
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

    DATA: lt_sessions_list TYPE zcl_guis_explorer_model=>ty_sessions,
          lo_error         TYPE REF TO cx_root.

    SET PF-STATUS '0100'.
    SET TITLEBAR '0100'.

    IF go_container_0100 IS NOT BOUND.
      CREATE OBJECT go_container_0100
        EXPORTING
          container_name = 'START_ALV'.
    ENDIF.

    IF go_alv_0100 IS NOT BOUND.

      TRY.
          lt_sessions_list = go_model->get_list_of_sessions( ).
          cl_salv_table=>factory( EXPORTING r_container  = go_container_0100
                                  IMPORTING r_salv_table = go_alv_0100
                                  CHANGING  t_table      = lt_sessions_list ).

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

    DATA: lo_columns TYPE REF TO cl_salv_columns_table,
          lo_column  TYPE REF TO cl_salv_column.

    lo_columns = io_alv->get_columns( ).
    lo_column = lo_columns->get_column( 'DESCRIPTION' ).
    lo_column->set_short_text( 'Conn.' ).
    lo_column->set_medium_text( 'Connection' ).

    lo_column = lo_columns->get_column( 'IS_GUI_SCRIPTING_ENABLED' ).
    lo_column->set_short_text( 'Enabled' ).
    lo_column->set_medium_text( 'GuiScrEnabled' ).
    lo_column->set_long_text( 'Is Gui Scripting Enabled' ).
  ENDMETHOD.
ENDCLASS.
