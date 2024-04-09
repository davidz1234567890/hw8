      .ORG $1000
array .DW  $6
      .DW  $9
      .DW  $2
      .DW  $4
      .DW  $1

      .ORG $0000
START  MV R1, R0   ;moves 0 into R1 to initialize i
       MV R2, R0   ;initializes count to 0
       ADDI R7, R1, $1 ; initializes R7 to $1
LOOP   SLLI R3, R1, $1 ; multiples i by 2 and stores in R3
       LW R4, R3, array ; R4 <- array[&array+i*2]
       SLLI R5, R7, $1 ; R5 <- (i+1)*2
       LW R6, R5, array ; R6 <- array[&array+(i+1)*2]
       SLT R0, R4, R6 ; performes array[i] - array[i+1]
       BRN INCR  ; increments count by 1
                      ; if array[i] < array[i+1]
       BRA AFTER ; otherwise go to after

INCR   ADDI R2, R2, $1 ; count <- count + $1
AFTER  ADDI R1, R1, $1 ; i <- i + $1
       ADDI R7, R1, $1 ; R7 <- i+1
       SLTI R0, R7, $5 ; computes R7 - $5
                       ; i+1 must be a valid index
                       ; that is not out of bounds
       BRN LOOP ; continues with loop if R1 < $5
       BRZ DONE ; goes to done if R1 == $5

DONE   STOP ; finishes here


