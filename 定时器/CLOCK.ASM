         ORG 0000H
         AJMP MAIN
         ORG 000BH       ;定时器0的中断向量地址
         AJMP TIME0
         ORG 0080H

MAIN:
         MOV P2,#0FFH    ;关所有灯
         MOV 30H,#00H     ;计数器单元清0
         MOV 31H,#0FEH    ;LED
         MOV TMOD,#01H    ;定时/计数器0工作于方式1
         MOV TH0,#3CH
         MOV TL0,#0B0H     ;50ms定时常数
         SETB EA          ;开总中断
         SETB ET0         ;允许定时/计数器0 中断
         SETB TR0         ;启动定时/计数器0 中断
LOOP:
         AJMP LOOP
TIME0:
         PUSH ACC
         PUSH PSW           ;将PSW和ACC推入堆栈保护
         MOV TH0,#3CH
         MOV TL0,#0B0H       ;重置定时常数
         INC 30H
         MOV A,30H
         CJNE A,#10,T_END   ;30H单元中的值到10了吗?
         MOV 30H,#00H       ;清计数器
         MOV  A,31H
         MOV  P0,A
         RL  A
         MOV  31H,A
T_END:
         POP PSW
         POP ACC
         RETI
END
