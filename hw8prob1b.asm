      ; adds 1 to every element in an int array of length 5


      .ORG $1000
array .DW  $2
      .DW  $4
      .DW  $6
      .DW  $8
      .DW  $A

      .ORG $0000
START  MV R1, R0   ;moves 0 into R1 to initialize i

LOOP   SLLI R3, R1, $1 ; multiples i by 2 to find offset of array[i] in memory
                       ; and stores this offset in R3
       LW R4, R3, array ; R4 <- array[i]
       ADDI R4, R4, $1 ; R4 <- R4 + $1
       SW R3, R4, array ; array[i] = R4
       ADDI R1, R1, $1 ; i <- i + $1
       SLTI R0, R1, $5 ; computes i - $5
       BRN LOOP ; continues with loop if i < $5
       BRZ DONE ; goes to done if i == $5

DONE   STOP ; finishes here
