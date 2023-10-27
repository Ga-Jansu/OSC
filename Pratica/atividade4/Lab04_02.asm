TITLE lab04_02
.MODEL SMALL
.DATA
    LF EQU 10   ;Constante para pular a linha
.CODE
main proc
    MOV CX,50    ;Setando o contador
    MOV DL,'*'  ;Deixar o '*' em DL
    MOV AH,02
    MESMALINHA: ;Loop para imprimir o '*'
        INT 21H
        LOOP MESMALINHA 
    MOV CX,50    ;Resetando o contador
    PROXIMALINHA:   ;Loop para fazer exatamente o mesmo que a anterior, mas pulando linha
        MOV DL,LF   ;Pula linha
        INT 21H
        MOV DL,'*'
        INT 21H
        LOOP PROXIMALINHA
    MOV AH,4CH  ;Finalização do programa
    INT 21H

main endp
END MAIN