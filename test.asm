      .ORG $000
      ;LI R3, $0
      LI R7, $0
LOOP  ADDI R3, R3, $1
      SLTI R0, R3, $5
      BRN LOOP
END   STOP
