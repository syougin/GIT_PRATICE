*&---------------------------------------------------------------------*
*& Report  ZSHUYIN_0531
*&
*&
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT  ZSHUYIN_0531.
DATA : BEGIN OF ST_REC,
  FIELD01 TYPE C LENGTH 10 VALUE '項目01',
  FIELD02 TYPE C LENGTH 10 VALUE '項目02',
  FIELD03 TYPE C LENGTH 10 VALUE '項目03',
  FIELD04 TYPE C LENGTH 10 VALUE '項目04',
  FIELD05 TYPE C LENGTH 10 VALUE '項目05',
  FIELD06 TYPE C LENGTH 10 VALUE '項目06',
        END OF ST_REC,
G_NAME TYPE C LENGTH 14,
G_CNT TYPE N LENGTH 2.
FIELD-SYMBOLS <FS> TYPE ANY.
START-OF-SELECTION.
DO.
  G_CNT = G_CNT + 1.
  CONCATENATE 'ST_REC-FIELD' G_CNT INTO G_NAME.
  ASSIGN (G_NAME) TO <FS>.
  IF SY-SUBRC = 0.
    WRITE :/001 <FS>.
    ELSE.
      EXIT.

  ENDIF.
ENDDO.