TITLE lab06_02
.MODEL SMALL
.DATA
    LEITURA DB 10,13,"Digite uma letra: $"      ;Mensagens para o usuario
    IMPRIMIR DB 10,13,"A letra que digitou foi: $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,4    ;Inicialização do contator como no max 4
    LER:
        MOV AH,09
        LEA DX, LEITURA
        INT 21H
        MOV AH,01       ;Leitura do caracter que o usuario digitar
        INT 21H
        MOV BL,AL       ;Armazeno em BL
        CMP BL,'A'      ;Comparo com o 'A', se nao for igual ele pula pra função MINUSCULA
        JNE MINUSCULA
        MOV BL,'*'      ;Se for igual, ja troca pra '*' e pula pra impressao
        JMP IMPRIME
    MINUSCULA:
        CMP BL,'a'  ;Comparo com o 'a', se nao for igual ele pula pra impressao
        JNE IMPRIME
        MOV BL,'*'  ;Se for igual, troca pra '*' e continua a execução pra impressao
    IMPRIME:
        MOV AH,09
        LEA DX, IMPRIMIR
        INT 21H
        MOV AH,02      ;Impressao do caracter digitado (se for a ou A, trocado)
        MOV DL,BL
        INT 21H
        LOOP LER    ;Enquanto o CX for diferente de 0 vai voltar pra LER
    MOV AH,4CH      ;Finalização do programa
    INT 21H
MAIN ENDP
END MAIN