.MODEL SMALL
.STACK 100h
.DATA
    newline DB 0Dh, 0Ah, '$'    ; 换行符（回车+换行）

.CODE
main PROC
    MOV AX, @DATA               ; 初始化数据段寄存器
    MOV DS, AX

    MOV CX, 26                  ; CX = 26, 循环 26 次，输出 a-z
    MOV AL, 'a'                 ; AL 初始值为 'a'
    MOV BX, 13                  ; BX = 13，每行输出13个字符

print_loop:
    MOV DL, AL                  ; 将当前字符放入 DL
    MOV AH, 2                   ; DOS 中断 21h 的功能号 2：显示字符
    INT 21h                     ; 调用 DOS 中断输出字符

    INC AL                      ; AL 加 1，指向下一个字母
    DEC BX                      ; 每输出一个字符，BX 减 1
    JNZ continue_print          ; 如果还没到13个，继续输出

    ; 输出换行符
    MOV AH, 9                   ; DOS 中断 21h 的功能号 9：显示字符串
    LEA DX, newline             ; 输出换行符
    INT 21h

    MOV BX, 13                  ; 重置 BX 为 13，开始新的一行

continue_print:
    LOOP print_loop             ; 继续循环，直到 CX = 0

    MOV AH, 4Ch                 ; DOS 中断 21h 的功能号 4Ch：程序退出
    INT 21h                     ; 调用 DOS 中断退出程序
main ENDP
END main
