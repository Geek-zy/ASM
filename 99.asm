
DATA       SEGMENT
TABLE   DW 81 DUP(0)
DATA    ENDS

CODE	SEGMENT
	ASSUME CS:CODE,DS:DATA
	START:
	MOV AX,DATA
	MOV DS,AX
	MOV DI,OFFSET TABLE ;DI指向TABLE的首地址00H
	MOV BL,1            ;外循环值
	MUL_1:                       
	MOV BH,1            ;内循环值
	MUL_2:
	PUSH CX             ;压栈
	;输出第一个外循环值
	MOV DL,BL
	OR DL,30H
	MOV AH,02H
	INT 21H
	;输出乘号            
	MOV DL,'X'
	MOV AH,02H
	INT 21H
	;输出第一个内循环值
	MOV DL,BH
	OR DL,30H
	MOV AH,02H
	INT 21H
	;输出等号
	MOV DL,'='
	MOV AH,02H
	INT 21H
	MOV AL,BH            ;把BH的值赋给AL寄存器中
	MUL BL               ;乘法指令，AL与BL相乘，结果放入AL中
	MOV [DI],AL          ;DI指向乘的结果
	CALL DIS             ;调用子函数DIS
	MOV DL,0H            ;输出空格
	MOV AH,2
	INT 21H        
	MOV DL,0H             ;输出空格
	MOV AH,2
	INT 21H
	ADD DI,2              ;DI指向它的下一个地址
	POP CX
	INC BH                ;自加一指令
	CMP BH,BL             ;比较语句，BH小于BL执行JBE语句，否则执行
	;CALL OUTPUT_CTLE语句
	JBE MUL_2             ;跳转指令，返回MUL_2处，实现循环
	CALL OUTPUT_CTLE      ;程序调用指令
	INC BL
	CMP BL,10             ;比较语句，BL小于10执行JB语句，否则执行程
	;序结束指令
	JB MUL_1
	JMP EXIT              ;无条件转移指令
	;OUTPUT_CTLE函数功能：输出回车换行
	OUTPUT_CTLE PROC NEAR
	PUSH AX               ;压栈语句
	PUSH DX
	MOV AH,02H            ;DOS中断下的单个字符输出功能
	MOV DL,0DH            ;0D是回车的ASCLL码值
	INT 21H
	MOV AH,02H
	MOV DL,0AH            ;0A是换行的ASCLL码值
	INT 21H
	POP DX                ;出栈语句
	POP AX
	RET
	OUTPUT_CTLE ENDP              ;子函数DIS结束
	;DIS功能：在系统内数据是十六进制的，乘的结果大于10，则需要转化成十进
	;制数但不输出，首先判断数据是否大于10，大于10的除以10，余数放入DL中。
	DIS PROC NEAR                 ;子函数DIS开始
	PUSH AX
	PUSH DX
	MOV DH,10
	CMP AX,10
	JB NEXT1               ;AX的值低于10转向NEXT1
	DIV DH                 ;AX的值高于10除以10，结果存在AX中
	CALL DISP              ;子函数调用语句
	MOV AL,AH
	NEXT1:
	CALL DISP
	POP DX
	POP AX
	RET
	DIS ENDP                      ;子函数DIS结束
	;DISP的函数功能：把DIS的十进制数转化成ASCLL码，并输出。
	;十进制和ASCLL码相差30H,即把这个十进制数加上30H，就转换成ASCLL码，并
	;把乘数的结果输出。
	DISP PROC NEAR                ;子函数DISP开始
	PUSH AX
	PUSH BX
	MOV DL,AL
	ADD DL,30H             ;加法指令
	MOV AH,2
	INT 21H
	POP BX
	POP AX
	RET
	DISP ENDP                     ;子函数DISP结束
	EXIT:                         ;结束退出语句
	MOV AH,4CH
	INT 21H
CODE ENDS

END START
END START

