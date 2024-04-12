    .ORG $1234
L   .DW $6
A   .DW $1
    .DW $5
    .DW $4
    .DW $7
    .DW $2
    .DW $8
    .ORG $1000
    LI r3 , A
    LI r7 , L
    LW r2, r7, $0
    MV r1 , r0
B   XOR r6 , r1 , r2
    BRZ E
    SLLI r7 , r1, $1
    ADD r7 , r3 , r7
    LW r4 , r7 , $0
    LI r6 , $1
    AND r6, r4 , r6
    BRZ O
    ADDI r5 , r5 , $1
O   ADDI r1 , r1 , $1
    BRA B
E   STOP

