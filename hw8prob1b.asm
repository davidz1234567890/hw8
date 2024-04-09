      .ORG $1000
array .DW  $5
      .DW  $2
      .DW  $8
      .DW  $9
      .DW  $6

      .ORG $0000
START  MV R1, R0   ;moves 0 into R1 to initialize i

LOOP   SLLI R3, R1, $1 ; multiples i by 2 and stores in R3
       LW R4, R3, array ; R4 <- array[&array+i*2]
       ADDI R4, R4, $1 ; R4 <- R4 + $1
       SW R3, R4, array ; array[&array+i*2] = R4
       ADDI R1, R1, $1 ; i <- i + $1
       SLTI R0, R1, $5 ; computes R1 - $5
       BRN LOOP ; continues with loop if R1 < $5
       BRZ DONE ; goes to done if R1 == $5

DONE   STOP ; finishes here
