.MODEL SMALL
.STACK 100h

.DATA
    resultMessage DB "Sum is: $"
    sumResult DB 6 DUP (0)   ; 存储结果字符串，最多5个数字位+结束符

.CODE
MAIN PROC
    MOV AX, @DATA            ; 初始化数据段
    MOV DS, AX

    ; 初始化寄存器
    XOR CX, CX               ; CX 作为计数器，初始化为 0
    XOR AX, AX               ; AX 作为累加器，初始化为 0
    XOR BX, BX               ; BX 作为计数器

calc_sum:
    INC BX                   ; BX += 1
    ADD AX, BX               ; AX += BX
    CMP BX, 100              ; 如果 BX == 100，结束循环
    JLE calc_sum             ; 如果 BX <= 100，继续循环

    ; 现在 AX 中包含累加和 (5050)
    ; 将累加和转换为字符串并输出

    MOV SI, OFFSET sumResult  ; 将 SI 指向 sumResult 缓冲区
    CALL Itoa                 ; 调用 Itoa 函数将数字转换为字符串

    ; 输出结果
    MOV AH, 09H               ; 调用DOS中断来输出字符串
    MOV DX, OFFSET sumResult
    INT 21H                   ; DOS中断：显示字符串

    ; 退出程序
    MOV AH, 4CH               ; DOS中断：程序结束
    INT 21H

MAIN ENDP

; 函数: Itoa
; 将 AX 中的整数转换为 ASCII 并存储在 sumResult 缓冲区中
Itoa PROC
    XOR CX, CX                ; CX 用来计数位数
    MOV BX, 10                ; 将除数设为 10

convert_loop:
    XOR DX, DX                ; 清空 DX
    DIV BX                    ; AX = AX / 10, 余数存入 DX
    ADD DL, '0'               ; 将余数转换为 ASCII
    PUSH DX                   ; 将数字压栈
    INC CX                    ; 记录位数
    CMP AX, 0
    JNE convert_loop          ; 如果 AX 还没被除完，继续

print_digits:
    POP DX                    ; 从栈中取出一个数字
    MOV [SI], DL              ; 将其存入结果缓冲区
    INC SI                    ; SI 前移
    LOOP print_digits         ; 循环直到所有数字输出完毕

    MOV BYTE PTR [SI], '$'    ; 在字符串末尾加上 '$'
    RET
Itoa ENDP

END MAIN
