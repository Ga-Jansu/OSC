TITLE lab04_03
.MODEL SMALL
.DATA
    LF EQU 26   ;Constante para o contador
.CODE
main proc
    MOV CX,LF   ;Setando o contador
    MOV DL,'A'  ;Setando DL pra começar pelas maiusculas
    MOV AH,02
    MAIUSCULA:  ;Loop simples pra maiuscula
        INT 21H
        INC DL
        LOOP MAIUSCULA
    MOV DL,10   ;Pular linha
    INT 21H
    MOV CX,LF   ;Resetando o contador
    MOV DL,'a'  ;Setando DL para as minusculas
    MINUSCULA:  ;Loop simples pra minuscula
        INT 21H
        INC DL
        LOOP MINUSCULA
    MOV AH,4CH  ;Finalização do programa
    INT 21H
main endp
END MAIN