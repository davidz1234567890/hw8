      ; reverses an array of length 5

      .ORG $000
      BRA $200

      .ORG $100
ARR   .DW $9
      .DW $8
      .DW $E
      .DW $F
      .DW $0


      .ORG $200
START LI R1, $0 ; i <- 0


LOOP  SLLI R2, R1, $1 ; computes i*2 which is the offset
                      ; of array[i] from beginning of array
      LW R3, R2, $100 ; load array[i] into R3
      SW R0, R3, $500 ; m[$500] = array[i]
      LI R3, $1 ; R3 <- 1 for subtracting purposes
      LI R4, $5 ; R4 <- 5 for subtracting purposes
      SUB R6, R4, R1
      SUB R6, R6, R3 ; this line and above compute 5 - i - 1
      SLLI R6, R6, $1 ; computes (5-i-1)*2
                      ; which is the offset of array[5-i-1]
                      ; from the beginning of the array
      LW R3, R6, $100 ; load array[5-i-1] into R3
      SW R2, R3, $100 ; R2 still contains offset of array[i] from
                      ; beginning of array
                      ; so this operation does
                      ; array[i] = array[5-i-1]
      LW R3, R0, $500 ; m[$500] contains array[i]
                      ; R3 <- array[i]
      SW R6, R3, $100 ; R6 still contains offset of array[5-i-1]
                      ; from beginning of array
                      ; so this operation does
                      ; array[5-i-1] = array[i]
      ADDI R1, R1, $1 ; i <- i + $1
      SRAI R7, R4, $1 ; divides 5 by 2
      SLT R0, R1, R7 ; computes i - 5/2
      BRNZ LOOP ; continues loop if i <= 5/2
      BRA END ; terminates loop if i > 5/2
END   STOP
