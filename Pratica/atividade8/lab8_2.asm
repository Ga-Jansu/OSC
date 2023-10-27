TITLE PROGRAMA_ EXEMPLO_ PARA_ MANIPULAÇÃO_ DE_MATRIZES

.MODEL SMALL
.STACK 100H
.DATA
    MATRIZ4X4   DB 1,2,3,4      ;Define matriz
                DB 4,3,2,1
                DB 5,6,7,8
                DB 8,7,6,5
    LINHA DB 13,10,'$'      ;Variavel para pular linha
    
 .CODE
    MAIN PROC
        MOV AX, @DATA   
        MOV DS,AX

        CALL IMPRIME

        MOV AH,4CH  ;saida para a DOS
        INT 21H
    MAIN ENDP

    PULA_LINHA PROC
        LEA DX, LINHA
        MOV AH,9
        INT 21H
        RET
    PULA_LINHA ENDP

    IMPRIME PROC
        XOR SI,SI   ;Zera o contador de linha
        MOV CH,4    ;Inicia o contador para o loop externo
        LADO_FORA:
            MOV AH,2
            MOV CL,4    ;Reset no contador interno (do LADO_DENTRO)
            XOR BX,BX   ;Reset no contador da coluna

        LADO_DENTRO:
            MOV DL, MATRIZ4X4[SI+BX]    ;Coloca em DL o conteudo da matriz
            ADD DL, 30H     ;Transforma o numero em caracter
            INT 21H         ;Imprime
            MOV DL,20H      ;Imprime um espaço
            INT 21H

            INC BX          ;Vai para a proxima coluna
            DEC CL          ;Decrementa o contador e repete
            JNZ LADO_DENTRO
        
        CALL PULA_LINHA     ;Pula linha
        ADD SI,4        ;Pula para a proxima linha
        DEC CH          ;Decrementa o contador externo e repete enquanto não for 0
        JNZ LADO_FORA   
        RET             ;Retorna para o main
    IMPRIME ENDP
END MAIN