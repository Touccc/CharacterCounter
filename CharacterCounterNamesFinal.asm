.ORIG x3000

LD R6, stack_addr

LEA R0, inputNameMsg
PUTS

LD R1, full_name
LD R2, sentinel

JSR get_full_name

LEA R0, inputLetterMsg
PUTS

GETC
OUT
AND R4, R4, #0
ADD R4, R4, R0
LD R0, newline
OUT

JSR count_frequency

LEA R0, resultMsg
PUTS
LD R3, zero
ADD R0, R2, R3
OUT
HALT

;---------------------------------------------------------------------------------
; get_full_name - TAKES INPUT (FULL NAME) FROM USER AND STORES IN ARRAY
;
; PARAMETER (R1): THE ADDRESS OF THE ARRAY THE INPUT IS STORED
; PARAMETER (R2): SENTINEL KEY
;
; RETURNS: N/A
;---------------------------------------------------------------------------------
get_full_name
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0

AND R3, R3, #0
USER_INPUT_LOOP
GETC
OUT

ADD R3, R0, R2
BRz STOP_USER_INPUT_LOOP

STR R0, R1, #0
ADD R1, R1, #1

BR USER_INPUT_LOOP
STOP_USER_INPUT_LOOP

LDR R1, R6, #0
ADD R6, R6, #1
LDR R2, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET

;---------------------------------------------------------------------------------
; count_frequency - COUNTS FREQUENCY OF GIVEN LETTER IN GIVEN STRING
;
; PARAMETER (R1): THE ADDRESS OF THE ARRAY THE INPUT IS STORED
; PARAMETER (R4): GIVEN LETTER
;
; RETURNS: (R2): THE FREQUENCY OF GIVEN LETTER IN GIVEN STRING
;---------------------------------------------------------------------------------
count_frequency
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R4, R6, #0

NOT R4, R4
ADD R4, R4, #1
AND R2, R2, #0
ITERATION_LOOP
LDR R3, R1, #0
BRz STOP_ITERATION_LOOP

ADD R3, R3, R4
BRnp SKIP_INCREMENT
ADD R2, R2, #1
SKIP_INCREMENT
ADD R1, R1, #1
BR ITERATION_LOOP
STOP_ITERATION_LOOP


LDR R4, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET


;-------------------------
;
;       PROGRAM DATA
;
;-------------------------
stack_addr              .FILL       xFE00
full_name               .FILL       x4000

inputNameMsg            .STRINGZ    "Input your full name (case sensitive): "
inputLetterMsg          .STRINGZ    "Input a letter: "
resultMsg               .STRINGZ    "Frequency of given letter: "

sentinel                .FILL       #-10
newline                 .FILL       x0A
zero                    .FILL       x30

.END