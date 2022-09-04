"! <p class="shorttext synchronized" lang="en">Session info object of GUI Scripting</p>
CLASS zcl_guis_session_info DEFINITION
  PUBLIC
  INHERITING FROM zcl_guis_ole_object
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized" lang="en">Returns name of application server</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS application_server
      RETURNING
        VALUE(rv_application_server) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns client number of session (mandant)</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS client
      RETURNING
        VALUE(rv_client) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns code page of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS codepage
      RETURNING
        VALUE(rv_codepage) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns language of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS language
      RETURNING
        VALUE(rv_language) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns name of message server of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS message_server
      RETURNING
        VALUE(rv_message_server) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns name of program opened in session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS program
      RETURNING
        VALUE(rv_program) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns screen number opened in session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS screen_number
      RETURNING
        VALUE(rv_screen_number) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns scripting mode read flag of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS scripting_mode_read_only
      RETURNING
        VALUE(rv_scripting_mode_Read_only) TYPE abap_bool
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns scripting mode recording flag of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS scripting_mode_record_disabled
      RETURNING
        VALUE(rv_scripting_mode_rec_disabled) TYPE abap_bool
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns session number</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS session_number
      RETURNING
        VALUE(rv_session_number) TYPE int4
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns system name of session (SID)</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS system_name
      RETURNING
        VALUE(rv_system_name) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns session unique id</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS system_session_id
      RETURNING
        VALUE(rv_system_session_id) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns transaction opened in session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS transaction
      RETURNING
        VALUE(rv_transaction) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns user of session</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS user
      RETURNING
        VALUE(rv_user) TYPE string
      RAISING
        zcx_guis_error .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_guis_session_info IMPLEMENTATION.

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
