TITLE ativ_1
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    MOV AH,02
    MOV DL,'?'
    INT 21H
    XOR CX,CX
    MOV AH,01
    LER:
        INT 21H
        CMP AL,0DH
        JE SAI
        PUSH AX
        INC CX
        JMP LER
    SAI:
        JCXZ FIM
        MOV AH,02
    PRINT:
        POP DX
        INT 21H
        LOOP PRINT
    FIM:
        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN