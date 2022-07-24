class ZCL_GUIS_UTILS definition
  public
  create public .

public section.

  class-data DUMMY type STRING .

  class-methods RAISE_IF_OLE_OBJECT_EMPTY
    importing
      !I_OLE_OBJECT type OLE2_OBJECT
      !IV_PROPERTY_NAME type CLIKE optional
      !IV_ADD_DESCRIPTION_OF_ERROR type CLIKE optional
    raising
      ZCX_GUIS_ERROR .
  class-methods BOOLEAN_NOT
    importing
      !IV_BOOLEAN type ABAP_BOOL
    returning
      value(RV_RESULT) type ABAP_BOOL .
  class-methods RAISE_EXCEPTION_FROM_SY_MSG
    importing
      value(IV_MSGID) type SYMSGID default SY-MSGID
      value(IV_MSGNO) type SYMSGNO default SY-MSGNO
      value(IV_MSGV1) type SYMSGV default SY-MSGV1
      value(IV_MSGV2) type SYMSGV default SY-MSGV2
      value(IV_MSGV3) type SYMSGV default SY-MSGV3
      value(IV_MSGV4) type SYMSGV default SY-MSGV4
    raising
      ZCX_GUIS_ERROR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GUIS_UTILS IMPLEMENTATION.


  method BOOLEAN_NOT.
    IF iv_boolean = abap_true.
      rv_result = abap_false.
    ELSE.
      rv_result = abap_true.
    ENDIF.
  endmethod.


  METHOD raise_exception_from_sy_msg.

    DATA: ls_t100_key LIKE if_t100_message=>t100key.

    ls_t100_key-msgid = iv_msgid.
    ls_t100_key-msgno = iv_msgno.
    ls_t100_key-attr1 = iv_msgv1.
    ls_t100_key-attr2 = iv_msgv2.
    ls_t100_key-attr3 = iv_msgv3.
    ls_t100_key-attr4 = iv_msgv4.

    RAISE EXCEPTION TYPE zcx_guis_error
      EXPORTING
        textid = ls_t100_key.
  ENDMETHOD.


  method RAISE_IF_OLE_OBJECT_EMPTY.
    IF i_ole_object IS INITIAL.
      MESSAGE e012 WITH iv_property_name iv_add_description_of_error INTO zcl_guis_utils=>dummy.
      raise_exception_from_sy_msg( ).
    ENDIF.
  endmethod.
ENDCLASS.
