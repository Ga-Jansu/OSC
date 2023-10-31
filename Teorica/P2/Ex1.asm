.MODEL SMALL
.STACK 100H
.DATA
    MATRIZ  DB 4 DUP(2)
            DB 4 DUP(2)
            DB 4 DUP(2)
            DB 4 DUP(2)
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL ENTRADA_4
    MOV AH,02
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    CALL SAIDA_4

    MOV AH,4CH
    INT 21H
MAIN ENDP

EXERCICIO1 PROC
    MOV AH,01
    INT 21H
    MOV CX,8
    XOR BH,BH
    REPEAT:
        SHL AL,1
        JNC NADICIONA
        INC BH
    NADICIONA:  LOOP REPEAT
    IMPRIME:
        ADD BH,30H
        MOV AH,02
        MOV DL,BH
        INT 21H

    XOR AL,AL
    RET
EXERCICIO1 ENDP

EXERCICIO3 PROC
    XOR SI,SI
    MOV CH,4
    XOR DL,DL
    FORA:
        XOR BX,BX
        MOV CL,4
        DENTRO:
            CMP CH,CL
            JNE N_ADICIONA
            ADD DL,MATRIZ[SI+BX]
        N_ADICIONA:
            DEC CL
            JNZ DENTRO
        ADD SI,4
        DEC CH
        JNZ FORA
    MOV AH,02
    OR DL,30H
    INT 21H
    XOR AX,AX
    MOV DL,AL

    RET
EXERCICIO3 ENDP

ENTRADA_4 PROC
    ;Digite caracter na base octal e devolver em AX
    XOR BX,BX
    MOV CH,5
    XOR CL,CL
    MOV AH,1
    LER:
        INT 21H
        CMP AL,13
        JE SAI
        AND AL,0FH
        SHL BX,3
        OR BL,AL
        INC CL
        DEC CH
        JNZ LER
    SAI:
        RET
ENTRADA_4 ENDP

SAIDA_4 PROC
    @REPEAT:
        MOV DL,BH
        SHR DL,5
        ADD DL,30H
        INT 21H
        ROL BX,3
        DEC CL
        JNZ @REPEAT
    RET
SAIDA_4 ENDP

END MAIN