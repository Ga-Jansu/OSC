.MODEL SMALL
.STACK 100H
.DATA
    RESULTADO DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    LEA SI,RESULTADO
    MOV AX,3    ;MULTIPLICANDO
    MOV CX,2    ;MULTIPLICADOR
    CALL MULTI
    MOV DX,[SI]
    CALL IMPRIMIR
    MOV AH,4CH
    INT 21H
MAIN ENDP

MULTI PROC
;DESCRIÇÃO:     AX - MULTIPLICANDO
;               CX - MULTIPLICADOR
;               SI - RESULTADO
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI

    JCXZ FIM
    XOR BX,BX
    AUX:
        ADD BX,AX
        LOOP AUX
    MOV WORD PTR[SI],BX
    FIM:
        POP SI
        POP CX
        POP BX
        POP AX
    RET
MULTI ENDP

IMPRIMIR PROC
    PUSH AX
    PUSH BX
    ADD BX,30H
    MOV AH,02
    INT 21H
    POP BX
    POP AX
    RET
IMPRIMIR ENDP

END MAIN