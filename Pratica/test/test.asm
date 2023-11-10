.MODEL SMALL
PULA_LINHA MACRO
    GUARDA_2REG AX,DX
    MOV AH,02
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    SOLTA_2REG AX,DX
    ENDM
TAB MACRO
    GUARDA_2REG AX,DX
    MOV AH,02
    MOV DL,9
    INT 21H
    SOLTA_2REG AX,DX
    ENDM
SPACE MACRO
    GUARDA_2REG AX,DX
    MOV AH,02
    MOV DL,20H
    INT 21H
    SOLTA_2REG AX,DX
    ENDM

GUARDA_1REG MACRO AUX
    PUSH AUX
    ENDM
GUARDA_2REG MACRO AUX,AUX2
    PUSH AUX
    PUSH AUX2
    ENDM
GUARDA_3REG MACRO AUX,AUX2,AUX3
    PUSH AUX
    PUSH AUX2
    PUSH AUX3
    ENDM
GUARDA_4REG MACRO AUX,AUX2,AUX3,AUX4
    PUSH AUX
    PUSH AUX2
    PUSH AUX3
    PUSH AUX4
    ENDM
SOLTA_1REG MACRO AUX
    POP AUX
    ENDM
SOLTA_2REG MACRO AUX,AUX2
    POP AUX2
    POP AUX
    ENDM
SOLTA_3REG MACRO AUX,AUX2,AUX3
    POP AUX3
    POP AUX2
    POP AUX
    ENDM
SOLTA_4REG MACRO AUX,AUX2,AUX3,AUX4
    POP AUX4
    POP AUX3
    POP AUX2
    POP AUX
    ENDM
.DATA
    Nomes   DB 100 DUP(?)        ;Matriz nomes
            ; 1 Nome - posição 0 ate 20
            ; 2 Nome - posição 20 ate 40
            ; 3 Nome - posição 40 ate 60
            ; 4 Nome - posição 60 ate 80
            ; 5 Nome - posição 80 ate 100
    
    Notas   DB 4 DUP(?)         ;Matriz notas + medias
            DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
    
    Cadastro_Aluno DB 0         ;Conntador de quantos alunos foram inseridos, para a impressao
    Cadastro_Nome DB 0           ;Contador de  insersão de  aluno (para saber em qual posição estou)
    Cadastro_Nota DB 0           ;Contador de  insersão de  nota  (para saber em qual linha  estou)

    MSG_MENU    DB ' Escolha uma das opcoes: '
                DB 10,13,9,' 1- Inserir um aluno'
                DB 10,13,9,' 2- Corrigir a nota'
                DB 10,13,9,' 3- Imprimir a tabela'
                DB 10,13,9,' 0- Finalizar o programa'
                DB 10,13,' Opcao escolhida: $'
    
    MSG_CORRIGIR DB 'Digite o nome do aluno que deseja corrigir a nota, escreva exatamente!$'

    MSG_INSERIR_NOME DB 9,'Nome (Max. 20): $'

    MSG_INSERIR_NOTA DB 9,'Nota: $'

    MSG_IMPRESSAO DB 9,'Nome',9,9,'Nota P1',9,9,'Nota P2',9,9,'Nota P3',9,9,'Media$'

    MSG_ERROR DB 9,'Numero digitado invalido!$'

    MSG_ESPACO DB 9,'Limite  de 5 alunos atingido!$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    REPEAT_MENU:
        PULA_LINHA
        MOV AH,09       ;Print Menu
        LEA DX,MSG_MENU
        INT 21H
        MOV AH,01       ;Ler a opção escolhida
        INT 21H
        PULA_LINHA
        CMP AL,'0'      
        JL ERRO         ;Se  menor que 0 ja da erro
        JE FIM          ;Se for igual, ja finaliza
        CMP AL,'3'
        JA ERRO         ;Se  menor que 3 ja da erro
        CMP AL,'1'
        JNE @OPCAO2         ;Se nao for igual a 1, vai para a verificação 2
        CALL INSERIR_ALUNO  ;Se for 1, ja chama a função
        JMP REPEAT_MENU
    @OPCAO2:
        CMP AL,'2'
        JNE @OPCAO3     ;Se nao for igual a 2, vai para a opção 3 automaticamente
        CALL CORRIGIR_NOTAS     ;Se for 2, ja chama a função
        JMP REPEAT_MENU
     @OPCAO3:
        CALL IMPRIMIR_TABELA        ;Consequentemente, chama a função para 3
        JMP REPEAT_MENU
    ERRO:
        PULA_LINHA
        PULA_LINHA
        MOV AH,09           ;Impressao mensagem erro
        LEA DX,MSG_ERROR    
        INT 21H
        PULA_LINHA
        PULA_LINHA
        JMP REPEAT_MENU
    FIM:
        MOV AH,4CH
        INT 21H
MAIN ENDP

INSERIR_ALUNO PROC
    ;   DI -> guardar as posições do nome
    ;   SI -> guarda os cadastros , que sao manipulados por  CL
    ;   CH -> Limitador de caracter
    PULA_LINHA          ;Pula 2 linhas
    PULA_LINHA
    CLD                 ;Seto o DF
    LEA DI,Nomes        ;Seto o DI
    LEA SI,Cadastro_Nome     ;Vejo em qual linha  estou  inserindo
    XOR CX,CX       ;Limpo o CX para saber a posição que estou e somar em DI
    MOV CL,[SI]
    ADD DI,CX
    MOV CH,20           ;Seto o limitador de caracter em 20

    MOV AH,09       
    LEA DX,MSG_INSERIR_NOME     ;Print da mensagem
    INT 21H
    MOV AH,01       ;Ler caracter
    INT 21H

    @INSERIR_NOME:
        CMP AL,0DH      ;Verificar se é ENTER e sair  se for
        JE @AUX_INSERIR
        CMP AL,08h      ;Verifica  se é BACKSPACE, se for vai voltar um na string
        JNE @CARACTER   ;Se nao ele insere na string e repete
        DEC DI
        JMP @VOLTA_LER      ;Le de novo
    @CARACTER:  
        STOSB           ;Guardo  o caracter no vetor de nomes
        DEC CH          ;Decremento o limite do nome, enquanto não for  0, vai repetir
    @VOLTA_LER:
        INT 21H     ;Le outro caracter
        CMP CH,0    ;Verifica se atingiu o limite, se  nao continua
        JNE @INSERIR_NOME
    
    @AUX_INSERIR:       ;Intermediario entre nome e nota
        MOV CH,20
        ADD [SI],CH     ;Seto o contador da inserçãoo de nome para a proxima posição
        LEA SI,Cadastro_Nota
        XOR BX,BX       ;Seto as linhas em BX de acordo com o contador
        MOV BL,[SI]     
        XOR DI,DI       ;Seto colunas
        MOV CH,3       ;Definindo o limitador

    @INSERIR_NOTA:
        PULA_LINHA      ;Pulo 2 linhas
        PULA_LINHA
        MOV AH,09           ;Imprimir mensagem da nota
        LEA DX,MSG_INSERIR_NOTA
        INT 21H     
        MOV AH,01       ;Leio o caracter
        INT 21H
        AND AL,0FH   
        CMP AL,0      ;Verifico se  é um numero, se nao vai pro erro
        JL @ERRO_INSERIR
        CMP AL,9
        JG @ERRO_INSERIR
        MOV Notas[BX+DI],AL     ;Se for numero insiro na matriz
        INC DI                  ;Vou para a proxima coluna
        DEC CH                  ;Decremento o contador limite
        JNZ @INSERIR_NOTA
    
    MOV CH,4
    ADD [SI],CH  ;Pulo o contador de linhas para a proxima linha
    PULA_LINHA
    PULA_LINHA
    RET
    @FIM_SEM_ESPAÇO:
        PULA_LINHA
        MOV AH,09           ;Impressao mensagem erro
        LEA DX,MSG_ESPACO    
        INT 21H
        PULA_LINHA
        RET
    @ERRO_INSERIR:
        PULA_LINHA
        MOV AH,09           ;Impressao mensagem erro
        LEA DX,MSG_ERROR    
        INT 21H
        PULA_LINHA
        JMP @INSERIR_NOTA
INSERIR_ALUNO ENDP

IMPRIMIR_TABELA PROC
    ; CH -> Contador Nome e  para as notas
    ; CL -> Contador para impressao
    ; BX -> Contador de linhas
    PULA_LINHA
    PULA_LINHA
    MOV AH,09
    LEA DX,MSG_IMPRESSAO
    INT 21H
    XOR BX,BX
    LEA SI,Cadastro_Aluno
    MOV CL,[SI]
    PULA_LINHA
    @IMPRIME_GERAL:
        MOV CH,20
        LEA SI,Nomes
        MOV AH,02
        SPACE
        CLD
    @IMPRIME_NOME:
        LODSB
        MOV DL,AL
        INT 21H
        DEC CH
        JNZ @IMPRIME_NOME

    CALL CALCULO_MEDIA
    MOV CH,4
    XOR SI,SI

    @IMPRIME_NOTA:
        TAB
        MOV DL,Notas[BX+SI]
        OR DL,30H
        INT 21H
        INC SI
        DEC CH
        JNZ @IMPRIME_NOTA
    ADD BX,4
    DEC CL
    JNZ @IMPRIME_GERAL
    RET
IMPRIMIR_TABELA ENDP

CALCULO_MEDIA PROC
    ; SI -> Colunas
    ; AX -> Somatoria
    ; DX -> Intermediario para somatoria
    ; BX -> A linha
    ; AL ->dividendo
    GUARDA_4REG AX,BX,CX,DX
    XOR AX,AX
    XOR DX,DX   ;Zerando DX pra somatoria
    MOV CH,4     ;Contador pra somatoria
    XOR SI,SI    ;Reset das colunas
    @SOMA_NOTAS:
        MOV DL,Notas[BX+SI]
        ADD AX,DX
        INC SI
        DEC CH
        JNZ @SOMA_NOTAS
    MOV CH,3    ;Setando divisor
    DIV CH
    MOV Notas[BX+SI],AL     ;Guardo o dividendo na posição da media na matriz de Notas
    SOLTA_4REG AX,BX,CX,DX
    RET
CALCULO_MEDIA ENDP

CORRIGIR_NOTAS PROC
    RET
CORRIGIR_NOTAS ENDP
END MAIN