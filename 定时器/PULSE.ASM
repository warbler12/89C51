ORG 0000H
AJMP MAIN
ORG 000BH
AJMP TIME0
ORG 0080H
MAIN:
    MOV  P2,#0H
    MOV 30H,#00H
    MOV 31H,#00H
    mov 33H,#2H     ;占空比

    MOV TMOD,#01H
    MOV TH0,#0FFH
    MOV TL0,#0DFH    ;时间
    SETB EA
    SETB ET0
    SETB TR0
LOOP:
    AJMP LOOP

TIME0:
    PUSH ACC
    PUSH PSW
    MOV TH0,#0FFH
    MOV TL0,#0DFH    ;复位
    INC 30H          ;单位循环加一

    MOV A,31H
    CJNE A,#0H,PULSE0   ;低，A=1跳转
    CJNE A,#1H,PULSE1   ;高（顺序执行得到）
    CPL A
    MOV  31H,A
    MOV  P2,A
    
    MOV A,30H
    CJNE A,33H,T_END
    MOV 30H,#00H

    
T_END:                 ;
    POP PSW
    POP ACC
    RETI
PULSE0:
    MOV 33H,#2H
    RET
PULSE1:
    MOV 33H,#8H
    RET


END
