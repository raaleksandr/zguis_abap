class ZCL_GUIS_OLE_OBJECT definition
  public
  create protected .

public section.

  data M_OLE_OBJECT type OLE2_OBJECT read-only .

  methods GET_NAME
    returning
      value(RV_NAME) type STRING
    raising
      ZCX_GUIS_ERROR .
  methods GET_PROPERTY_VALUE_AS_STRING
    importing
      !IV_PROPERTY_NAME type CLIKE
    returning
      value(RV_PROPERTY_VALUE) type STRING
    raising
      ZCX_GUIS_ERROR .
  methods GET_TYPE
    returning
      value(RV_TYPE) type STRING
    raising
      ZCX_GUIS_ERROR .
  methods CONSTRUCTOR
    importing
      !I_OLE_OBJECT type OLE2_OBJECT .
protected section.

  methods GET_PROPERTY_VALUE
    importing
      !IV_PROPERTY_NAME type CLIKE
    returning
      value(RO_PROPERTY_VALUE) type ref to ZCL_GUIS_PROPERTY_VALUE
    raising
      ZCX_GUIS_ERROR .
private section.

  types:
    BEGIN OF TY_PROPERTY_OF_OLE_OBJECT ,
     type TYPE rstxtmd,
     property TYPE string,
    END OF ty_property_of_ole_object .

  class-data:
    MT_PROPERTIES_TABLE   TYPE SORTED TABLE OF ty_property_of_ole_object
    WITH NON-UNIQUE KEY type .
  class-data MV_CURRENT_TYPE_FOR_PROP_FILL type RSTXTMD .

  class-methods _FILL_FOR_GUI_APPLICATION .
  class-methods _FILL_FOR_GUI_CONNECTION .
  class-methods _START_FILL_PROPERTIES_OF_TYPE
    importing
      !IV_TYPE type CLIKE .
  class-methods _P
    importing
      !IV_PROPERTY_NAME type CLIKE .
  class-methods _FILL_FOR_GUI_USER_AREA .
  class-methods _FILL_FOR_GUI_TOOLBAR .
  class-methods _FILL_FOR_GUI_TITLEBAR .
  class-methods _FILL_FOR_GUI_TEXT_FIELD .
  class-methods _FILL_FOR_GUI_STATUS_PANE .
  class-methods _FILL_FOR_GUI_STATUSBAR .
  class-methods _FILL_FOR_GUI_SESSION .
  class-methods _FILL_FOR_GUI_OK_CODE_FIELD .
  class-methods _FILL_FOR_GUI_MENU .
  class-methods _FILL_FOR_GUI_MAIN_WINDOW .
  class-methods _FILL_FOR_GUI_CTEXT_FIELD .
  class-methods _FILL_FOR_GUI_CONTEXT_MENU .
  class-methods _FILL_FOR_GUI_COMP_COLLECTION .
  class-methods _FILL_FOR_GUI_COLLECTION .
  class-methods _FILL_FOR_GUI_CHECK_BOX .
  class-methods _FILL_FOR_GUI_BUTTON .
  class-methods _FILL_FOR_GUI_BOX .
  class-methods _ADD_NEW_PROPERTY_TO_CURR_TYPE
    importing
      !IV_PROPERTY_NAME type CLIKE .
  class-methods _FILL_FOR_GUI_MENUBAR .
  class-methods _FILL_PROPERTY_LIST .
ENDCLASS.



CLASS ZCL_GUIS_OLE_OBJECT IMPLEMENTATION.


  method CONSTRUCTOR.
    m_ole_object = i_ole_object.
  endmethod.


  method GET_NAME.
    rv_name = get_property_value_as_string( 'Name' ).
  endmethod.


  method GET_PROPERTY_VALUE.
    CREATE OBJECT ro_property_value
      EXPORTING
        i_ole_object     = m_ole_object
        iv_property_name = iv_property_name.
  endmethod.


  method GET_PROPERTY_VALUE_AS_STRING.
    DATA: lo_property_value TYPE REF TO zcl_guis_property_value.

    lo_property_value = get_property_value( iv_property_name ).
    rv_property_value = lo_property_value->get_value_as_string( ).
  endmethod.


  method GET_TYPE.
    rv_type = get_property_value_as_string( 'Type' ).
  endmethod.


  method _ADD_NEW_PROPERTY_TO_CURR_TYPE.
    DATA: ls_property TYPE ty_property_of_ole_object.

    ls_property-type     = mv_current_type_for_prop_fill.
    ls_property-property = iv_property_name.
    INSERT ls_property INTO TABLE mt_properties_table.
  endmethod.


  method _FILL_FOR_GUI_APPLICATION.
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
  endmethod.


  method _FILL_FOR_GUI_BOX.
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
  endmethod.


  method _FILL_FOR_GUI_BUTTON.
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
  endmethod.


  method _FILL_FOR_GUI_CHECK_BOX.
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
  endmethod.


  method _FILL_FOR_GUI_COLLECTION.
    _start_fill_properties_of_type( 'GuiCollection' ).
    _p( 'Count' ).
    _p( 'Length' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
  endmethod.


  method _FILL_FOR_GUI_COMP_COLLECTION.
    _start_fill_properties_of_type( 'GuiComponentCollection' ).
    _p( 'Count' ).
    _p( 'Length' ).
    _p( 'Type' ).
    _p( 'TypeAsNumber' ).
  endmethod.


  method _FILL_FOR_GUI_CONNECTION.
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
  endmethod.


  method _FILL_FOR_GUI_CONTEXT_MENU.
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
  endmethod.


  method _FILL_FOR_GUI_CTEXT_FIELD.
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
  endmethod.


  method _FILL_FOR_GUI_MAIN_WINDOW.
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

  endmethod.


  method _FILL_FOR_GUI_MENU.
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
  endmethod.


  method _FILL_FOR_GUI_MENUBAR.
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
  endmethod.


  method _FILL_FOR_GUI_OK_CODE_FIELD.
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
  endmethod.


  method _FILL_FOR_GUI_SESSION.
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
  endmethod.


  method _FILL_FOR_GUI_STATUSBAR.
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
  endmethod.


  method _FILL_FOR_GUI_STATUS_PANE.
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
  endmethod.


  method _FILL_FOR_GUI_TEXT_FIELD.
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
  endmethod.


  method _FILL_FOR_GUI_TITLEBAR.
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
  endmethod.


  method _FILL_FOR_GUI_TOOLBAR.
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
  endmethod.


  method _FILL_FOR_GUI_USER_AREA.
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
  endmethod.


  method _FILL_PROPERTY_LIST.

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
  endmethod.


  method _P.
    _add_new_property_to_curr_type( iv_property_name ).
  endmethod.


  method _START_FILL_PROPERTIES_OF_TYPE.
    mv_current_type_for_prop_fill = iv_type.
  endmethod.
ENDCLASS.
