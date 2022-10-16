"! <p class="shorttext synchronized" lang="en">Sessions list of SAP GUI Scripting</p>
class ZCL_GUIS_SESSIONS definition
  public
  create public .

public section.

  "! <p class="shorttext synchronized" lang="en">Returns number of sessions</p>
  "!
  "! @raising   zcx_guis_error | <p class="shorttext synchronized" lang="en">GUI Scripting in ABAP General Exception Class</p>
  methods GET_COUNT
    returning
      value(RV_COUNT) type I
    raising
      ZCX_GUIS_ERROR .
  "! <p class="shorttext synchronized" lang="en">Returns first session</p>
  "!
  "! @parameter ro_object | <p class="shorttext synchronized" lang="en">Session object of GUI Scripting</p>
  methods GET_FIRST
    returning
      value(RO_OBJECT) type ref to ZCL_GUIS_SESSION
    raising
      ZCX_GUIS_ERROR .
  "! <p class="shorttext synchronized" lang="en">Returns next session</p>
  "!
  "! @parameter ro_object | <p class="shorttext synchronized" lang="en">Session object of GUI Scripting</p>
  methods GET_NEXT
    returning
      value(RO_OBJECT) type ref to ZCL_GUIS_SESSION .
  "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
  methods CONSTRUCTOR
    importing
      !I_OLE_OBJECT type OLE2_OBJECT .
protected section.
private section.

  "! <p class="shorttext synchronized" lang="en">Collection of GUI Scripting objects</p>
  data MO_COLLECTION type ref to ZCL_GUIS_COLLECTION .
ENDCLASS.



CLASS ZCL_GUIS_SESSIONS IMPLEMENTATION.


  method CONSTRUCTOR.
    CREATE OBJECT mo_collection
      EXPORTING
        i_ole_object = i_ole_object.
  endmethod.


  method GET_COUNT.
    rv_count = mo_collection->get_count( ).
  endmethod.


  method GET_FIRST.
    DATA: lo_object TYPE REF TO zcl_guis_ole_object.

    lo_object = mo_collection->get_first( ).
    IF lo_object IS BOUND.
      CREATE OBJECT ro_object
        EXPORTING
          i_ole_object = lo_object->m_ole_object.
    ENDIF.
  endmethod.


  method GET_NEXT.
    DATA: lo_object TYPE REF TO zcl_guis_ole_object.

    lo_object = mo_collection->get_next( ).
    IF lo_object IS BOUND.
      CREATE OBJECT ro_object
        EXPORTING
          i_ole_object = lo_object->m_ole_object.
    ENDIF.
  endmethod.
ENDCLASS.
