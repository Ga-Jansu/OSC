.MODEL SMALL
.DATA
    MSG DB "Digite um vetor de 7 posicoes: $"   ;Mensagens para o usuario
    INVERSO DB 10,13,"O inverso eh: $"
    VETOR DB 7 DUP (?)      ;Criando o vetor com 7 elementos zerados
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    XOR DI,DI   ;Iniciando com 0 o ponteiro do vetor
    MOV CX,7    ;Iniciando o contator de leitura como 7

    MOV AH,09  
    LEA DX,MSG
    INT 21H

    MOV AH,01
    LER:
        INT 21H
        MOV VETOR[DI],AL    ;Le um caracter e ja coloca no vetor na posição que tiver
        INC DI      ;Vai para a proxima posição
        LOOP LER    ;Repete 7x
    
    MOV CX,3    ;Iniciando o contator para inverter como 3
    XOR DI,DI   ;Iniciando um ponteiro para o inicio do vetor
    MOV SI,6    ;Iniciando outro ponteiro para o final do vetor

    INVERTER:
        MOV BH,VETOR[SI]    ;Guarda o valor que esta na posição SI e guarda em BH
        XCHG VETOR[DI],BH   ;Troca o valor de BH com o do vetor na posição DI
        MOV VETOR[SI],BH    ;Devolve para a poição SI o valor de BH(que estava em VETOR[DI])
        INC DI      ;Move DI para a proxima posição
        DEC SI      ;Move SI para a posição anterior
        LOOP INVERTER   ;Repete 3x
    MOV AH,09
    LEA DX,INVERSO
    INT 21H

    MOV CX,7    ;Iniciando o contator para imprimir como 7
    XOR DI,DI   ;Iniciando o ponteiro para o inicio do vetor

    MOV AH,02   
    IMPRIMIR:
        MOV DL,VETOR[DI]    ;Impressao do vetor
        INT 21H
        INC DI      ;Vai para a proxima posição
        LOOP IMPRIMIR
    
    MOV AH,4CH  ;saida para a DOS
    INT 21H
MAIN ENDP
END MAIN
