TITLE lab04_04
.MODEL SMALL
.DATA
    LF EQU 10   ;Constante para pular a linha
.CODE
main proc
    MOV DL,'a'  ;Setando DL pra começar pelas minusculas
    MOV CX,26   ;Começando o contador do alfabeto
    MOV BL,4    ;Começando o contador da quebra de linha
    MOV AH,02
    ALFABETO:   ;Loop para printar
        INT 21H
        INC DL
        DEC BL
        JNZ VOLTAR  ;Enquanto o BL maior que 0 ele vai pra VOLTAR e recomeça o loop
        MOV BL,4    ;Se for igual a 0, ele vai resetar o BL, pular uma linha e continuar o loop
        MOV BH,DL
        MOV DL,LF
        INT 21H
        MOV DL,BH
    VOLTAR:
        LOOP ALFABETO   ;Loop para voltar para o loop ALFABETO ate CX = 0, que no caso vai ter acabado o alfabeto
    MOV AH,4CH  ;Finalização do programa
    INT 21H
main endp
END MAIN