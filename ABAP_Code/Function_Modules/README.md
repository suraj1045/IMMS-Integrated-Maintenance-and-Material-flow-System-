# Function Modules

This directory contains the custom ABAP Function Modules that power the IMMS system:

| Function Module | Module | Description |
|-----------------|---------|-------------|
| **ZMM_MATERIAL_REQ** | MM | Creates a Purchase Requisition when parts are not available in stock. |
| **ZPM_ORDER_PROCESS** | PM | Handles maintenance orders and posts goods issues for consumed materials. |
| **ZSD_ORDER_CREATE** | SD | Creates Sales Orders for scrap or replaced materials. |

Each function module uses standard SAP BAPIs, commits transactions properly, and updates custom Z-tables for full traceability.
