      .ORG $000
START LI R2, $0 ; R2 <- 0
      LI R3, $8 ; R3 <- 8
      LI R1, $1 ; R1 <- 1
LOOP  SLT R0, R2, R3 ; computes R2 - R3 and discards the result
      BRZ FINISH ; exits if R2 == R3
      ADDI R2, R2, $1 ; R2 <- R2 + $1
      SUB R3, R3, R1 ; R3 <- R3 - R1 where R1 <- $1
      BRA LOOP ; goes back to the loop
FINISH  STOP
