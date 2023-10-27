TITLE Vetor_Matriz
.MODEL SMALL
.DATA
    VETOR DB 1,1,1,2,2,2
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,6        ;Inicia o contator(CX) com 6
    LEA BX,VETOR    ;BX aponta para o primeiro elemento do VETOR
    VOLTA:
        MOV DL,[BX]     ;Copia o elemento na posição 0 do vetor para DL
        INC BX      ;Vai para a posição seguinte do vetor
        ADD DL,30H  ;Transforma o numero para caracter
        MOV AH,02   ;Imprime o caracter
        INT 21H
        LOOP VOLTA 
    MOV AH,4CH  ;Saida para o DOS
    INT 21H
MAIN ENDP
END MAIN