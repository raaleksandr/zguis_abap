*&---------------------------------------------------------------------*
*& Report ZGUIS_EXPLORER
*&---------------------------------------------------------------------*
*& Program to explore SAP GUI Scripting sessions and elements
*&---------------------------------------------------------------------*
REPORT zguis_explorer MESSAGE-ID zguiscript_abap.

CLASS lcl_application DEFINITION DEFERRED.
CLASS lcl_controls_tree DEFINITION DEFERRED.
DATA: gv_ok_code_100 TYPE syucomm,
      gv_ok_code_200 TYPE syucomm,
      go_application TYPE REF TO lcl_application.

CLASS lcl_application DEFINITION.
  PUBLIC SECTION.

    DATA: go_model          TYPE REF TO zcl_guis_explorer_model READ-ONLY.

    METHODS:
      constructor,
      on_status_0100,
      on_user_command_0100,
      on_status_0200,
      on_user_command_0200,
      show_error IMPORTING io_error TYPE REF TO cx_root.

  PRIVATE SECTION.
    DATA: go_container_0100 TYPE REF TO cl_gui_custom_container,
          go_alv_0100       TYPE REF TO cl_salv_table,
          gt_sessions_list  TYPE zcl_guis_explorer_model=>ty_sessions,
          go_current_tree   TYPE REF TO lcl_controls_tree.

    METHODS: _prepare_alv100_before_show IMPORTING io_alv TYPE REF TO cl_salv_table
                                         RAISING   cx_salv_not_found,
      _prepare_alv100_columns IMPORTING io_alv TYPE REF TO cl_salv_table
                              RAISING   cx_salv_not_found,
      _prepare_alv100_events IMPORTING io_alv TYPE REF TO cl_salv_table,
      _main_alv_double_click FOR EVENT double_click OF cl_salv_events_table
        IMPORTING row column.
ENDCLASS.

CLASS lcl_controls_tree DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING iv_session_id TYPE clike,
      on_status,
      on_user_command,
      display.

  PRIVATE SECTION.

    TYPES: BEGIN OF ty_tree_line,
             value TYPE string,
           END OF ty_tree_line,
           BEGIN OF ty_node,
             node_key   TYPE lvc_nkey,
             ole_object TYPE REF TO zcl_guis_ole_object,
           END OF ty_node.

    DATA: gv_session_id     TYPE string,
          go_container_0200 TYPE REF TO cl_gui_custom_container,
          go_tree           TYPE REF TO cl_gui_alv_tree,
          gt_tree_data      TYPE TABLE OF ty_tree_line,
          gt_nodes          TYPE SORTED TABLE OF ty_node
                                 WITH UNIQUE KEY node_key.

    METHODS: _add_node IMPORTING VALUE(iv_parent_node_key) TYPE lvc_nkey OPTIONAL
                                 is_property TYPE zcl_guis_explorer_model=>ty_object_property
             RAISING   zcx_guis_error,
             _add_object_node IMPORTING iv_property_name          TYPE clike
                                        VALUE(iv_parent_node_key) TYPE lvc_nkey OPTIONAL
                                        io_ole_object             TYPE REF TO zcl_guis_ole_object
                              RAISING   zcx_guis_error,
      _on_expand_node  FOR EVENT expand_nc OF cl_gui_alv_tree
        IMPORTING node_key,
      _add_elementary_property_node IMPORTING VALUE(iv_parent_node_key) TYPE lvc_nkey
                                              iv_property_name          TYPE clike
                                              iv_property_value         TYPE clike
                                    RAISING   zcx_guis_error.
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
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  go_application->on_status_0200( ).
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  go_application->on_user_command_0200( ).
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
          show_error( lo_error ).
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

  METHOD on_status_0200.
    IF go_current_tree IS BOUND.
      go_current_tree->on_status( ).
    ENDIF.
  ENDMETHOD.

  METHOD on_user_command_0200.
    IF go_current_tree IS BOUND.
      go_current_tree->on_user_command( ).
    ENDIF.
  ENDMETHOD.

  METHOD show_error.

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

    lo_column = lo_columns->get_column( 'BUSY' ).
    lo_column->set_short_text( 'Busy' ).
    lo_column->set_medium_text( 'BusySess.' ).
    lo_column->set_long_text( 'Busy session' ).

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
    DATA: lo_salv_events TYPE REF TO cl_salv_events_table.

    lo_salv_events = io_alv->get_event( ).
    SET HANDLER _main_alv_double_click FOR lo_salv_events.
  ENDMETHOD.

  METHOD _main_alv_double_click.

    DATA: lo_session TYPE REF TO zcl_guis_session,
          lo_error   TYPE REF TO cx_root.

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

    TRY.
        CREATE OBJECT go_current_tree
          EXPORTING
            iv_session_id = <ls_session_row>-session_id.

        go_current_tree->display( ).
      CATCH cx_root INTO lo_error.
        show_error( lo_error ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_controls_tree IMPLEMENTATION.

  METHOD constructor.
    gv_session_id = iv_session_id.
  ENDMETHOD.

  METHOD on_status.
    SET PF-STATUS '0100'.
    SET TITLEBAR '0200'.

    IF go_container_0200 IS NOT BOUND.
      CREATE OBJECT go_container_0200
        EXPORTING
          container_name = 'CONTROLS_TREE'.
    ENDIF.

    IF go_tree IS NOT BOUND.
      CREATE OBJECT go_tree
        EXPORTING
          parent                      = go_container_0200
        EXCEPTIONS
          cntl_error                  = 1
          cntl_system_error           = 2
          create_error                = 3
          lifetime_error              = 4
          illegal_node_selection_mode = 5
          failed                      = 6
          illegal_column_name         = 7.

      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      DATA: lt_fieldcatalog TYPE lvc_t_fcat.

      FIELD-SYMBOLS: <ls_fcat> LIKE LINE OF lt_fieldcatalog.

      APPEND INITIAL LINE TO lt_fieldcatalog ASSIGNING <ls_fcat>.
      <ls_fcat>-fieldname = 'VALUE'.
      <ls_fcat>-scrtext_l = <ls_fcat>-scrtext_m = <ls_fcat>-scrtext_s = 'Value'.

      DATA: ls_hierarchy_header TYPE treev_hhdr.

      ls_hierarchy_header-heading = 'Property name'.
      ls_hierarchy_header-width = 30.

      go_tree->set_table_for_first_display( EXPORTING is_hierarchy_header = ls_hierarchy_header
                                            CHANGING it_outtab            = gt_tree_data
                                                     it_fieldcatalog      = lt_fieldcatalog ).

      SET HANDLER _on_expand_node FOR go_tree.

      DATA: lo_error TYPE REF TO cx_root.

      TRY.

          DATA: ls_session_property TYPE zcl_guis_explorer_model=>ty_object_property.

          ls_session_property = go_application->go_model->get_session_property_by_id( gv_session_id ).

          _add_node( is_property = ls_session_property ).
        CATCH cx_root INTO lo_error.
          go_application->show_error(  lo_error ).
      ENDTRY.

      go_tree->frontend_update( ).
    ENDIF.
  ENDMETHOD.

  METHOD display.
    CALL SCREEN 0200.
  ENDMETHOD.

  METHOD on_user_command.
    CASE gv_ok_code_200.
      WHEN 'BACK' OR 'EXIT' OR 'CANC'.
        LEAVE TO SCREEN 100.
    ENDCASE.

    CLEAR gv_ok_code_200.
  ENDMETHOD.

  METHOD _add_node.

    CASE is_property-is_object.
      WHEN abap_true.
        _add_object_node( iv_parent_node_key = iv_parent_node_key
                          iv_property_name   = is_property-property_name
                          io_ole_object      = is_property-property_as_object ).
      WHEN OTHERS.
        _add_elementary_property_node( iv_parent_node_key = iv_parent_node_key
                                       iv_property_name   = is_property-property_name
                                       iv_property_value  = is_property-property_value_plain ).
    ENDCASE.
  ENDMETHOD.

  METHOD _add_object_node.

    DATA: lo_collection TYPE REF TO zcl_guis_collection.

    IF io_ole_object IS NOT BOUND.
      RETURN.
    ENDIF.

    DATA: lv_node_text   TYPE lvc_value,
          lv_type        TYPE string,
          lv_name        TYPE string,
          ls_node_layout TYPE lvc_s_layn,
          ls_node        TYPE ty_node,
          ls_node_rec    TYPE ty_tree_line.

    lv_node_text = iv_property_name.
    lv_type = io_ole_object->get_type( ).
    lv_name = io_ole_object->get_name( ).
    IF lv_name IS NOT INITIAL.
      CONCATENATE lv_type lv_name INTO ls_node_rec-value SEPARATED BY `, `.
    ELSE.
      ls_node_rec-value = lv_type.
    ENDIF.

    ls_node_layout-isfolder = abap_true.
    ls_node_layout-expander = abap_true.
    go_tree->add_node( EXPORTING i_relat_node_key = iv_parent_node_key
                                 i_relationship   = cl_gui_column_tree=>relat_last_child
                                 i_node_text      = lv_node_text
                                 is_outtab_line   = ls_node_rec
                                 is_node_layout   = ls_node_layout
                       IMPORTING e_new_node_key   = ls_node-node_key ).

    ls_node-ole_object = io_ole_object.
    INSERT ls_node INTO TABLE gt_nodes.
  ENDMETHOD.

  METHOD _on_expand_node.

    DATA: lo_object_to_expand   TYPE REF TO zcl_guis_ole_object,
          lo_error              TYPE REF TO cx_root.

    FIELD-SYMBOLS: <ls_node>           LIKE LINE OF gt_nodes,
                   <ls_property>       TYPE zcl_guis_explorer_model=>ty_object_property.

    READ TABLE gt_nodes WITH TABLE KEY node_key = node_key ASSIGNING <ls_node>.
    IF sy-subrc <> 0.
      MESSAGE e018 WITH node_key DISPLAY LIKE 'I'.
      RETURN.
    ENDIF.

    IF <ls_node>-ole_object IS NOT BOUND.
      MESSAGE e018 WITH node_key DISPLAY LIKE 'I'.
      RETURN.
    ENDIF.

    lo_object_to_expand = <ls_node>-ole_object.

    DATA: lt_object_properties TYPE zcl_guis_explorer_model=>ty_object_properties.

    TRY.
        lt_object_properties = go_application->go_model->get_object_properties( lo_object_to_expand ).

        LOOP AT lt_object_properties ASSIGNING <ls_property>.

          _add_node( iv_parent_node_key = node_key
                     is_property        = <ls_property> ).
        ENDLOOP.

        go_tree->frontend_update( ).
      CATCH cx_root INTO lo_error.
        go_application->show_error( lo_error ).
    ENDTRY.
  ENDMETHOD.

  METHOD _add_elementary_property_node.
    DATA: lv_node_text TYPE lvc_value,
          ls_node_rec  TYPE ty_tree_line.

    lv_node_text      = iv_property_name.
    ls_node_rec-value = iv_property_value.

    go_tree->add_node( EXPORTING i_relat_node_key = iv_parent_node_key
                                 i_relationship   = cl_gui_column_tree=>relat_last_child
                                 i_node_text      = lv_node_text
                                 is_outtab_line   = ls_node_rec ).
  ENDMETHOD.
ENDCLASS.
