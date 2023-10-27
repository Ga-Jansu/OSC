.MODEL SMALL
.DATA
    MSG DB "Digite um numero: $"
    MSG2 DB 10,13,"Seu numero eh par$"
    MSG3 DB 10,13,"Seu numero eh impar$"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,8
    XOR BL,BL
    MOV AH,09
    LEA DX,MSG
    INT 21H
    MOV AH,01
    INT 21H
    AND AL,0FH
    VOLTA:
        SHL AL,1
        JNC SALTA
        INC BL
    SALTA:
        LOOP VOLTA
    MOV AH,09
    TEST BL,0FH
    JZ NUMPAR
    LEA DX,MSG3
    NUMPAR:
        LEA DX,MSG2
    INT 21H
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN