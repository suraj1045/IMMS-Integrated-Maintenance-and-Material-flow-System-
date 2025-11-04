# ABAP_Code

This folder contains the core technical implementation of the IMMS (Integrated Maintenance and Material System) project.  
It includes custom Z-programs, Object-Oriented ABAP classes, and Function Modules that integrate MM, WM, PM, and SD modules.

### Components
- **ZIMMS_Main_Report.abap** → Main driver report that orchestrates the workflow and ALV UI.
- **ZCL_IMMS_CONTROLLER.abap** → Handles request routing, validations, and workflow logic.
- **ZCL_IMMS_BAPI_HANDLER.abap** → Wrapper for all SAP BAPIs (PR, PO, Goods Movement, Sales Order).
- **ZCL_IMMS_ALV_DISPLAY.abap** → Displays live dashboards for tracking materials and orders.
- **Function_Modules/** → Custom logic for MM, PM, and SD tasks.
- **Z_Tables_Definitions.md** → Contains Z-table design and data structure documentation.
