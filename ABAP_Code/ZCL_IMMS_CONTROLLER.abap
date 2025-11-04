CLASS zcl_imms_controller DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_reqid TYPE zreq_id,
      process_request,
      display_dashboard.
  PRIVATE SECTION.
    DATA: mv_reqid TYPE zreq_id,
          lo_bapi_handler TYPE REF TO zcl_imms_bapi_handler.
ENDCLASS.

CLASS zcl_imms_controller IMPLEMENTATION.
  METHOD constructor.
    mv_reqid = iv_reqid.
    CREATE OBJECT lo_bapi_handler.
  ENDMETHOD.

  METHOD process_request.
    lo_bapi_handler->create_pr( mv_reqid ).
  ENDMETHOD.

  METHOD display_dashboard.
    DATA(lo_alv) = NEW zcl_imms_alv_display( ).
    lo_alv->show( mv_reqid ).
  ENDMETHOD.
ENDCLASS.
