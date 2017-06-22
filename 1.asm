
ASSUME CS:CODE		;将段名CODE和代码段寄存器CS相关联

CODE SEGMENT		;定义一个段，段名为CODE，段从此开始

	MOV AX, 2
	ADD AX, AX
	ADD AX, AX

	MOV AX,4C00H	;这两行是程序返回
	INT 21H

CODE ENDS			;段名为CODE，段结束

END					;整个汇编程序结束
