.MODEL SMALL
.CODE
MAIN PROC
    MOV AH,01
    XOR DL,DL
    LER:
        INT 21H
        INC DL
        CMP AL,13
        JNE LER
    MOV AH,02
    INT 21H
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN