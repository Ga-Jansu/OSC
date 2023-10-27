.MODEL SMALL
.DATA
    MATRIZ  DW 1,2,3,4
            DW 5,6,7,8
            DW 9,10,11,12
    PULA DB 10,13,'$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    XOR BX,BX
    MOV SI,16
    MOV CX,4
    ZERAR:
        MOV MATRIZ[SI][BX],0
        ADD BX,2
        LOOP ZERAR
    XOR BX,BX
    MOV DI,3
    IMPRIMIR:
        XOR SI,SI
        MOV CX,4
        LINHA:
            MOV DX,MATRIZ[BX][SI]
            OR DX,30H
            MOV AH,02
            INT 21H
            ADD SI,2
            LOOP LINHA
        LEA DX,PULA
        MOV AH,09
        INT 21H
        ADD BX,8
        DEC DI
        JNZ IMPRIMIR
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN