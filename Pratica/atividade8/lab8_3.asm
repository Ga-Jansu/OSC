.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 10,13,'Digite um numero entre 0 a 6: $'      ;Mensagens para o usuario
    ERRO DB 10,13,'O numero digitado nao esta entre 0 e 6! Digite novamente$'
    SOMA DB 10,13,'A soma de todos elementos da matriz eh: $'
    MATRIZ4X4   DB 4 DUP (?)      ;Define matriz 4x4 vazia
                DB 4 DUP (?)   
                DB 4 DUP (?)   
                DB 4 DUP (?)
    LINHA DB 13,10,'$'          ;Variavel para pular linha

.CODE
MAIN PROC
    MOV AX, @DATA   
    MOV DS,AX

    CALL LERMATRIZ          ;Chamada para ler a matriz
    CALL IMPRIMIRMATRIZ     ;Chamada para imprimir a matriz
    MOV AH,09               ;Print ad mensagem de soma
    LEA DX,SOMA
    INT 21H
    CALL SOMAMATRIZ         ;Chamada para soma dos elementos da matriz
    
    MOV AH,4CH  ;saida para a DOS
    INT 21H
MAIN ENDP


PULA_LINHA PROC
        LEA DX, LINHA
        MOV AH,9
        INT 21H
        RET
PULA_LINHA ENDP

LERMATRIZ PROC
    PUSH AX         ;Salvo os elementos dos registradores
    PUSH BX
    PUSH CX
    PUSH DX

    XOR SI,SI       ;Zera o contador de linha
    MOV CH,4        ;Inicia o contador para o loop externo

    EXTERNO:
        XOR BX,BX   ;Reset no contador da coluna
        MOV CL,4    ;Reset no contador interno 
    
    INTERNO:
        MOV AH,09       ;Imprimo a mensagem pedindo a entrada de um numero
        LEA DX,MSG
        INT 21H
        MOV AH,01       ;Leio o caracter
        INT 21H
        
        CMP AL,'0'       ;Comparo com o '0', se nao for maior ou igual a 0 vai pedir de novo
        JNGE @FORA
        CMP AL,'9'        ;Comparo com o '6', se nao for menor ou igual a 6 vai pedir de novo
        JNLE @FORA        
        
        MOV MATRIZ4X4[SI+BX],AL     ;Coloco o valor digitado na matriz
        INC BX      ;Pulo para a prox coluna
        CALL PULA_LINHA         ;Pulo uma linha
        DEC CL          ;Decremento o contador interno e volta se nao for 0
        JNZ INTERNO

        ADD SI,4    ;Quando acaba o loop interno, vai pular para a proxima linha
        DEC CH      ;Decrementar o contador externo e repetir ate ser 0
        JNZ EXTERNO
    
    POP DX      ;Retorno os elementos dos registradores
    POP CX
    POP BX
    POP AX
    RET         ;Volta para a main

    @FORA:
        MOV AH,09       ;Imprime a mensagem de erro (de nao ser entre 0 e 6)
        LEA DX,ERRO
        INT 21H
        CALL PULA_LINHA
        JMP INTERNO     ;Volta para o loop interno
LERMATRIZ ENDP

IMPRIMIRMATRIZ PROC
    PUSH AX         ;Salvo os elementos dos registradores
    PUSH BX
    PUSH CX
    PUSH DX

    CALL PULA_LINHA     ;Pula 2 linhas
    CALL PULA_LINHA
    XOR SI,SI       
    MOV CH,4
    LADO_FORA:
            MOV AH,2
            MOV CL,4    ;Reset no contador interno (do LADO_DENTRO)
            XOR BX,BX   ;Reset no contador da coluna

        LADO_DENTRO:
            MOV DL, MATRIZ4X4[SI+BX]    ;Coloca em DL o conteudo da matriz
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


    POP DX      ;Retorno os elementos dos registradores
    POP CX
    POP BX
    POP AX
    RET
IMPRIMIRMATRIZ ENDP

SOMAMATRIZ PROC
    PUSH AX         ;Salvo os elementos dos registradores
    PUSH BX
    PUSH CX
    PUSH DX

    XOR SI,SI       ;Zera o contador de linha
    XOR AX,AX       ;Zero o AX para a divisao
    MOV CH,4        ;Inicia o contador para o loop externo
    @REP1:
        XOR BX,BX       ;Reset no contador da coluna
        MOV CL,4        ;Reset no contador interno (do @REP2)
    @REP2:
        MOV DL,MATRIZ4X4[SI+BX]     ;Coloco o valor em DL
        SUB DL,30H              ;Transformo em numero
        ADD AL,DL           ;Faço a adição em AL

        INC BX          ;Vai para a proxima coluna
        DEC CL          ;Decrementa o contador e repete ate ser 0
        JNZ @REP2
    ADD SI,4        ;Pula para a proxima linha
    DEC CH          ;Decrementa o contador externo e repete enquanto não for 0
    JNZ @REP1

    XOR CX,CX       ;Zero o contador de digitos da soma
    MOV BX,10       ;Coloco o divisor como 10
    EMPILHA:
        XOR DX,DX       ;Zero pra onde o  resto vai vir
        DIV BX          ;Faço a divisao
        PUSH DX         ;Empilho o resto
        INC CX          ;Incremento o contator de digitos
        OR AX,AX        ;Verifico se o dividendo zerou
        JNE EMPILHA
    MOV AH,2
    IMPRIME:
        POP DX      ;Desempilho o valor
        OR DL,30H   ;Transformo em caracter
        INT 21H     ;Imprimo
        LOOP IMPRIME

    POP DX      ;Retorno os elementos dos registradores
    POP CX
    POP BX
    POP AX
    RET
SOMAMATRIZ ENDP
END MAIN