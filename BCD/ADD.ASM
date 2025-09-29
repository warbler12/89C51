ORG 0000H
SJMP MAIN
ORG 0030H

MAIN:
MOV R0,#10H    ;count
MOV 0030H,#00H     ;deposit
mov 31H,#00H

LOOP:
MOV A,0030H
setB CY
ADDC A,ACC
DA A
mov 30H,A
mov A,31H
ADDC A,ACC
mov 31H,A

DJNZ R0,LOOP
SJMP $



