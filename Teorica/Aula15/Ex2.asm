.MODEL SMALL
.STACK 100h
.DATA
    STRING DB 'Matheus eh gay'
    NUM EQU 14
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    CALL IMPRIME

    MOV AH,4CH
    INT 21H
MAIN ENDP
IMPRIME PROC
    PUSH AX
    PUSH DX
    PUSH SI

    MOV CX,NUM
    LEA SI,STRING
    MOV AH,02
    CLD
    @IMPRIME:
        LODSB
        MOV DL,AL
        INT 21H
        LOOP @IMPRIME
    POP SI
    POP DX
    POP AX
    RET
IMPRIME ENDP
END MAIN