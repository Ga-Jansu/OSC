.MODEL SMALL
.CODE
MAIN PROC
    MOV BX,0FFH
    MOV CX,16
    MOV AH,02H
    VOLTAR:
        ROL BX,1
        JNC ZERO
        MOV DL,31H
        JMP IMPRIMIR
    ZERO:   MOV DL,30H
    IMPRIMIR:
        INT 21H
        LOOP VOLTAR
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN