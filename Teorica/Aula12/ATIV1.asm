TITLE ENTRADADECIMAL
.MODEL SMALL
.CODE
MAIN PROC
    XOR BX,BX
    XOR CX,CX
    MOV AH,01
    INT 21H
    CMP AL,'-'
    JE @NEGT
    CMP AL,'+'
    JE @POS
    JMP REPEAT
    @NEGT:
        MOV CL,1
    @POS:
        INT 21H
    REPEAT:
        CMP AL,'0'
        JNGE @NODIG
        CMP AL,'9'
        JNLE @NODIG
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
        MOV AH,4CH
        INT 21H
MAIN ENDP
END MAIN