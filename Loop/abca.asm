STKSEG SEGMENT STACK
    DW 32 DUP(0)
STKSEG ENDS

DATASEG SEGMENT
    newline DB 0Dh, 0Ah, '$'    ; 换行符
DATASEG ENDS

CODESEG SEGMENT
    ASSUME CS:CODESEG, DS:DATASEG
MAIN PROC FAR
    MOV AX, DATASEG       ; 初始化数据段
    MOV DS, AX

    ; 输出小写字母 a-z，每行 13 个
    MOV CX, 26            ; CX = 26，输出 26 个小写字母
    MOV AL, 'a'           ; AL 初始化为 'a'
    MOV BX, 13            ; BX = 13，每行输出 13 个字符

A:                         ; 主循环标签
    MOV DL, AL            ; 将当前字母放入 DL
    MOV AH, 2             ; DOS 中断功能号 2：显示字符
    INT 21H               ; 调用中断输出字符

    INC AL                ; AL 加 1，指向下一个字母
    DEC BX                ; 每输出一个字符，BX 减 1
    JNZ B                 ; 如果还没输出 13 个字符，继续
    ; 输出换行符
    MOV AH, 9             ; DOS 中断功能号 9：显示字符串
    LEA DX, newline       ; 指向换行符
    INT 21H               ; 输出换行符

    MOV BX, 13            ; 重置 BX 为 13，继续输出下一行

B:                         ; 换行标签
    LOOP A                ; 循环输出直到 CX=0

    ; 程序结束
    MOV AX, 4C00H         ; 程序结束
    INT 21H
MAIN ENDP
CODESEG ENDS
    END MAIN
