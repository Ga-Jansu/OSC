.MODEL SMALL
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    ler:
        MOV AH,01
        INT 21H
        CMP AL,13
        JE FIM
        MOV CL,AL
        AND CL,0DFH
        MOV AH,02
        MOV DL,CL
        INT 21H
        MOV DL,10
        INT 21HZ
        JMP ler
    FIM:
        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN