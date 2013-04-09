00000 * Example COBOL Copybook file                                     AAAAAAAA
00000  01  PAULUS-EXAMPLE-GROUP.                                        AAAAAAAA
00000       05  PAULUS-ANOTHER-GROUP OCCURS 0003 TIMES.                 AAAAAAAA
00000           10  PAULUS-FIELD-1 PIC X(3).                            AAAAAAAA
00000           10  PAULUS-FIELD-2 REDEFINES PAULUS-FIELD-1 PIC 9(3).   AAAAAAAA
00000           10  PAULUS-FIELD-3 OCCURS 0002 TIMES                    AAAAAAAA
00000                           PIC S9(3)V99.                           AAAAAAAA
00000       05  PAULUS-THIS-IS-ANOTHER-GROUP.                           AAAAAAAA
00000           10  PAULUS-YES PIC X(5).                                AAAAAAAA
