
* FUNCTION MODULE : ZSD_ORDER_CREATE
* PURPOSE         : Create Sales Order for Scrap/Refurbished Material
* MODULE          : SD (Sales & Distribution)
* AUTHOR          : Suraj V
* DATE            : Nov 2025

FUNCTION ZSD_ORDER_CREATE.
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_REQID) TYPE ZREQ_ID
*"  EXPORTING
*"     VALUE(EV_SO_NO) TYPE VBELN_VA
*"  TABLES
*"     RETURN STRUCTURE BAPIRET2

  DATA: ls_header  TYPE bapisdhd1,
        lt_items   TYPE TABLE OF bapisditm,
        lt_return  TYPE TABLE OF bapiret2.

  SELECT SINGLE * FROM zmaint_req INTO @DATA(ls_req)
    WHERE req_id = @iv_reqid.

  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  " Prepare Sales Order header
  ls_header-doc_type = 'OR'.    "Standard Order
  ls_header-sales_org = '1000'.
  ls_header-distr_chan = '10'.
  ls_header-division = '00'.
  ls_header-created_by = sy-uname.

  APPEND VALUE #(
    itm_number = '000010'
    material   = ls_req-part_no
    target_qty = ls_req-qty
    plant      = ls_req-plant
  ) TO lt_items.

  CALL FUNCTION 'BAPI_SALESORDER_CREATEFROMDAT2'
    EXPORTING
      order_header_in = ls_header
    TABLES
      order_items_in  = lt_items
      return          = lt_return.

  READ TABLE lt_return WITH KEY type = 'S' INTO DATA(ls_success).
  IF sy-subrc = 0.
    ev_so_no = ls_success-message_v2.
    UPDATE zscrap_sales SET so_no = ev_so_no status = 'SO_CREATED'
      WHERE req_id = iv_reqid.
    COMMIT WORK.
  ELSE.
    return[] = lt_return.
  ENDIF.

ENDFUNCTION.
