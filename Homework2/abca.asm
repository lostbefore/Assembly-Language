STKSEG SEGMENT STACK
    DW 32 DUP(0)
STKSEG ENDS

DATASEG SEGMENT
    newline DB 0Dh, 0Ah, '$'    
DATASEG ENDS

CODESEG SEGMENT
    ASSUME CS:CODESEG, DS:DATASEG
MAIN PROC FAR
    MOV AX, DATASEG       
    MOV DS, AX

    
    MOV CX, 26            
    MOV AL, 'a'           
    MOV BX, 13           

A:                         
    MOV DL, AL            
    MOV AH, 2             
    INT 21H               

    INC AL                
    DEC BX                
    JNZ B                 
    
    MOV AH, 9             
    LEA DX, newline       
    INT 21H               

    MOV BX, 13            

B:                         
    LOOP A                

    
    MOV AX, 4C00H         
    INT 21H
MAIN ENDP
CODESEG ENDS
    END MAIN
