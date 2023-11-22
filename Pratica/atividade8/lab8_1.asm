.MODEL SMALL
.STACK 100H
.DATA
    ENTRADA DB "Digite um vetor de 7 posicoes: $"   ;Mensagens para o usuario
    INVERSO DB 10,13,"O inverso eh: $"
    VETOR DB 7 DUP (?)      ;Criando o vetor com 7 elementos zerados
    MESSAGE DB 'Hello, World!$' ; String a ser impressa, terminada com 0
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    CALL LERVET
    CALL OLA
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

OLA  PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AH, 0 ; Seta o modo de vídeo para 80x25 texto, 16 cores

    MOV AL, 16 ; AL deve ser igual a AH

    INT 10h ; Chama a BIOS de vídeo

    MOV AH, 0Ch ; Seta a função para escrever um pixel
    MOV AL, 4 ; Escolhe a cor roxa (azul 1 e vermelho 1)
    MOV CX, 1 ; Coluna inicial da caixa
    MOV DX, 1 ; Linha inicial da caixa
    MOV BX, 320 ; Comprimento da caixa (largura da tela)

    ; Desenha a linha superior da caixa roxa
    DrawTop:
    MOV SI, BX ; Salva o comprimento da caixa em SI
    DrawTopLine:
    INT 10h ; Desenha o pixel na posição atual
    INC CX ; Avança para a próxima coluna
    DEC SI ; Decrementa o contador da linha
    JNZ DrawTopLine ; Continua a desenhar a linha superior

    ; Desenha a linha inferior da caixa roxa
    MOV SI, BX ; Salva o comprimento da caixa em SI
    MOV CX, 1 ; Coluna inicial da caixa
    MOV DX, 321 ; Linha final da caixa

    DrawBottom:
    MOV SI, BX ; Salva o comprimento da caixa em SI
    DrawBottomLine:
    INT 10h ; Desenha o pixel na posição atual
    INC CX ; Avança para a próxima coluna
    DEC SI ; Decrementa o contador da linha
    JNZ DrawBottomLine ; Continua a desenhar a linha inferior

    ; Desenha os lados da caixa roxa
    MOV SI, 320 ; Salva a largura da tela em SI
    MOV CX, 1 ; Coluna inicial da caixa
    MOV DX, 2 ; Linha inicial da caixa

    DrawSides:
    MOV SI, 320 ; Salva a largura da tela em SI
    MOV AH, 0Ch ; Seta a função para escrever um pixel
    MOV AL, 4 ; Escolhe a cor roxa (azul 1 e vermelho 1)
    MOV BX, DX ; Salva a linha atual em BX

    DrawSide:
    INT 10h ; Desenha o pixel na posição atual
    INC CX ; Avança para a próxima coluna
    INC DX ; Avança para a próxima linha
    DEC SI ; Decrementa o contador da altura
    JNZ DrawSide ; Continua a desenhar o lado da caixa roxa

    MOV DX, BX ; Restaura a linha atual a partir de BX
    INC DX ; Avança para a próxima linha
    DEC SI ; Decrementa o contador da altura
    JNZ DrawSides ; Continua a desenhar os lados da caixa roxa

    ; Printa a mensagem na caixa roxa
    MOV AH, 9 ; Seta a função para imprimir uma string
    MOV DX, offset MESSAGE ; Ponteiro para a string a ser impressa
    INT 21h ; Chama a função de interrupção do DOS

    POP DX
    POP CX
    POP BX
    POP AX
    RET
OLA ENDP
END MAIN