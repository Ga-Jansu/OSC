.MODEL SMALL
PULA_LINHA MACRO      ;Macro para pular linha
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        ENDM
PRINT MACRO AUX     ;Macro para printar
    PUSH AX
    MOV AH,09
    INT 21H
    POP AX
    ENDM
CORTA MACRO         ;Print da divisoria
    PUSH AX
    PUSH DX
    PULA_LINHA
    MOV AH,09
    LEA DX,MSG_CORTA
    INT 21H
    POP DX
    POP AX
    ENDM
.STACK 100h 
.DATA
    STRING DB 'Bruno Ito', 11 DUP(?)  ;String definida, mas como quis fazer de 20 caracteres, completei com espaço vazio pra confirmar se é igual mesmo
    STRING_LIDA DB 20 DUP(?)            ;String que o usuario vai escrever
    STRING_COPIA DB 20 DUP(?)           ;String que vai copiar a lida

    MSG_LER DB 10,13,9,'Digite uma string (Max. 20 caracters): $'       ;Mensagens do usuario
    MSG_CORTA DB '------------------------------------------$'
    MSG_IMPRIMIR DB 10,13,9,'A string digitada foi: $'
    MSG_COPIA DB 10,13,9,'A string copiada foi: $'
    MSG_IGUAL DB 10,13,9,'A string eh igual a ja definida!$'
    MSG_N_IGUAL DB 10,13,9,'A string nao eh igual a ja definida!$'
    MSG_AS DB 10,13,9,'A quantidade de -a- eh de: $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    CALL LER_STRING         ;Na main so chamo os procedimentos e faço a divisoria
    CORTA
    CALL COPIAR_STRING
    CORTA
    CALL VERIFICA_STRING
    CORTA
    CALL QUANTIDADE_STRING

    MOV AH,4CH
    INT 21H
MAIN ENDP
LER_STRING PROC
    ; saida: BX -> Contador de caracter

    XOR BX,BX           ;Zero o contador de caracteres
    LEA DX,MSG_LER
    PRINT DX            ;Printo a mensagem
    MOV CX,20           ;Seto o contador para 20 max
    LEA DI,STRING_LIDA          ;Aponto DI para o começo da string_lida
    CLD                 ;Seto o DF
    MOV AH,01
    INT 21H         ;Leio caracter
    @REP_LER:
        CMP AL,0DH          ;Verifico se é enter, se for termina a leitura
        JE @FIM_LEITURA     
        CMP AL,08h          ;Verifico se é backspace, para corrigir, se nao for pula para @caracter
        JNE @CARACTER
        INC CX              ;Incrementa o contador para que ele seja subtraido denovo no LOOP
        DEC DI          ;Volto DI para a posição interior
        DEC BX          ;Decremento o contador de caracter
        JMP @VOLTA
    @CARACTER:
        STOSB           ;Guardo o caracter na string_lida
        INC BX          ;Incremento o contador de caracter
    @VOLTA:
        INT 21H         ;Leio outro caracter e faço o loop
        LOOP @REP_LER
    
    @FIM_LEITURA:
        PULA_LINHA          
        LEA DX,MSG_IMPRIMIR         ;Pula linha e imprime a mensagem
        PRINT DX
        MOV CX,BX           ;Seto o contador pra contagem de caracter
        LEA SI,STRING_LIDA  ;Faço SI apontar para o começo da string
        MOV AH,02
    
    @IMPRIME:                ;Loop para printar
        LODSB       ;Copio o caracter que SI aponta
        MOV DL,AL       ;Jogo para DL e printo
        INT 21H
        LOOP @IMPRIME
    PULA_LINHA
    RET
LER_STRING ENDP

COPIAR_STRING PROC
    ;Entrada -> BX = contador de caracter
    PULA_LINHA
    MOV CX,BX           ;Seto o contador para o numero de caracter
    LEA SI,STRING_LIDA      ;Aponto SI para a string_lida
    LEA DI,STRING_COPIA     ;Aponto DI para a string_copia
    CLD                     ;Seto o DF
    REP MOVSB           ;Copio a string_lida para a string_copia

    LEA DX,MSG_COPIA        ;Printo a mensagem de copia
        PRINT DX        
        MOV CX,BX       ;Seto o contador para o numero de caracter
        LEA SI,STRING_COPIA     ;Aponto SI para a string_copia
        MOV AH,02
    
    @IMPRIME_COPIA:         ;Loop para printar a string_copia
        LODSB           ;Copio o caracter que SI aponta
        MOV DL,AL        ;Jogo para DL e printo
        INT 21H
        LOOP @IMPRIME_COPIA
    PULA_LINHA
    RET
COPIAR_STRING ENDP

VERIFICA_STRING PROC
    PULA_LINHA
    MOV CX,20       ;Seto o contador pra 20
    
    LEA SI,STRING_LIDA      ;Aponto SI para string_lida
    LEA DI,STRING           ;Aponto DI para a string pré-definida
    REPE CMPSB          ;E comparo enquanto for igual
    JZ @SIM             ;Se for igual pula para @SIM
    
    LEA DX,MSG_N_IGUAL      ;Se nao, coloca o offset da mensagem que nao é igual e pula para printar
    JMP @FIM_VERIFICA
    
    @SIM: LEA DX,MSG_IGUAL      ;Se for, coloca o offset da mensagem que é igual
    
    @FIM_VERIFICA:
        MOV AH,09       ;Printa a mensagem
        INT 21H
    PULA_LINHA
    RET
VERIFICA_STRING ENDP

QUANTIDADE_STRING PROC
    MOV CX,BX       ;Seto o contador para o numero de caracter      
    MOV AL,'a'      ;Coloco o 'a' em AL para comparar
    LEA DI,STRING_LIDA      ;Aponto DI para a string_lida
    XOR DL,DL       ;Zero o contador de 'a'
    CLD     ;Seto o DF

    @QUANTIDADE:
        SCASB       ;Comparo o caracter que esta sendo apontado por DI com o que esta em AL
        JNZ @NAOTEM     ;Se nao for igual so faz o loop
        INC DL          ;Se for igual, incrementa o contador
    @NAOTEM: LOOP @QUANTIDADE

    ADD DL,30H      ;Transformo o numero do contador em caracter
    PUSH DX
             ;Guardo o caracter para printar a mensagem
    LEA DX,MSG_AS       ;Printo a mensagem
    PRINT DX
    POP DX      ;Devolvo o numero

    MOV AH,02       ;Printo o numero
    INT 21H

    PULA_LINHA
    RET
QUANTIDADE_STRING ENDP
END MAIN