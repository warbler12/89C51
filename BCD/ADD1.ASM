ORG 0000H
SJMP BEGIN
ORG 0030H

BEGIN:
CLR A
MOV 30H,#02H     
mov 40H,#09H
mov 41H,#01H
mov 50H,#02H
mov 51H,#03H
MOV R0,#40H      ;num1 
MOV R1,#50H      ;num2
MOV R2,#60H      
MOV R4,30H       ;count


LOOP:
CLR  A
ADDC A,#00
ADD  A,@R0
DA   A
SWAP A
MOV  @R0,A
MOV  A,@R1
DA   A
SWAP A
ADD  A,@R0
DA   A
MOV  @R0,A
INC  R0
INC  R1
DJNZ R4,LOOP
SJMP $
END
