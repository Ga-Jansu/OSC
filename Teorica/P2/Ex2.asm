.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 9,'Digite o nome: $'
    STR DB 10 DUP (?)
    TAM EQU 10
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    XOR CX,CX
    LEA SI,STR
    CALL LER
    
    MOV AH,02
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H

    LEA SI,STR
    CALL INICIAIS


    MOV AH,4CH
    INT 21H
MAIN ENDP

LER PROC
    MOV AH,09
    LEA DX,MSG
    INT 21H
    MOV CX,TAM
    MOV AH,01
    REPEAT:
        INT 21H
        CMP AL,13
        JE SAI
        MOV [SI],AL
        INC SI
        LOOP REPEAT
    SAI:
        RET
LER ENDP

INICIAIS PROC
    MOV CX,9
    XOR SI,SI
    MOV DL,[SI]
    INT 21H
    INC SI
    _REPEAT:
        CMP STR[SI],20H
        JNE VOLTA
        INC SI
        MOV DL,STR[SI]
        INT 21H
        DEC CX
    VOLTA: 
        INC SI
        LOOP _REPEAT
    RET
INICIAIS ENDP
END MAIN