TITLE divisao
.MODEL SMALL
.DATA
    MSG_DIVIDENDO DB "Digite o dividendo: $"        ;Mensagens para o usuario
    MSG_DIVISOR DB 10,13,"Digite o divisor: $"
    MSG_QUOCIENTE DB 10,13,"O quociente eh: $"
    MSG_RESTO DB 10,13,"O resto eh: $"
    MSG_ZERO DB 10,13,"Eh impossivel dividir qualquer numero por 0!!$"
.CODE
main PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV AH,09
    LEA DX,MSG_DIVIDENDO
    INT 21H
    MOV AH,01       ;Leitura do dividendo
    INT 21H
    MOV BL,AL       ;Armazenando em BL
    SUB BL, 48      ;Subtraindo 48, para transformar em numero real, em vez de decimal
    MOV AH,09
    LEA DX,MSG_DIVISOR
    INT 21H         ;Leitura do divisor
    MOV AH,01
    INT 21H
    MOV BH,AL       ;Armazenando em BH
    SUB BH, 48      ;Subtraindo 48, para transformar em numero real, em vez de decimal
    MOV CL,0        ;Definindo o quociente como 0
    CMP BH,0        ;Verificação do divisor ser 0, se for pula para o rotulo ZERO
    JE ZERO
    CMP BH,BL       ;Verificação do divisor ser maior que o dividendo, pula direto pro IMPRIMIR
    JG IMPRIMIR     ;Se for menor ou igual ele so continua para a divisao
    DIVISAO:
        CMP BL,BH   ;Vai comparar para verificar se consegue subtrair mais
        JL IMPRIMIR  ;Se conseguir, vai repetir
        SUB BL,BH   ;A função vai subtrair o dividendo pelo divisor
        INC CL      ;A cada subtração vai incrementar o quociente
        JMP DIVISAO
    IMPRIMIR:
        MOV AH,09
        LEA DX,MSG_QUOCIENTE
        INT 21H         ;Impressao do quociente
        ADD CL,48       ;Adicionando 48 no quociente, para transformar em decimal
        MOV AH,02
        MOV DL,CL
        INT 21H
        MOV AH,09
        LEA DX,MSG_RESTO    ;Impressao do resto
        INT 21H
        ADD BL,48       ;Adicionando 48 no resto, para transformar em decimal
        MOV AH,02
        MOV DL,BL
        INT 21H
        JMP FIM
    ZERO:
        MOV AH,09       ;Imprime a mensagem
        LEA DX,MSG_ZERO
        INT 21H
    FIM:
        MOV AH,4CH      ;Finalização do programa
        INT 21H
main ENDP
END MAIN