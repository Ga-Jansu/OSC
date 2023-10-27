.MODEL SMALL
.STACK 100H
.DATA
    ENTRADA DB "Digite um vetor de 7 posicoes: $"   ;Mensagens para o usuario
    INVERSO DB 10,13,"O inverso eh: $"
    VETOR DB 7 DUP (?)      ;Criando o vetor com 7 elementos zerados
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    CALL LERVET
    CALL INVERTEVET
    CALL IMPRIMIRVET

    MOV AH,4CH  ;saida para a DOS
    INT 21H
MAIN ENDP

LERVET PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR DI,DI   ;Iniciando com 0 o ponteiro do vetor
    MOV CX,7    ;Iniciando o contator de leitura como 7

    MOV AH,09  
    LEA DX,ENTRADA
    INT 21H

    MOV AH,01
    LER:
        INT 21H
        MOV VETOR[DI],AL    ;Le um caracter e ja coloca no vetor na posição que tiver
        INC DI      ;Vai para a proxima posição
        LOOP LER    ;Repete 7x
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
LERVET ENDP

INVERTEVET PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX,3    ;Iniciando o contator para inverter como 3
    XOR DI,DI   ;Iniciando um ponteiro para o inicio do vetor
    MOV SI,6    ;Iniciando outro ponteiro para o final do vetor

    INVERTE:
        MOV BH,VETOR[SI]    ;Guarda o valor que esta na posição SI e guarda em BH
        XCHG VETOR[DI],BH   ;Troca o valor de BH com o do vetor na posição DI
        MOV VETOR[SI],BH    ;Devolve para a poição SI o valor de BH(que estava em VETOR[DI])
        INC DI      ;Move DI para a proxima posição
        DEC SI      ;Move SI para a posição anterior
        LOOP INVERTE   ;Repete 3x

    POP DX
    POP CX
    POP BX
    POP AX
    RET
INVERTEVET ENDP

IMPRIMIRVET PROC
    PUSH AX     ;Armazena o conteudo de todos os registadores na pilha
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH,09
    LEA DX,INVERSO
    INT 21H

    MOV CX,7    ;Iniciando o contator para imprimir como 7
    XOR DI,DI   ;Iniciando o ponteiro para o inicio do vetor

    MOV AH,02   
    IMPRIME:
        MOV DL,VETOR[DI]    ;Impressao do vetor
        INT 21H
        INC DI      ;Vai para a proxima posição
        LOOP IMPRIME

    POP DX      ;Volta com o conteudo de todos os registadores da pilha
    POP CX
    POP BX
    POP AX
    RET         ;Volta para a main
IMPRIMIRVET ENDP
END MAIN