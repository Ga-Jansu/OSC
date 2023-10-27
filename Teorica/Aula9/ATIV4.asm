.MODEL SMALL
.CODE
MAIN PROC
    MOV AH,01
    XOR CL,CL
    LER:
        INT 21H
        CMP AL,13
        JE FIM
        INC CL
        JMP LER
    FIM:
        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN