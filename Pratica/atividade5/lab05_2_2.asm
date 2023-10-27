.MODEL SMALL
.DATA
    MSG_DIVIDENDO DB "Digite o dividendo: $"        ;Mensagens para o usuario
    MSG_DIVISOR DB 10,13,"Digite o divisor: $"
    MSG_QUOCIENTE DB 10,13,"O quociente eh: $"
    MSG_RESTO DB 10,13,"O resto eh: $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV CL,0
    MOV AH,09
    LEA DX,MSG_DIVIDENDO
    INT 21H
    MOV AH,01
    INT 21H
    MOV BH,AL
    SUB BH,48
    MOV AH,09
    LEA DX,MSG_DIVISOR
    INT 21H
    MOV AH,01
    INT 21H
    MOV BL,AL
    SUB BL,48
    DIVISAO:
        SUB BH,BL
        INC CX
        CMP BH,BL
        JGE DIVISAO
    MOV AH,09
    LEA DX, MSG_QUOCIENTE
    INT 21H
    MOV AH,02
    ADD CL,48
    MOV DL,CL
    INT 21H
    MOV AH,09
    LEA DX,MSG_RESTO
    INT 21H
    MOV AH,02
    ADD BH,48
    MOV DL,BH
    INT 21H
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN