class ZCL_GUIS_VBSCRIPT_RUNNER definition
  public
  create public .

public section.

  methods GET_OBJECT
    importing
      !IV_CLASS_NAME type CLIKE
    returning
      value(R_OLE_OBJECT) type OLE2_OBJECT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GUIS_VBSCRIPT_RUNNER IMPLEMENTATION.


  method GET_OBJECT.

    CONSTANTS: crlf TYPE char2 VALUE cl_abap_char_utilities=>cr_lf.

    DATA:
      lv_vb         TYPE string,
      lo_scriptctrl TYPE obj_record,
      lv_expression TYPE string.

    lv_vb =          'Function GetObj(ClassName)'               && crlf.
    lv_vb = lv_vb && '  Dim oObj'                               && crlf.
    lv_vb = lv_vb && '  Set oObj = GetObject(ClassName)'        && crlf.
    lv_vb = lv_vb && '  If IsObject(oObj) Then'                 && crlf.
    lv_vb = lv_vb && '    Set GetObj = oObj'                    && crlf.
    lv_vb = lv_vb && '  End If'                                 && crlf.
    lv_vb = lv_vb && 'End Function'                             && crlf.

    CREATE OBJECT lo_scriptctrl 'MSScriptControl.ScriptControl'.
    CHECK sy-subrc = 0 AND lo_scriptctrl-handle <> 0 AND
      lo_scriptctrl-type = 'OLE2'.

    SET PROPERTY OF lo_scriptctrl 'AllowUI' = 1.
    SET PROPERTY OF lo_scriptctrl 'Language' = 'VBScript'.

    CALL METHOD OF lo_scriptctrl 'AddCode'
      EXPORTING
        #1 = lv_vb.
    CHECK sy-subrc = 0.

    lv_expression = 'GetObj("' && iv_class_name && '")'.
    CALL METHOD OF lo_scriptctrl 'Eval' = r_ole_object
      EXPORTING
        #1 = lv_expression.

    FREE OBJECT lo_scriptctrl.
  endmethod.
ENDCLASS.
