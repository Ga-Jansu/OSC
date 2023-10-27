.MODEL SMALL
.CODE
MAIN PROC
    MOV CX,8
    XOR BL,BL
    MOV AH,01
    INT 21H
    VOLTA:
        CMP AL,0DH
        JE IMPRIMIR
        AND AL,0FH
        SHL BL,1
        OR BL,AL
        INT 21H
        LOOP VOLTA
    IMPRIMIR:
        ADD BL,30H
        MOV AH,02
        MOV DL,BL
        INT 21H
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN