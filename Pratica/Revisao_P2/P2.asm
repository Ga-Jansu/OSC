.MODEL SMALL
.STACK 100h
MACRO PULA_LINHA
    PUSH AX
    PUSH DX
    MOV AH,02
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    POP DX
    POP AX
    ENDM
.DATA
    MATRIZ  DW 10,20,30
            DW 30,20,10
            DW 20,30,10
    MATRIZ_DIVISAO  DW 3 DUP(?)
                    DW 3 DUP(?)
                    DW 3 DUP(?)

    MSG_SOMA DB 'A soma de todos os elementos eh: $'
    MSG_MATRIZ_NOVA DB 'A matriz com todos os elementos dividos pela soma eh: $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL SOMA

    MOV AH,4CH
    INT 21H
MAIN ENDP

SOMA PROC
    ;Saida DL -> Soma
    XOR SI,SI
    XOR DX,DX
    MOV CH,3
    @LOOP_FORA:
        XOR BX,BX
        MOV CL,3
    @LOOP_SOMA:
        MOV AX,MATRIZ[SI+BX]
        ADD DX,AX
        INC BX
        DEC CL
        JNZ @LOOP_SOMA
    ADD SI,3
    DEC CH
    JNZ @LOOP_FORA

    RET
SOMA ENDP


DIVIDIR PROC
    
DIVIDIR ENDP

IMPRIMIR PROC

IMPRIMIR ENDP
END MAIN