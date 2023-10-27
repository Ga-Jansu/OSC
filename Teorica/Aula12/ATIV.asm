MODEL SMALL
.CODE
MAIN PROC

MAIN ENDP

ENTRADA PROC
    PUSH BX
    PUSH CX
    PUSH DX

    MOV DL,'?'
    MOV AH,02
    INT 21H

    MOV AH,01
    INT 21H

    CMP AL,'-'
    JE @NGT
    CMP AL,'+'
    JE @POS
    JMP REPEAT
    @NGT:
        MOV CL,1
    @POS:
        INT 21H
    @REPEAT:
        AND AX,000FH
        PUSH AX
        MOV AX,10
        MUL BX
        POP BX
        ADD BX,AX
        MOV AH,01
        INT 21H
        CMP AL,13
        JNE REPEAT
    MOV AX,BX
    OR CX,CX
    JE @SAI
    NEG AX
    @SAI:
        POP DX
        POP BX
ENTRADA ENDP


END MAIN