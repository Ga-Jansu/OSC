.MODEL SMALL
PULA MACRO
    MOV AH,02
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    ENDM
.DATA
    STRING DB 35 DUP(?),'$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    CLD

    CALL LER
    PULA
    PULA
    MOV AH,09
    LEA DX,STRING
    INT 21H

    MOV AH,4CH
    INT 21H
MAIN ENDP
LER PROC
    MOV AH,02
    MOV DL,'?'
    INT 21H
    LEA DI,STRING
    MOV AH,01
    REPEAT:
        INT 21H
        CMP AL,13
        JE FIM
        STOSB
        JMP REPEAT
    FIM:
        RET
LER ENDP
END MAIN