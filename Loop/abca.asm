.MODEL SMALL
.STACK 100h
.DATA
    newline DB 0Dh, 0Ah, '$'    

.CODE
main PROC
    MOV AX, @DATA                  
    MOV DS, AX

    MOV CX, 26                  
    MOV AL, 'a'                 
    MOV BX, 13                  

L:
    MOV DL, AL                  
    MOV AH, 2                   
    INT 21h                     

    INC AL                      
    DEC BX                      
    JNZ continue_print          

    MOV AH, 9                   
    LEA DX, newline             
    INT 21h

    MOV BX, 13                  

    LOOP L             

    MOV AH, 4Ch                 
    INT 21h                     
main ENDP
END main
