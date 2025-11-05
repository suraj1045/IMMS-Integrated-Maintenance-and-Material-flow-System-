
* FUNCTION MODULE : ZPM_ORDER_PROCESS
* PURPOSE         : Handle Maintenance Order and Goods Movement
* MODULE          : PM (Plant Maintenance)
* AUTHOR          : Suraj V
* DATE            : Nov 2025

FUNCTION ZPM_ORDER_PROCESS.

*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_REQID) TYPE ZREQ_ID
*"  EXPORTING
*"     VALUE(EV_ORDER_NO) TYPE AUFNR
*"  TABLES
*"     RETURN STRUCTURE BAPIRET2

  DATA: ls_goods TYPE bapi2017_gm_head_01,
        lt_items TYPE TABLE OF bapi2017_gm_item_create,
        lt_return TYPE TABLE OF bapiret2.

  SELECT SINGLE * FROM zmaint_req INTO @DATA(ls_req)
    WHERE req_id = @iv_reqid.

  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  " Create Maintenance Order (simplified simulation)
  ev_order_no = |PM{ iv_reqid ALPHA = OUT }|.

  " Post Goods Issue for used material
  ls_goods-pstng_date = sy-datum.
  ls_goods-doc_date = sy-datum.
  ls_goods-pr_uname = sy-uname.
  ls_goods-header_txt = 'IMMS Auto GI Posting'.

  APPEND VALUE #( 
    material  = ls_req-part_no
    plant     = ls_req-plant
    stge_loc  = ls_req-stor_loc
    move_type = '261' "Goods issue for order
    entry_qnt = ls_req-qty
    orderid   = ev_order_no
  ) TO lt_items.

  CALL FUNCTION 'BAPI_GOODSMVT_CREATE'
    EXPORTING
      goodsmvt_header = ls_goods
      goodsmvt_code   = VALUE(bapi2017_gm_code)(gm_code = '03')
    TABLES
      goodsmvt_item   = lt_items
      return          = lt_return.

  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
    EXPORTING wait = 'X'.

  UPDATE zmaint_req SET status = 'MAINT_DONE', order_no = ev_order_no
    WHERE req_id = iv_reqid.

ENDFUNCTION.
