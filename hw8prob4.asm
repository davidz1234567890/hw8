           .ORG $0000
INIT_R2LD  .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0

INIT_L2RD  .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0

INIT_CL    .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0
           .DW $0

           .ORG $1234
BOARD      .DW $1324 ; placement of queens in row 0-3
           .DW $0657 ; placement of queens in row 4-7


           .ORG $1000
START      LI R1, $0    ; j <- 0
                        ; use j to convert the board hex digits
                        ; to memory locations
           LW R2, R0, $1234 ; loads the board starting address

LOOP1      SLLI R3, R1, $2 ; computes j * 4
           SRL R4, R2, R3 ; R4 <- (board >> (j*4))
           AND R4, R4, $000F ; extract the last 4 bits of (board >> (j*4))
           SLLI R5, R1, $1 ; location_offset <- j * 2
           SW R5, R4, $500 ; store last 4 bits of (board >> (j*4))
                           ; at m[$500+location_offset]
           ADDI R1, R1, $1 ; j <- j + 1
           SLTI R0, R1, $4 ; computes j - 4 after incrementing
           BRN LOOP1 ; continues if j < 4

CONT       LI R1, $0 ; pos <- 0
           LI R2, $0 ; i <- 0

LOOP       SLLI R3, R2, $1 ; find offset of position i by computing i*2
           LW R1, R3, $500 ; pos = m[$500+offset] = board[i]

           ; this part checks if r2ld[i - pos + N - 1] == 1
           ADDI R4, R2, $3 ; computes i + N - 1
           SUB R4, R4, R1 ; computes i - pos + N - 1 and stores it in R4
           SLLI R4, R4, $1 ; computes offset of index i - pos + N - 1
                           ; inside of array r2ld
                           ; by multiplying (i-pos+N-1) by 2
           LW R5, R4, INIT_R2LD ; R5 <- r2ld[i-pos+N-1]
           SLTI R0, $0, R5 ; computes  $0 - r2ld[i-pos+N-1] 
           BRN ENDF        ; goes to return false if r2ld[i-pos+N-1] == 1


        ; this part checks if l2rd[i + pos] == 1
           ADD R4, R2, R1 ; computes i + pos and stores it in R4
           SLLI R4, R4, $1 ; computes offset of index i + pos
                           ; inside of array l2rd by multiplying (i+pos) by 2
            
           LW R5, R4, INIT_L2RD ; R5 <- l2rd[i+pos]
           SLTI R0, $0, R5 ; computes $0 - l2rd[i+pos] 
           BRN ENDF  ; goes to return false if l2rd[i+pos] == 1


        ; this part checks if cl[pos] == 1
           SLLI R4, R1, $1 ; computes pos*2 for offset into cl array
                           ; and stores the result in R4
           LW R5, R4, INIT_CL ; R5 <- cl[pos]
           SLTI R0, $0, R5 ; computes $0 - cl[pos] 
           BRN ENDF  ; goes to return false if l2rd[i+pos] == 1

           ; this part sets r2ld[i - pos + N - 1] equal to 1
           ADDI R4, R2, $3 ; computes i + N - 1
           SUB R4, R4, R1 ; computes i - pos + N - 1 and stores it in R4
           SLLI R4, R4, $1 ; computes offset of index i - pos + N - 1
                           ; inside of array r2ld
                           ; by multiplying (i-pos+N-1) by 2
           LI R6, $1
           SW R4, R6, INIT_R2LD ; r2ld[i-pos+N-1] <- $1


           ; this part sets l2rd[i + pos] equal to 1
           ADD R4, R2, R1 ; computes i + pos and stores it in R4
           SLLI R4, R4, $1 ; computes offset of index i + pos
                           ; inside of array l2rd by multiplying (i+pos) by 2
           LI R6, $1
           SW R4, R6, INIT_L2RD ; l2rd[i+pos] <- 1

           ; this part sets cl[pos] equal to 1
           SLLI R4, R1, $1 ; computes pos*2 for offset into cl array
                           ; and stores the result in R4
           LI R6, $1
           SW R4, R6, INIT_CL  ; cl[pos] <- 1

           ADDI R2, R2, $1 ; i <- i + 1
           SLTI R0, R2, $4 ; computes i - 4
           BRN LOOP ; continues loop if i is still less than 4
           BRA ENDT ; loop completes and 8 queen is true


ENDF       LI R7, $0 ; returns false
           STOP

ENDT       LI R7, $1 ; returns true
           STOP 


           