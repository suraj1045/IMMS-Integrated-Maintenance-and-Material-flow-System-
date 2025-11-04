CLASS zcl_imms_bapi_handler DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS:
      create_pr IMPORTING iv_reqid TYPE zreq_id,
      post_goods_movement,
      create_sales_order.
ENDCLASS.
