ORG 0000H
SJMP START
ORG 0080H

START:
       MOV DPTR,#TABLE
       MOV A,#00H
       MOV P0,A
       MOV P2,A

Loop1:
       MOV R1,#16
       MOV R2,#00H       
       MOV R0,#00H
       
Loop2:
       MOV A,R2
       MOV P1,A
       INC R2
       
       MOV A,R0       
       MOVC A,@A+DPTR
       MOV P0,A   
       INC R0
       MOV A,R0
       MOVC A,@A+DPTR
       MOV P2,A
       INC R0
       CALL DELAY1
       DJNZ R1,Loop2
       
       JMP Loop1
sjmp $
TABLE:
db 08H,20H,08H,0C0H,0BH,00H,0FFH,0FFH,09H,00H,08H,84H,42H,08H,42H,32H
db 47H,0C4H,4AH,18H,53H,0E2H,62H,01H,42H,02H,07H,0FCH,02H,00H,00H,00H

DELAY1:
    MOV R3,#02H
D2:
    MOV R4,#0FFH
    DJNZ R4,$
    DJNZ R3,D2
RET














