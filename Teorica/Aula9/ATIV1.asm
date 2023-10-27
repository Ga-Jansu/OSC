TITLE ativ1
.MODEL SMALL
.STACK 100H
.DATA
    MSG_AX DB 10,13,"O maior valor entre os dois esta em: AX$"
    MSG_BX DB 10,13,"O maior valor entre os dois esta em: BX$"
    MSG_IGUAL DB 10,13,"AX == BX$"
.CODE
main proc
    MOV AX,@DATA
    MOV DS,AX
    MOV AX,90H
    MOV BX,50H
    CMP AX,BX
    JG  IMPRIME_AX
    JE IGUAL
    MOV CX,BX
    MOV AH,09
    MOV DX,OFFSET MSG_BX
    INT 21H
    JMP FIM
    IMPRIME_AX:
        MOV CX,AX
        MOV AH,09
        MOV DX,OFFSET MSG_AX
        INT 21H
    IGUAL:
        MOV AH,09
        MOV DX,OFFSET MSG_IGUAL
        INT 21H
    FIM:
        MOV AH,4CH
        INT 21H
main endp
END MAIN