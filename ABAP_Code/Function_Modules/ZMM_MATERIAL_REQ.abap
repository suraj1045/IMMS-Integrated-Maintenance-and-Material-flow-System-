
* FUNCTION MODULE : ZMM_MATERIAL_REQ
* PURPOSE         : Create Purchase Requisition for IMMS
* MODULE          : MM (Materials Management)
* AUTHOR          : Suraj V
* DATE            : Nov 2025

FUNCTION ZMM_MATERIAL_REQ.

*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_REQID) TYPE ZREQ_ID
*"  EXPORTING
*"     VALUE(EV_PR_NO) TYPE BANFN
*"  TABLES
*"     RETURN STRUCTURE BAPIRET2

  DATA: ls_pr_header TYPE bapimereqheader,
        lt_pr_items  TYPE TABLE OF bapimereqitemimp,
        lt_return    TYPE TABLE OF bapiret2.

  "Fetch request details
  SELECT SINGLE * FROM zmaint_req INTO @DATA(ls_req)
    WHERE req_id = @iv_reqid.

  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  ls_pr_header-pr_type = 'NB'. "Standard Purchase Requisition

  APPEND VALUE #( 
    material = ls_req-part_no
    quantity = ls_req-qty
    plant    = ls_req-plant
    stor_loc = ls_req-stor_loc
    deliv_date = sy-datum + 7
    preq_name = sy-uname
  ) TO lt_pr_items.

  CALL FUNCTION 'BAPI_PR_CREATE'
    EXPORTING
      prheader = ls_pr_header
    TABLES
      pritems  = lt_pr_items
      return   = lt_return.

  READ TABLE lt_return WITH KEY type = 'S' INTO DATA(ls_ret).
  IF sy-subrc = 0.
    ev_pr_no = ls_ret-message_v2. "PR Number returned
    UPDATE zmaint_req SET pr_no = ev_pr_no status = 'PR_CREATED'
      WHERE req_id = iv_reqid.
    COMMIT WORK.
  ELSE.
    return[] = lt_return.
  ENDIF.

ENDFUNCTION.
