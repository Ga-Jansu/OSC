.MODEL SMALL
.DATA
    PAR DB 10,13,"PAR!$"
    IMPAR DB 10,13,"IMPAR!$"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV AH,01
    INT 21H
    MOV CL,AL
    AND AL,0FH
    TEST CL,01H
    MOV AH,09
    JZ PRINT
    LEA DX,IMPAR
    JMP FIM
PRINT:  LEA DX,PAR
    FIM:
        INT 21H
        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN