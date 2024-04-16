      ; this program takes in 2 numbers
      ; the first at address $1000
      ; the second at address $1002
      ; it keeps adding 1 to the first number
      ; and keeps subtracting 1 from the second number
      ; until the first number is greater than or equal to the second number
      ; if the first number is already greater than or equal to the second,
      ; it returns immediately
      ; the ending values of the first and second number are stored in
      ; R2 and R3 respectively

      .ORG $000
      BRA $200

      .ORG $1000
      .DW $0 ; first number
      .DW $8 ; second number

      .ORG $200
START LW R2, R0, $1000 ; loads first number into R2
      LW R3, R0, $1002 ; loads second number into R3
      LI R1, $1 ; R1 <- 1, this is for subtraction
LOOP  SLT R0, R3, R2 ; computes second number - first number
                     ; and discards the result
      BRNZ FINISH ; exits if second number <= first number
      ADDI R2, R2, $1 ; first number <- first number + $1
      SUB R3, R3, R1 ; second <- second - R1 where R1 <- $1
      BRA LOOP ; goes back to the loop
FINISH  STOP
