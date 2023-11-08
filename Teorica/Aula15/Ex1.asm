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
    PUSH AX
    PUSH DI
    XOR BX,BX
    MOV AH,02
    MOV DL,'?'
    INT 21H
    LEA DI,STRING
    MOV AH,01
    INT 21H
    
    REPEAT:
        CMP AL,13
        JE FIM
        CMP AL,8h
        JNE CARACTER
        DEC DI
        DEC BX
        JMP @LER 
    CARACTER:
        STOSB
        INC BX
    @LER:
        INT 21H
        JMP REPEAT
    FIM:
        POP DI
        POP AX 
        RET
LER ENDP
END MAIN