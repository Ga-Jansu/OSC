TITLE Vetor_Matriz
.MODEL SMALL
.DATA
    VETOR DB 1,1,1,2,2,2
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,6    ;Inicia o contator(CX) com 6
    XOR DI,DI   ;Inicia o ponteiro BX como 0
    VOLTA:
        MOV DL,VETOR[DI]    ;Copia o que esta na posição DI do vetor para DL
        INC DI         ;Move para a proxima posição
        ADD DL,30H     ;Transforma o numero para caracter
        MOV AH,02   ;Imprime o caracter
        INT 21H
        LOOP VOLTA
    MOV AH,4CH  ;Saida para o DOS
    INT 21H
MAIN ENDP
END MAIN