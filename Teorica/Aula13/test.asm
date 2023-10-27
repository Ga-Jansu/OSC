MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    XOR CX,CX ; contador de d?gitos
    MOV BX,10 ; divisor
    XOR AX,AX
    MOV AL,192

    @REP1:
        XOR DX,DX ; prepara parte alta do dividendo DIV BX ; AX = quociente , DX = resto
        DIV BX
        PUSH DX ; salva resto na pilha
        INC CX ; contador = contador +1
        
        OR AX,AX ; quociente = 0?
        JNE @REP1 ; nao, continua

        ; converte digito em caractere
        MOV AH,2
        ; for contador vezes
    @IMP_LOOP:
        POP DX ; digito em DL
        OR DL,30H
        INT 21H
        LOOP @IMP_LOOP
        ; fim do for
   
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN