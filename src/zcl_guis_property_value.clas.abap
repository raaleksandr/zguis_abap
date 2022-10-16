"! <p class="shorttext synchronized" lang="en">Property value of OLE object that can be object also</p>
CLASS zcl_guis_property_value DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized" lang="en">Property as OLE object if it has object type</p>
    DATA m_property_as_ole_object TYPE ole2_object READ-ONLY .
    "! <p class="shorttext synchronized" lang="en">Property value if it is value</p>
    DATA mv_property_value TYPE string READ-ONLY .
    "! <p class="shorttext synchronized" lang="en">Property name</p>
    DATA mv_property_name TYPE ole_verb READ-ONLY .

    "! <p class="shorttext synchronized" lang="en">Returns if the property value is object or not</p>
    METHODS is_object
      RETURNING
        VALUE(rv_is_object) TYPE abap_bool .
    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS constructor
      IMPORTING
        !i_ole_object     TYPE ole2_object
        !iv_property_name TYPE clike
      RAISING
        zcx_guis_error .
    "! <p class="shorttext synchronized" lang="en">Returns property value as string</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS get_value_as_string
      RETURNING
        VALUE(rv_property_value) TYPE string
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns property value as abap bool</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS get_value_as_bool
      RETURNING
        VALUE(rv_property_value) TYPE abap_bool
      RAISING
        zcx_guis_error .

    "! <p class="shorttext synchronized" lang="en">Returns property value as abap object</p>
    "!
    "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
    METHODS get_value_as_object
      RETURNING
        VALUE(ro_value_as_object) TYPE REF TO zcl_guis_ole_object
      RAISING
        zcx_guis_error .
  PROTECTED SECTION.
  PRIVATE SECTION.

    "! <p class="shorttext synchronized" lang="en">Flag that the property is object</p>
    DATA mv_is_object TYPE abap_bool .
ENDCLASS.



CLASS zcl_guis_property_value IMPLEMENTATION.


  METHOD constructor.
    DATA: lv_property_name         TYPE ole_verb,
          ls_property_value_as_ole TYPE ole2_object.

    zcl_guis_utils=>raise_if_ole_object_empty( i_ole_object     = i_ole_object
                                               iv_property_name = iv_property_name ).

    mv_property_name = lv_property_name = iv_property_name.
    GET PROPERTY OF i_ole_object lv_property_name = ls_property_value_as_ole.
    IF ls_property_value_as_ole-type = 'OLE2'.
      mv_is_object = abap_true.
      m_property_as_ole_object = ls_property_value_as_ole.
    ELSE.
      GET PROPERTY OF i_ole_object lv_property_name = mv_property_value.
    ENDIF.
  ENDMETHOD.


  METHOD get_value_as_string.

    IF is_object( ) = abap_true.
      MESSAGE e011 WITH mv_property_name INTO zcl_guis_utils=>dummy.
      zcl_guis_utils=>raise_exception_from_sy_msg( ).
    ENDIF.
    rv_property_value = mv_property_value.
  ENDMETHOD.

  METHOD get_value_as_bool.
    IF is_object( ) = abap_true.
      MESSAGE e011 WITH mv_property_name INTO zcl_guis_utils=>dummy.
      zcl_guis_utils=>raise_exception_from_sy_msg( ).
    ENDIF.
    IF mv_property_value = '1'.
      rv_property_value = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD get_value_as_object.
    IF is_object( ) <> abap_true.
      MESSAGE e013 WITH mv_property_name INTO zcl_guis_utils=>dummy.
      zcl_guis_utils=>raise_exception_from_sy_msg( ).
    ENDIF.

    CREATE OBJECT ro_value_as_object
      EXPORTING
        i_ole_object = m_property_as_ole_object.
  ENDMETHOD.

  METHOD is_object.
    rv_is_object = mv_is_object.
  ENDMETHOD.
ENDCLASS.

