*&---------------------------------------------------------------------*
*& Report  ZSHUYIN_0531
*&
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHUYIN_0531.

DATA:
BEGIN OF GT_OUT OCCURS 0,  "输出表
     MACHINE(5) TYPE N,         "机台
     TON(5) TYPE N,             "吨位
     EXTWG LIKE MARA-EXTWG,     "客户
     ZEINR LIKE MARA-ZEINR,     "机种
     MATNR LIKE MARA-MATNR,     "内部品番
     MAKTX LIKE MAKT-MAKTX,     "外部品番
     VGW04 LIKE AFVV-VGW04,     "周期
     BMSCH(16) TYPE N,          "取数
     NGRAD LIKE KAKO-NGRAD,     "收率
     ABILI(7)  TYPE P,         "日生产能力
     KPCS01(7) TYPE P  DECIMALS 3,         "产量
     DAYS01(5) TYPE P  DECIMALS 2,         "生产天数
     WORK01(2) TYPE N,                     "工作天数
     ACTI01 LIKE KONV-KBETR,               "稼动率
END OF GT_OUT.

* ALV 定义
TYPE-POOLS:SLIS.

DATA: G_REPID LIKE SY-REPID,
      GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV WITH HEADER LINE,
      GT_LAYOUT   TYPE SLIS_LAYOUT_ALV.

DEFINE MODIFY_FIELDCAT1.

  READ TABLE GT_FIELDCAT INDEX &1.
  GT_FIELDCAT-SELTEXT_M  = &2.
  GT_FIELDCAT-DDICTXT    = 'M'.
  MODIFY GT_FIELDCAT INDEX &1.

END-OF-DEFINITION.


DATA:LV_INDEX LIKE SY-TABIX,
     LV_TEXT TYPE SCRTEXT_M.

G_REPID = SY-REPID.

CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
  EXPORTING
    I_PROGRAM_NAME         = G_REPID
    I_INTERNAL_TABNAME     = 'GT_OUT'
    I_INCLNAME             = G_REPID
  CHANGING
    CT_FIELDCAT            = GT_FIELDCAT[]
  EXCEPTIONS
    INCONSISTENT_INTERFACE = 1
    PROGRAM_ERROR          = 2
    OTHERS                 = 3.

IF SY-SUBRC <> 0.
  MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
          WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.



MODIFY_FIELDCAT1: 1  '机台',
                  2  '吨位',
                  3  '客户',
                  4  '机种',
                  5  '内部品番',
                  6  '外部品番',
                  7  '周期',
                  8  '取数',
                  9  '收率',
                  10 '日生产能力'.


READ TABLE GT_FIELDCAT INDEX 8.
GT_FIELDCAT-NO_ZERO  = 'X'.
MODIFY GT_FIELDCAT INDEX 8.


GT_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    I_CALLBACK_PROGRAM = G_REPID
    IS_LAYOUT          = GT_LAYOUT
    IT_FIELDCAT        = GT_FIELDCAT[]
    I_SAVE             = 'X'
  TABLES
    T_OUTTAB           = GT_OUT
  EXCEPTIONS
    PROGRAM_ERROR      = 1
    OTHERS             = 2.

IF SY-SUBRC <> 0.
  MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
          WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.