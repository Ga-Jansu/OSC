.MODEL SMALL
.STACK 100H
.DATA       ;Mensagens para o usuario
    LINHA DB 10,13,'$'      
    MSG_ENTRADA DB 10,13,' Em qual base vai querer a entrada?$'
    MSG_SAIDA DB 10,13,' Em qual base vai querer a saida?$'
    MSG_BASE    DB 10,13,9,'| 1 - Binario     |'
                DB 10,13,9,'| 2 - Decimal     |'
                DB 10,13,9,'| 3 - Hexadecimal |'
                DB 10,13,10,13,'Resposta: $'
    SINAL DB 10,13,'Positivo ou negativo? : $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG_ENTRADA    ;Seto a MSG_Entrada pra ja printar na fumção de Menu  
    CALL Menu               
    CMP AL,'1'             ;Verifica qual opção o usuario escolheu
    JNE @Ent2           ;Se nao for binario pula pra Ent2
    CALL ENTBINA        ;Se for so da call na entrada de binario e da jump para o menu de saida
    JMP MenuSaida
    @Ent2:
        CMP AL,'2'      ;Verifica se é decimal
        JNE @Ent3       ;Se nao for binario pula pra Ent3
        CALL ENTDEC     ;Se for so da call na entrada de decimal e da jump para o menu de saida
        JMP MenuSaida
    @Ent3: CALL ENTHEXA     ;So da call na entrada de hexa

    MenuSaida:
        CALL PULA_LINHA
        LEA DX,MSG_SAIDA        ;Seto a MSG_Saida pra ja printar na fumção de Menu    
        CALL Menu
        CMP AL,'1'          ;Faço exatamente as mesmas verificações de entrada, unica difença é que vai para a saida de binario, decimal e hexadecimal
        JNE @Sai2
        CALL SAIBINA
        JMP @FimMain
        @Sai2:
            CMP AL,'2'
            JNE @Sai3
            CALL SAIDEC
            JMP @FimMain
        @Sai3: CALL SAIHEXA
    @FimMain:
        MOV AH,4CH      ;Fim do programa
        INT 21H
MAIN ENDP

Menu PROC
    PUSH BX
    PUSH CX

    MOV AH,09       ;Print do menu
    INT 21H
    LEA DX,MSG_BASE     ;Print das opções de entrada
    INT 21H
    MOV AH,01       ;Leitura da escolha
    INT 21H

    POP CX
    POP BX
    RET
Menu ENDP


PULA_LINHA PROC
        LEA DX, LINHA       ;Função para pular linha
        MOV AH,9
        INT 21H
        RET
PULA_LINHA ENDP

;description
ENTBINA PROC
    PUSH AX
    PUSH CX
    PUSH DX
    CALL PULA_LINHA     ;Pula 2 linhas
    CALL PULA_LINHA
    MOV AH,02       ;Printa um '?' dizendo q pode digitar
    MOV DL,'?'
    INT 21H

    MOV CX,16       ;Seta o contador para 16
    XOR BX,BX       ;Zera o registrador de leitura
    MOV AH,01
    
    RepEntBin:
        INT 21H             ;Le um caracter
        CMP AL,0DH          ;Verifica se é enter
        JE @FimEntBin       ;Se for sai da função
        AND AL,0FH          ;Se nao for transforma em 
        SHL BX,1           ;Move o BX uma casa pra direita e escreve o que foi digitado em BL
        OR BL,AL
        LOOP RepEntBin      ;Repete
    @FimEntBin:     ;Saida da função
        POP DX
        POP CX
        POP AX
        RET
ENTBINA ENDP

ENTDEC PROC
    PUSH AX
    PUSH CX
    PUSH DX
    CALL PULA_LINHA     ;Pula 2 linhas
    CALL PULA_LINHA

    MOV AH,09       
    LEA DX,SINAL
    INT 21H

    XOR BX,BX       ;Zera o registrador de leitura
    XOR CX,CX       ;Zera o registrador de sinal, vai guardar se é negativo(1) ou positivo(0)
    MOV AH,1        ;Solicita o sinal
    INT 21H

    CMP AL,'-'      ;Verifica se o numero é negativo ou positivo
    JE @NEGATIVO
    CMP AL,'+'
    JE @POSITIVO

    CALL PULA_LINHA1
    MOV AH,02       ;Caso ele n digite nem + ou - so continua o codigo
    MOV DL,'?'      ;Printa um '?' dizendo q pode digitar
    INT 21H
    MOV AH,01       ;Le caracter
    INT 21H
    JMP @RepEntDec      ;Pula para a leitura
    @NEGATIVO: MOV CX,1     ;Se for negativo ele muda o registrador de sinal
    @POSITIVO:
        CALL PULA_LINHA 
        MOV AH,02       ;Printa um '?' dizendo q pode digitar
        MOV DL,'?'
        INT 21H
        MOV AH,01       ;Le caracter
        INT 21H
    
    @RepEntDec:
        AND AX,000FH    ;Transforma o caracter em numero
        PUSH AX         ;Guarda
        ;Faz o 'total = 10 x total + valor binário'
        MOV AX,10       
        MUL BX          ; -> AX = total x 10
        POP BX          ;Volta o valor original em BX
        ADD BX,AX       ; -> BX = (total x 10) + digito
        MOV AH,01       ;Le caracter
        INT 21H
        CMP AL,13
        JNE @RepEntDec      ;Repete enquanto não der enter
    OR CX,CX        ;Verifica se CX é 0 ou nao
    JE @FimEntDec       ;Se for, quer dizer que é positivo e ja pula pro final
    NEG AX      ;Se for negativo ele inverte o valor

    @FimEntDec:      ;Saida da função
        POP DX
        POP CX
        POP AX
        RET        
ENTDEC ENDP

;description
ENTHEXA PROC
    PUSH AX
    PUSH CX
    PUSH DX
    CALL PULA_LINHA     ;Pula 2 linhas
    CALL PULA_LINHA
    MOV AH,02           ;Printa um '?' dizendo q pode digitar
    MOV DL,'?'
    INT 21H

    XOR BX,BX       ;Zera o registrador de armazenamento
    MOV CH,4        ;Seta o contador pra previnir de não passar de 16 bits
    MOV CL,4        ;Seta o registrador como 4 para dar o ROL, para executar mais rapidamente
    MOV AH,01

    @RepEntHexa:
        INT 21H         ;Le caracter
        CMP AL,0DH      
        JE @FimEntHexa      ;Verifica se é enter, se for vai para o final
        CMP AL,39H          ;Verifica se é numero ou letra
        JG @RepEntLetra     ;Se for letra vai para o procedimento de Letra
        AND AL,0Fh          ;Se for numero ele transforma o caracter em numero e pula para o deslocamento
        JMP @RepEntHexaDesloca
    @RepEntLetra:   SUB AL,37H      ;Transforma o caracter(letra) em numero
    @RepEntHexaDesloca:
        SHL BX,CL       ;Desloca BX 4 casas para esquerda para incluir o numero lido
        OR BL,AL        ;Insere o numero em BL
        DEC CH          ;Decrementa o contador, e repete enquanto não for zero
        JNZ @RepEntHexa
    
    @FimEntHexa:        ;Saida da função
        POP DX  
        POP CX
        POP AX
        RET
ENTHEXA ENDP

;description
SAIBINA PROC
    PUSH AX
    PUSH CX
    PUSH DX
    CALL PULA_LINHA     ;Pula 2 linhas
    CALL PULA_LINHA

    MOV CX,16       ;Seta o contador com 16
    MOV AH,02
    RepSaiBin:
        ROL BX,1    ;Rotaciona o BX 1 casa, assim o numero é copiado no carry
        JNC @SaiBin2        ;Verifica o carry, se nao for 1 ele pula para a SaiBin3
        MOV DL,31H      ;Seta DL como 1 e pula para imprimir
        JMP @SaiBin3

    @SaiBin2:   MOV DL,30H      ;Seta DL como 0

    @SaiBin3: 
        INT 21H     ;Imprime e faz o loop
        LOOP RepSaiBin
    
        POP DX  ;Saida da função
        POP CX
        POP AX
        RET

SAIBINA ENDP

;description
SAIDEC PROC
    PUSH CX
    PUSH DX
    CALL PULA_LINHA     ;Pula 2 linhas
    CALL PULA_LINHA

    OR AX,AX        ;Verifica se AX é menor que 0
    JGE @AUX        ;Se for maior ele ja vai para printar
    PUSH AX
    MOV AH,02       ;Se for menor que 0:
    MOV DL,'-'      ;Printa o simbolo de negativo e inverte AX de novo
    INT 21H
    POP AX
    NEG AX

    @AUX:
        XOR CX,CX   ;Reset do contador de digitos
        MOV BX,10   ;Seto o divisor

    @RepSaiDec:
        XOR DX,DX   ;Prepara a parte alta do dividendo
        DIV BX      ;Divide o valor por 10
        PUSH DX     ;Guarda o resto na pilha
        INC CX      ;Aumenta um digito
        OR AX,AX        ;Repte enquanto o quociente nao for 0
        JNE @RepSaiDec

    MOV AH,02
    @ImprimeSaiDec:
        POP DX      ;Desempilha o numero em DL
        OR DL,30H       ;Transforma em caracter e imprime
        INT 21H
        LOOP @ImprimeSaiDec     ;Repete na quantidade de digitos que contou
    
    POP DX      ;Saida da função
    POP CX
    RET
SAIDEC ENDP

;description
SAIHEXA PROC
    PUSH AX
    PUSH CX
    PUSH DX
    CALL PULA_LINHA     ;Pula 2 linhas
    CALL PULA_LINHA

    MOV CH,4        ;Seta o contador pra fazer printar 16 bits
    MOV CL,4        ;Seta o registrador como 4 para dar o ROL, para executar mais rapidamente
    MOV AH,02
    
    @RepSaiHexa:
        MOV DL,BH       ;Move os 8 primeiros digitos para DL
        SHR DL,CL       ;Move DL 4 casas par pegar os 4 primeiros
        CMP DL,10       ;Verifica se é numero ou letra
        JAE @RepSaiHexaConverte     ;Se for letra ele vai para o procedimento de converter
        ADD DL,30H      ;Se for numero transfroma em caracter e pula para imprimir
        JMP @RepSaiHexa2
    @RepSaiHexaConverte:   ADD DL,37H       ;Transforma o numero em sua respectiva letra para Hexa
    @RepSaiHexa2:
        INT 21H     ;Imprime o caracter
        ROL BX,CL   ;Rotaciona BX 4 casas para os proximos 4 bits
        DEC CH      ;Decrementa o contador
        JNZ @RepSaiHexa     ;Enquanto não for 0 volta o loop

    @FIMHEXA:           ;Saida da função
        POP DX
        POP CX
        POP AX
        RET
SAIHEXA ENDP

END MAIN