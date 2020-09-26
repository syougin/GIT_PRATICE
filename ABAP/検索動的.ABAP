*&---------------------------------------------------------------------*
*& Report  ZSHUYIN_0531
*&
*&
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT  ZSHUYIN_0531.
DATA : G_KUNNR TYPE KUNNR,
       G_KDANR TYPE KDANR,
       T_TAB   TYPE STANDARD TABLE OF ZTBL0002,
       ST_WHERE TYPE  C LENGTH 72,
       T_WHERE LIKE STANDARD TABLE OF ST_WHERE.
PARAMETERS : P_BUKRS TYPE BUKRS DEFAULT 'XG01'.
SELECT-OPTIONS : S_KUNNR FOR G_KUNNR,
                 S_KDANR FOR G_KDANR.

START-OF-SELECTION.
  CLEAR ST_WHERE.
  ST_WHERE = 'BUKRS = P_BUKRS'.
  APPEND ST_WHERE TO T_WHERE.

  CLEAR ST_WHERE.
  ST_WHERE = 'AND KUNNR IN S_KUNNR'.
  APPEND ST_WHERE TO T_WHERE.
  CLEAR ST_WHERE.
  ST_WHERE = 'AND KDANR IN S_KDANR'.
  APPEND ST_WHERE TO T_WHERE.
  
  SELECT * FROM ZTBL0002
    INTO TABLE T_TAB 
    WHERE (T_WHERE).