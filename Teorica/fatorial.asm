.MODEL SMALL
.STACK 100H
.CODE
;description
MAIN PROC
    MOV BX,9
    XOR AX,AX
    CALL SOMA
    CALL SAIDEC
    MOV AH,4CH
    INT 21H
MAIN ENDP

FAT PROC
    PUSH BX
    DEC BX
    JZ VOLTA
    CALL FAT
    VOLTA:
        POP BX
        MUL BX
        RET
FAT ENDP

SOMA PROC
    ADD AX,BX
    DEC BX
    JZ @VOLTA
    CALL SOMA
    @VOLTA: RET
SOMA ENDP

;description
SAIDEC PROC
    PUSH CX
    PUSH DX

    XOR CX,CX   ;Reset do contador de digitos
    MOV BX,10   ;Seto o divisor

    @RepSaiDec:
        XOR DX,DX   ;Prepara a parte alta do dividendo
        DIV BX      ;Divide o valor por 10
        PUSH DX     ;Guarda o resto na pilha
        INC CX      ;Aumenta um digito
        OR AX,AX        ;Repte enquanto o quociente nao for 0
        JNE @RepSaiDec

    MOV AH,02
    @ImprimeSaiDec:
        POP DX      ;Desempilha o numero em DL
        OR DL,30H       ;Transforma em caracter e imprime
        INT 21H
        LOOP @ImprimeSaiDec     ;Repete na quantidade de digitos que contou
    
    POP DX      ;Saida da função
    POP CX
    RET
SAIDEC ENDP
END MAIN