DATA: gt_display TYPE TABLE OF zmm_materials.

SELECT * FROM zmm_materials INTO TABLE gt_display.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  TABLES t_outtab = gt_display
  EXCEPTIONS program_error = 1.
