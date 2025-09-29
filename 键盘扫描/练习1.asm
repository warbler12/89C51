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
;��ֵ�ж�
K1: lcall DELAY2
    lcall DELAY2          ;��ʱ
    LCALL KS              ;���¼��
    jnz K2                ;�����ɹ�
    ajmp key              ;ʱ����̾͸�ԭ

K2: mov R2,#0EFH          ;ѡ�� P1.5=0
    mov R4,#00H

K3: mov P1,R2

L6: JB P1.0, L1            ;�����ж��Ƿ�Ϊ0
    mov A,#00H             ;Ϊ0,Aȡ��һ��
    ajmp LK                ;��ѭ��
L1: JB P1.1,L2
    mov A,#04H
    AJMP LK
L2: JB P1.2,L3
    mov A,#08H
    AJMP LK
L3: JB P1.3,NEXT
    MOV A,#0cH
LK: add A,R4
    push ACC                 ;R4��ջ
K4: lcall DELAY2
    lcall KS
    jnz K4
    pop ACC                  ;R4��ջ
    RET
;������ֵ�ж�    
KS: mov P1,#0FH
    mov A,P1
    XRL A,#0FH
    RET
                       
NEXT: inc R4                 ;���У�������
    mov A,R2
    jnb ACC.7,key            ;ɨ�����
    RL A                     ;δ���
    mov R2,A
    ajmp K3
    
DELAY2:
    mov R5,#08H
L7: mov R6,#0FAH
L8: djnz R6,L8
    djnz R5,L7
    RET
tab: db 28h,34h,28h,34h,0a9h,60h,20h,7ah,20h,21h,61h,74h,30h,62h,0a2h,7eh
