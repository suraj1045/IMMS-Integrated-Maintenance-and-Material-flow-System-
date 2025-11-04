REPORT ZIMMS_MAIN_REPORT.

PARAMETERS: p_reqid TYPE zreq_id.

DATA(lo_controller) = NEW zcl_imms_controller( iv_reqid = p_reqid ).

lo_controller->process_request( ).
lo_controller->display_dashboard( ).
