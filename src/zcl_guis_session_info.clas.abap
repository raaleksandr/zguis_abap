"! <p class="shorttext synchronized" lang="en">Session info object of GUI Scripting</p>
class ZCL_GUIS_SESSION_INFO definition
  public
  inheriting from ZCL_GUIS_OLE_OBJECT
  create public .

public section.

    "! <p class="shorttext synchronized" lang="en">Returns name of application server</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods APPLICATION_SERVER
    returning
      value(RV_APPLICATION_SERVER) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns client number of session (mandant)</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods CLIENT
    returning
      value(RV_CLIENT) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns code page of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods CODEPAGE
    returning
      value(RV_CODEPAGE) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns language of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods LANGUAGE
    returning
      value(RV_LANGUAGE) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns name of message server of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods MESSAGE_SERVER
    returning
      value(RV_MESSAGE_SERVER) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns name of program opened in session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods PROGRAM
    returning
      value(RV_PROGRAM) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns screen number opened in session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods SCREEN_NUMBER
    returning
      value(RV_SCREEN_NUMBER) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns scripting mode read flag of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods SCRIPTING_MODE_READ_ONLY
    returning
      value(RV_SCRIPTING_MODE_READ_ONLY) type ABAP_BOOL
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns scripting mode recording flag of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods SCRIPTING_MODE_RECORD_DISABLED
    returning
      value(RV_SCRIPTING_MODE_REC_DISABLED) type ABAP_BOOL
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns session number</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods SESSION_NUMBER
    returning
      value(RV_SESSION_NUMBER) type INT4
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns system name of session (SID)</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods SYSTEM_NAME
    returning
      value(RV_SYSTEM_NAME) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns session unique id</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods SYSTEM_SESSION_ID
    returning
      value(RV_SYSTEM_SESSION_ID) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns transaction opened in session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods TRANSACTION
    returning
      value(RV_TRANSACTION) type STRING
    raising
      ZCX_GUIS_ERROR .
    "! <p class="shorttext synchronized" lang="en">Returns user of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods USER
    returning
      value(RV_USER) type STRING
    raising
      ZCX_GUIS_ERROR .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GUIS_SESSION_INFO IMPLEMENTATION.


  METHOD application_server.
    rv_application_server = get_property_value_as_string( 'ApplicationServer' ).
  ENDMETHOD.


  METHOD client.
    rv_client = get_property_value_as_string( 'Client' ).
  ENDMETHOD.


  METHOD codepage.
    rv_codepage = get_property_value_as_string( 'Codepage' ).
  ENDMETHOD.


  METHOD language.
    rv_language = get_property_value_as_string( 'Language' ).
  ENDMETHOD.


  METHOD message_server.
    rv_message_server = get_property_value_as_string( 'MessageServer' ).
  ENDMETHOD.


  METHOD program.
    rv_program = get_property_value_as_string( 'Program' ).
  ENDMETHOD.


  METHOD screen_number.
    rv_screen_number = get_property_value_as_string( 'ScreenNumber' ).
  ENDMETHOD.


  METHOD scripting_mode_read_only.
    rv_scripting_mode_read_only = get_property_value_as_bool( 'ScriptingModeReadOnly' ).
  ENDMETHOD.


  METHOD scripting_mode_record_disabled.
    rv_scripting_mode_rec_disabled = get_property_value_as_bool( 'ScriptingModeRecordingDisabled' ).
  ENDMETHOD.


  METHOD session_number.
    rv_session_number = get_property_value_as_string( 'SessionNumber' ).
  ENDMETHOD.


  METHOD system_name.
    rv_system_name = get_property_value_as_string( 'SystemName' ).
  ENDMETHOD.


  METHOD system_session_id.
    rv_system_session_id = get_property_value_as_string( 'SystemSessionId' ).
  ENDMETHOD.


  METHOD transaction.
    rv_transaction = get_property_value_as_string( 'Transaction' ).
  ENDMETHOD.


  METHOD user.
    rv_user = get_property_value_as_string( 'User' ).
  ENDMETHOD.
ENDCLASS.
