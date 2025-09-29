ORG 0000H
SJMP main
ORG 0080H

main:
    mov dptr,#tab
    lcall key
    movc A,@a+dptr
    mov P0,A
    CLR P2.1
    ljmp main

key: lcall KS
    JNZ K1
    LCALL DELAY2
    AJMP key
;键值判断
K1: lcall DELAY2
    lcall DELAY2          ;延时
    LCALL KS              ;重新检测
    jnz K2                ;按键成功
    ajmp key              ;时间过短就复原

K2: mov R2,#0FH          ;P1.5-P1.8=0


K3: mov P1,R2


L6: JB P1.0, L1            ;按行判断是否为0
    mov R4,#00H             ;为0
    ajmp col               ;出循环
L1: JB P1.1,L2
    mov R4,#04H
    AJMP col
L2: JB P1.2,L3
    mov R4,#08H
    AJMP col
L3: MOV R4,#0CH
    ajmp col

C1: JB P1.4, C2            ;按列判断是否为0
    mov A,#00H             ;为0
    ajmp FINISH            ;出循环
C2: JB P1.5,C3
    mov A,#01H
    AJMP FINISH
C3: JB P1.6,C4
    mov A,#02H
    AJMP FINISH
C4: MOV A,#03H
    JB P1.7,FINISH

FINISH: add A,R4
        push ACC             ;入栈
K4: lcall DELAY2
    lcall KS
    jnz K4
    pop ACC                  ;出栈
    RET

col:mov R2,#0F0H              ;扫列
    mov P1,R2
    ajmp C1
;结束键值判断

KS: mov P1,#0FH
    mov A,P1
    XRL A,#0FH
    RET

DELAY2:
    mov R5,#08H
L7: mov R6,#0FAH
L8: djnz R6,L8
    djnz R5,L7
    RET
tab: db 28h,34h,28h,34h,0a9h,60h,20h,7ah,20h,21h,61h,74h,30h,62h,0a2h,7eh
