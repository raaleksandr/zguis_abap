"! <p class="shorttext synchronized" lang="en">Ole object of SAP Gui Scriptin object model</p>
class ZCL_GUIS_OLE_OBJECT definition
  public
  create protected .

public section.

    "! <p class="shorttext synchronized" lang="en">Handle of OLE-object of class</p>
  data M_OLE_OBJECT type OLE2_OBJECT read-only .

    "! <p class="shorttext synchronized" lang="en">Returns object name</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods GET_NAME
    returning
      value(RV_NAME) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns value of property as string(for non-object property)</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods GET_PROPERTY_VALUE_AS_STRING
    importing
      !IV_PROPERTY_NAME type CLIKE
    returning
      value(RV_PROPERTY_VALUE) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns value of property as abap bool(for non-object proper</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods GET_PROPERTY_VALUE_AS_BOOL
    importing
      !IV_PROPERTY_NAME type CLIKE
    returning
      value(RV_PROPERTY_VALUE) type ABAP_BOOL
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns object type</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods GET_TYPE
    returning
      value(RV_TYPE) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns object id</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods GET_ID
    returning
      value(RV_ID) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Finds child object by Id and returns instance</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods FIND_BY_ID
    importing
      !IV_ID type CLIKE
    returning
      value(RO_FOUND_OBJECT) type ref to ZCL_GUIS_OLE_OBJECT
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    "!
    "! @parameter i_ole_object | <p class="shorttext synchronized" lang="en">Instance will be created based on this OLE-object</p>
  methods CONSTRUCTOR
    importing
      !I_OLE_OBJECT type OLE2_OBJECT .
  PROTECTED SECTION.

    "! <p class="shorttext synchronized" lang="en">Returns special property value object for property name</p>
    "!
    "! @parameter ro_property_value | <p class="shorttext synchronized" lang="en">Property value of OLE object that can be object also</p>
    "! @raising   zcx_guis_error    | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS get_property_value
      IMPORTING
        !iv_property_name        TYPE clike
      RETURNING
        VALUE(ro_property_value) TYPE REF TO zcl_guis_property_value
      RAISING
        zcx_guis_error .
  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_property_of_ole_object ,
        type     TYPE rstxtmd,
        property TYPE string,
      END OF ty_property_of_ole_object .

    CLASS-DATA:
      mt_properties_table   TYPE SORTED TABLE OF ty_property_of_ole_object
      WITH NON-UNIQUE KEY type .
    "! <p class="shorttext synchronized" lang="en">Medium description</p>
    CLASS-DATA mv_current_type_for_prop_fill TYPE rstxtmd .

    "! <p class="shorttext synchronized" lang="en">Fills properties for GuiApplication OLE object</p>
    CLASS-METHODS _fill_for_gui_application .
    "! <p class="shorttext synchronized" lang="en">Fill properties of GuiConnection OLE Object</p>
    CLASS-METHODS _fill_for_gui_connection .
    "! <p class="shorttext synchronized" lang="en">Sets global var which object property we will fill</p>
    "!
    "! @parameter iv_type | <p class="shorttext synchronized" lang="en">Name of type</p>
    CLASS-METHODS _start_fill_properties_of_type
      IMPORTING
        !iv_type TYPE clike .
    "! <p class="shorttext synchronized" lang="en">Adds new property to current type</p>
    CLASS-METHODS _p
      IMPORTING
        !iv_property_name TYPE clike .
    "! <p class="shorttext synchronized" lang="en">Fills properties for GuiUserArea OLE object type</p>
    CLASS-METHODS _fill_for_gui_user_area .
    "! <p class="shorttext synchronized" lang="en">Fill property list for GUI Toolbar OLE object</p>
    CLASS-METHODS _fill_for_gui_toolbar .
    "! <p class="shorttext synchronized" lang="en">Fills property list for GuiTitlebar OLE object type</p>
    CLASS-METHODS _fill_for_gui_titlebar .
    "! <p class="shorttext synchronized" lang="en">Fills properties of 'GuiTextField' OLE object</p>
    CLASS-METHODS _fill_for_gui_text_field .
    "! <p class="shorttext synchronized" lang="en">Fills properties for GuiStatusPane OLE object</p>
    CLASS-METHODS _fill_for_gui_status_pane .
    "! <p class="shorttext synchronized" lang="en">Fills properties of OLE object type 'GuiStatusbar'</p>
    CLASS-METHODS _fill_for_gui_statusbar .
    "! <p class="shorttext synchronized" lang="en">Fills list of properties for gui session</p>
    CLASS-METHODS _fill_for_gui_session .
    "! <p class="shorttext synchronized" lang="en">Fills property list for 'GuiOkCodeField' OLE object type</p>
    CLASS-METHODS _fill_for_gui_ok_code_field .
    "! <p class="shorttext synchronized" lang="en">Fills property list for OLE object type 'GuiMenu'</p>
    CLASS-METHODS _fill_for_gui_menu .
    "! <p class="shorttext synchronized" lang="en">Fills property list for GuiMainWindow OLE object</p>
    CLASS-METHODS _fill_for_gui_main_window .
    "! <p class="shorttext synchronized" lang="en">Fills properties of 'GuiCTextField' OLE object type</p>
    CLASS-METHODS _fill_for_gui_ctext_field .
    "! <p class="shorttext synchronized" lang="en">Fills property list for GuiContextMenu OLE object type</p>
    CLASS-METHODS _fill_for_gui_context_menu .
    "! <p class="shorttext synchronized" lang="en">Fills properties for GuiComponentCollection OLE object type</p>
    CLASS-METHODS _fill_for_gui_comp_collection .
    "! <p class="shorttext synchronized" lang="en">Fills properties for GuiCollection OLE object type</p>
    CLASS-METHODS _fill_for_gui_collection .
    "! <p class="shorttext synchronized" lang="en">Fills properties of GuiCheckBox OLE object type</p>
    CLASS-METHODS _fill_for_gui_check_box .
    "! <p class="shorttext synchronized" lang="en">Fills properties of OLE object type 'GuiButton'</p>
    CLASS-METHODS _fill_for_gui_button .
    "! <p class="shorttext synchronized" lang="en">Fills properties of GuiBox OLE object type</p>
    CLASS-METHODS _fill_for_gui_box .
    "! <p class="shorttext synchronized" lang="en">Adds new property to currently selected type</p>
    CLASS-METHODS _add_new_property_to_curr_type
      IMPORTING
        !iv_property_name TYPE clike .
    "! <p class="shorttext synchronized" lang="en">Fills property list for GuiMenubar OLE object</p>
    CLASS-METHODS _fill_for_gui_menubar .
    "! <p class="shorttext synchronized" lang="en">Fill static list of properties by OLE object type</p>
    CLASS-METHODS _fill_property_list .
ENDCLASS.



CLASS ZCL_GUIS_OLE_OBJECT IMPLEMENTATION.


  METHOD constructor.
    m_ole_object = i_ole_object.
  ENDMETHOD.


  METHOD find_by_id.

    DATA: l_found_ole_object TYPE ole2_object,
          lv_id              TYPE string.

    lv_id = iv_id.
    CALL METHOD OF m_ole_object 'findById' = l_found_ole_object
      EXPORTING
        #1 = lv_id.

    IF l_found_ole_object IS NOT INITIAL.
      CREATE OBJECT ro_found_object
        EXPORTING
          i_ole_object = l_found_ole_object.
    ELSE.
      MESSAGE e014 WITH iv_id INTO zcl_guis_utils=>dummy.
      zcl_guis_utils=>raise_exception_from_sy_msg( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_id.
    rv_id = get_property_value_as_string( 'Id' ).
  ENDMETHOD.


  METHOD get_name.
    rv_name = get_property_value_as_string( 'Name' ).
  ENDMETHOD.


  METHOD get_property_value.
    CREATE OBJECT ro_property_value
      EXPORTING
        i_ole_object     = m_ole_object
        iv_property_name = iv_property_name.
  ENDMETHOD.


  METHOD get_property_value_as_bool.
    DATA: lo_property_value TYPE REF TO zcl_guis_property_value.

    lo_property_value = get_property_value( iv_property_name ).
    rv_property_value = lo_property_value->get_value_as_bool( ).
  ENDMETHOD.


  METHOD get_property_value_as_string.
    DATA: lo_property_value TYPE REF TO zcl_guis_property_value.

    lo_property_value = get_property_value( iv_property_name ).
    rv_property_value = lo_property_value->get_value_as_string( ).
  ENDMETHOD.


  METHOD get_type.
    rv_type = get_property_value_as_string( 'Type' ).
  ENDMETHOD.


  METHOD _add_new_property_to_curr_type.
    DATA: ls_property TYPE ty_property_of_ole_object.

    ls_property-type     = mv_current_type_for_prop_fill.
    ls_property-property = iv_property_name.
    INSERT ls_property INTO TABLE mt_properties_table.
  ENDMETHOD.


  METHOD _fill_for_gui_application.
    _start_fill_properties_of_type( 'GuiApplication' ).
    _p( 'ActiveSession' ).
    _p( 'AllowSystemMessages' ).
    _p( 'ButtonbarVisible' ).
    _p( 'Children' ).
    _p( 'ConnectionErrorText' ).
    _p( 'Connections' ).
    _p( 'ContainerType' ).
    _p( 'HistoryEnabled' ).
    _p( 'Id' ).
    _p( 'Inplace' ).
    _p( 'MajorVersion' ).
    _p( 'MinorVersion' ).
    _p( 'Name' ).
    _p( 'NewVisualDesign' ).
    _p( 'Parent' ).
    _p( 'Patchlevel' ).
    _p( 'Revision' ).
    _p( 'StatusbarVisible' ).
    _p( 'TitlebarVisible' ).
    _p( 'ToolbarVisible' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Utils' ).
    _p( 'WDSessions' ).
  ENDMETHOD.


  METHOD _fill_for_gui_box.
    _start_fill_properties_of_type( 'GuiBox' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'CharHeight' ).
    _p( 'CharLeft' ).
    _p( 'CharTop' ).
    _p( 'CharWidth' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_button.
    _start_fill_properties_of_type( 'GuiButton' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'CharHeight' ).
    _p( 'CharLeft' ).
    _p( 'CharTop' ).
    _p( 'CharWidth' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Emphasized' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'LeftLabel' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'RightLabel' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_check_box.
    _start_fill_properties_of_type( 'GuiCheckBox' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'CharHeight' ).
    _p( 'CharLeft' ).
    _p( 'CharTop' ).
    _p( 'CharWidth' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Flushing' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsLeftLabel' ).
    _p( 'IsListElement' ).
    _p( 'IsRightLabel' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'LeftLabel' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'RightLabel' ).
    _p( 'RowText' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_collection.
    _start_fill_properties_of_type( 'GuiCollection' ).
    _p( 'Count' ).
    _p( 'Length' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
  ENDMETHOD.


  METHOD _fill_for_gui_comp_collection.
    _start_fill_properties_of_type( 'GuiComponentCollection' ).
    _p( 'Count' ).
    _p( 'Length' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
  ENDMETHOD.


  METHOD _fill_for_gui_connection.
    _start_fill_properties_of_type( 'GuiConnection' ).
    _p( 'Children' ).
    _p( 'ChildrenForNWBC' ).
    _p( 'ConnectionString' ).
    _p( 'ContainerType' ).
    _p( 'Description' ).
    _p( 'DisabledByServer' ).
    _p( 'Id' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'Sessions' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
  ENDMETHOD.


  METHOD _fill_for_gui_context_menu.
    _start_fill_properties_of_type( 'GuiContextMenu' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_ctext_field.
    _start_fill_properties_of_type( 'GuiCTextField' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'CaretPosition' ).
    _p( 'Changeable' ).
    _p( 'CharHeight' ).
    _p( 'CharLeft' ).
    _p( 'CharTop' ).
    _p( 'CharWidth' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'DisplayedText' ).
    _p( 'Height' ).
    _p( 'Highlighted' ).
    _p( 'HistoryCurEntry' ).
    _p( 'HistoryCurIndex' ).
    _p( 'HistoryIsActive' ).
    _p( 'HistoryList' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsHotspot' ).
    _p( 'IsLeftLabel' ).
    _p( 'IsOField' ).
    _p( 'IsRightLabel' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'LeftLabel' ).
    _p( 'MaxLength' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Numerical' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'Required' ).
    _p( 'RightLabel' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_main_window.
    _start_fill_properties_of_type( 'GuiMainWindow' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'ButtonbarVisible' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContainerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'ElementVisualizationMode' ).
    _p( 'GuiFocus' ).
    _p( 'Handle' ).
    _p( 'Height' ).
    _p( 'Iconic' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'StatusbarVisible' ).
    _p( 'SystemFocus' ).
    _p( 'Text' ).
    _p( 'TitlebarVisible' ).
    _p( 'ToolbarVisible' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
    _p( 'WorkingPaneHeight' ).
    _p( 'WorkingPaneWidth' ).

  ENDMETHOD.


  METHOD _fill_for_gui_menu.
    _start_fill_properties_of_type( 'GuiMenu' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_menubar.
    _start_fill_properties_of_type( 'GuiMenubar' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContainerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_ok_code_field.
    _start_fill_properties_of_type( 'GuiOkCodeField' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Opened' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_session.
    _start_fill_properties_of_type( 'GuiSession' ).
    _p( 'AccEnhancedTabChain' ).
    _p( 'AccSymbolReplacement' ).
    _p( 'ActiveWindow' ).
    _p( 'Busy' ).
    _p( 'Children' ).
    _p( 'ContainerType' ).
    _p( 'ErrorList' ).
    _p( 'Id' ).
    _p( 'Info' ).
    _p( 'IsActive' ).
    _p( 'IsListBoxActive' ).
    _p( 'ListBoxCurrEnty' ).
    _p( 'ListBoxCurrEntryLeft' ).
    _p( 'ListBoxCurrEntryTop' ).
    _p( 'ListBoxCurrEntryWidth' ).
    _p( 'ListBoxHeight' ).
    _p( 'ListBoxLeft' ).
    _p( 'ListBoxTop' ).
    _p( 'ListBoxWidth' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'PassportPreSystemId' ).
    _p( 'PassportSystemId' ).
    _p( 'PassportTransactionId' ).
    _p( 'ProgressPercent' ).
    _p( 'ProgressText' ).
    _p( 'Record' ).
    _p( 'RecordFile' ).
    _p( 'SaveAsUnicode' ).
    _p( 'ShowDropdownKeys' ).
    _p( 'SuppressBackendPopups' ).
    _p( 'TestToolMode' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
  ENDMETHOD.


  METHOD _fill_for_gui_statusbar.
    _start_fill_properties_of_type( 'GuiStatusbar' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Handle' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'MessageAsPopup' ).
    _p( 'MessageHasLongText' ).
    _p( 'MessageId' ).
    _p( 'MessageNumber' ).
    _p( 'MessageType' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_status_pane.
    _start_fill_properties_of_type( 'GuiStatusPane' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_text_field.
    _start_fill_properties_of_type( 'GuiTextField' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'CaretPosition' ).
    _p( 'Changeable' ).
    _p( 'CharHeight' ).
    _p( 'CharLeft' ).
    _p( 'CharTop' ).
    _p( 'CharWidth' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'DisplayedText' ).
    _p( 'Height' ).
    _p( 'Highlighted' ).
    _p( 'HistoryCurEntry' ).
    _p( 'HistoryCurIndex' ).
    _p( 'HistoryIsActive' ).
    _p( 'HistoryList' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsHotspot' ).
    _p( 'IsLeftLabel' ).
    _p( 'IsListElement' ).
    _p( 'IsOField' ).
    _p( 'IsRightLabel' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'LeftLabel' ).
    _p( 'MaxLength' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'Numerical' ).
    _p( 'Parent' ).
    _p( 'ParentFrame' ).
    _p( 'Required' ).
    _p( 'RightLabel' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_titlebar.
    _start_fill_properties_of_type( 'GuiTitlebar' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_toolbar.
    _start_fill_properties_of_type( 'GuiToolbar' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContanerType' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_for_gui_user_area.
    _start_fill_properties_of_type( 'GuiUserArea' ).
    _p( 'AccLabelCollection' ).
    _p( 'AccText' ).
    _p( 'AccTextOnRequest' ).
    _p( 'AccTooltip' ).
    _p( 'Changeable' ).
    _p( 'Children' ).
    _p( 'ContanerType' ).
    _p( 'CurrentContextMenu' ).
    _p( 'DefaultTooltip' ).
    _p( 'Height' ).
    _p( 'HorizontalScrollbar' ).
    _p( 'IconName' ).
    _p( 'Id' ).
    _p( 'IsSymbolFont' ).
    _p( 'Left' ).
    _p( 'Modified' ).
    _p( 'Name' ).
    _p( 'ParentFrame' ).
    _p( 'ScreenLeft' ).
    _p( 'ScreenTop' ).
    _p( 'Text' ).
    _p( 'Tooltip' ).
    _p( 'Top' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
    _p( 'VerticalScrollBar' ).
    _p( 'Width' ).
  ENDMETHOD.


  METHOD _fill_property_list.

    IF mt_properties_table[] IS NOT INITIAL.
      RETURN.
    ENDIF.

    _fill_for_gui_application( ).
    _fill_for_gui_connection( ).
    _fill_for_gui_session( ).
    _fill_for_gui_main_window( ).
    _fill_for_gui_menubar( ).
    _fill_for_gui_toolbar( ).
    _fill_for_gui_titlebar( ).
    _fill_for_gui_statusbar( ).
    _fill_for_gui_user_area( ).
    _fill_for_gui_menu( ).
    _fill_for_gui_button( ).
    _fill_for_gui_ok_code_field( ).
    _fill_for_gui_box( ).
    _fill_for_gui_text_field( ).
    _fill_for_gui_ctext_field( ).
    _fill_for_gui_check_box( ).
    _fill_for_gui_context_menu( ).
    _fill_for_gui_status_pane( ).
    _fill_for_gui_comp_collection( ).
    _fill_for_gui_collection( ).
  ENDMETHOD.


  METHOD _p.
    _add_new_property_to_curr_type( iv_property_name ).
  ENDMETHOD.


  METHOD _start_fill_properties_of_type.
    mv_current_type_for_prop_fill = iv_type.
  ENDMETHOD.
ENDCLASS.
