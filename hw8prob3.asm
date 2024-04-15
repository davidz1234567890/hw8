
    .ORG $1234
A   .DW $8 ; value of a.
B   .DW $7 ; value of b
RES .DW $0


START LI R1, A ; loads address of A
      LI R2, B ; loads address of B
      LW R3, R1, $0 ; R3 <- M[R1+$0] = a
      LW R4, R2, $0 ; R4 <- M[R2+$0] = b
      SLT R0, R3, R4 ; computes a - b
      BRZ END ; terminates loop if a == b

LOOP  SLT R0, R3, R4 ; computes a - b
      BRN ALTB       ; if a < b, branch to ALTB
      SUB R3, R3, R4 ; if a > b, do a <- a - b
      SLT R0, R3, R4 ; computes a - b
      BRZ END ; terminates loop if a == b
      BRA LOOP       ; return to loop
ALTB  SUB R4, R4, R3 ; if a < b, b <- b - a
      SLT R0, R3, R4 ; computes a - b
      BRZ END ; terminates loop if a == b
      BRA LOOP       ; return to loop

END   LI R5, RES ; loads address of RES
      SW R5, R3, $0 ; stores result of a in RES
      STOP
