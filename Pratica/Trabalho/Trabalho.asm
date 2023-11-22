.MODEL SMALL
LIMPA_TELA MACRO            ;Macro para limpar tela
    GUARDA_4REG AX,BX,CX,DX
    MOV AX,03h
    INT 10h

    XOR AX,AX
    XOR BX,BX
    XOR CX,CX
    MOV DH,18h
    MOV DL,4Fh
    MOV AH,06h
    INT 10h

    XOR DX,DX
    MOV AH,02h
    INT 10h

    MOV AX,03h
    INT 10H

    SOLTA_4REG AX,BX,CX,DX
    ENDM
PAUSE  MACRO        ;Macro para pausar e esperar o usuario apertar enter
    GUARDA_2REG AX,DX 
    MOV AH,01
    INT 21H
    MOV AH,02h
    MOV DL,08h
    INT 21h
    SOLTA_2REG AX,DX
    ENDM
PULA_LINHA MACRO        ;Macro para pular uma linha
    GUARDA_2REG AX,DX
    MOV AH,02
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    SOLTA_2REG AX,DX
    ENDM
TAB MACRO               ;Macro para dar tab
    GUARDA_2REG AX,DX
    MOV AH,02
    MOV DL,9
    INT 21H
    SOLTA_2REG AX,DX
    ENDM
SPACE MACRO             ;Macro para dar um espaço
    GUARDA_2REG AX,DX
    MOV AH,02
    MOV DL,20H
    INT 21H
    SOLTA_2REG AX,DX
    ENDM
GUARDA_2REG MACRO AUX,AUX2      ;Macro para guardar 2 registradores
    PUSH AUX
    PUSH AUX2
    ENDM
GUARDA_4REG MACRO AUX,AUX2,AUX3,AUX4        ;Macro para guardar 4 registradores
    PUSH AUX
    PUSH AUX2
    PUSH AUX3
    PUSH AUX4
    ENDM
SOLTA_2REG MACRO AUX,AUX2       ;Macro para voltar 2 registradores
    POP AUX2
    POP AUX
    ENDM
SOLTA_4REG MACRO AUX,AUX2,AUX3,AUX4     ;Macro para voltar 4 registradores
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
    
    Notas   DW 4 DUP(?)         ;Matriz notas + medias
            DW 4 DUP(?)
            DW 4 DUP(?)
            DW 4 DUP(?)
            DW 4 DUP(?)
    
    Pesos DB 3 DUP(1)       ;Vetor para armazenar os pesos
    
    Cadastro_Aluno DB 0         ;Contador de quantos alunos foram inseridos, para a impressao e para verificação do limite
    Cadastro_Nome DB 0           ;Contador de  insersão de  aluno (para saber em qual posição estou, na string de Nome)
    Cadastro_Nota DB 0           ;Contador de  insersão de  nota  (para saber em qual linha  estou da matriz)
    Cadastro_Peso DB 0          ;Variavel para saber se faço uma media aritmetica ou ponderada
    Nome_Correcao DB 20 DUP(?)      ;Vetor para a string na função de corrigir nota, para comparar

    MSG_MENU    DB ' Escolha uma das opcoes: '              ;Todas as mensagens de erro ou de inserção e de menu
                DB 10,10,13,9,' 1- Inserir um aluno'
                DB 10,13,9,' 2- Imprimir as notas'
                DB 10,13,9,' 3- Corrigir as notas'
                DB 10,13,9,' 4- Inserir pesos das provas (Automatico fica media aritmetica)'
                DB 10,13,9,' 0- Finalizar o programa'
                DB 10,13,10,' Opcao escolhida: $'
    
    MSG_CORRIGIR DB 'Digite o nome do aluno que deseja corrigir a nota, escreva exatamente!$'

    MSG_INSERIR_DADOS  DB 'Insira  os dados do aluno: $'

    MSG_INSERIR_NOME DB 9,'Nome (Max. 20): $'

    MSG_INSERIR_NOTA DB 9,'Nota: $'

    MSG_INSERIR_PESOS  DB 'Insira  os pesos das provas: $'

    MSG_INSERIR_PESO DB 10,13,9,'Peso P$'

    MSG_IMPRESSAO DB ' Nome',9,9,'Nota P1',9,9,'Nota P2',9,9,'Nota P3',9,9,'Media$'

    MSG_CORRECAO DB '  Digite o nome do aluno que quer a correcao: $'

    MSG_ERROR_NUMERO DB 9,'Numero digitado invalido!$'

    MSG_ESPACO DB 9,'Limite  de 5 alunos atingido!$'

    MSG_ERRO_NOME DB 9,'Nao tem nenhum aluno com esse nome!$'

    MSG_ERRO_NENHUM DB 9,'Nao tem nenhum aluno inserido!$'
.CODE
MAIN PROC
    MOV AX,@DATA            ;Importando o endereço de data para DS e ES
    MOV DS,AX
    MOV ES,AX

    REPEAT_MENU:
        LIMPA_TELA      ;Limpa tela e pula uma linha
        PULA_LINHA
        MOV AH,09       ;Print Menu
        LEA DX,MSG_MENU
        INT 21H
        MOV AH,01       ;Ler a opção escolhida
        INT 21H
        CMP AL,'0'      
        JL ERRO         ;Se  menor que 0 ja da erro
        JE FIM          ;Se for igual, ja finaliza
        CMP AL,'4'
        JA ERRO         ;Se  maior que 4 da erro
        CMP AL,'1'
        JNE @OPCAO2         ;Se nao for igual a 1, vai para a verificação 2
        CALL INSERIR_ALUNO  ;Se for 1, ja chama a função
        JMP REPEAT_MENU
    @OPCAO2:
        CMP AL,'2'
        JNE @OPCAO3     ;Se nao for igual a 2, vai para a verificação 3 
        CALL IMPRIMIR_TABELA     ;Se for 2, ja chama a função
        JMP REPEAT_MENU
     @OPCAO3:
        CMP AL,'3'
        JNE @OPCAO4         ;Se nao for igual a 3, vai para a opção 4 
        CALL CORRIGIR_NOTAS       ;Se for 2, ja chama a função
        JMP REPEAT_MENU
    @OPCAO4:
        CALL PESO       ;Consequentemente, chama a função para 4
        JMP REPEAT_MENU
    ERRO:
        LIMPA_TELA
        MOV AH,09           ;Impressao mensagem erro
        LEA DX,MSG_ERROR_NUMERO    
        INT 21H
        PAUSE
        JMP REPEAT_MENU
    FIM:
        MOV AH,4CH      ;Finalização do codigo
        INT 21H
MAIN ENDP

INSERIR_ALUNO PROC
    ;   DI -> guardar as posições do nome
    ;   SI -> guarda os cadastros , que sao manipulados por  CL
    ;   CH -> Limitador de caracter
    LIMPA_TELA              ;Limpa tela
    CMP Cadastro_Aluno,5    ;Verificalçao se atingiu o limite de alunos
    JNGE @INSERIR           ;Se nao tiver atingido insere normal, se tiver vai para o erro de @FIM_SEM_ESPAÇO
    JMP @FIM_SEM_ESPAÇO
    @INSERIR:
    PULA_LINHA          ;Pula 2 linhas
    MOV AH,09                   ;Print da mensagem
    LEA DX,MSG_INSERIR_DADOS
    INT 21H
    PULA_LINHA      ;Pula 2 linhas
    PULA_LINHA
    CLD                 ;Seto o DF
    LEA DI,Nomes        ;Seto o DI para o vetor de Nomes
    LEA SI,Cadastro_Nome     ;Vejo em qual posição  estou  inserindo
    XOR CH,CH       ;Limpo CH para colocar a posição em DI
    MOV CL,[SI]             ;Pego a posição
    ADD DI,CX       
    MOV CH,20           ;Seto o limitador de caracter em 20

    MOV AH,09       
    LEA DX,MSG_INSERIR_NOME     ;Print da mensagem
    INT 21H
    MOV AH,01       ;Ler caracter
    INT 21H

    @INSERIR_NOME:
        CMP AL,0DH      ;Verificar se é ENTER
        JE @AUX_INSERIR     ;se for sai
        CMP AL,08h      ;Verifica  se é BACKSPACE, se for vai voltar um na string
        JNE @CARACTER   ;Se nao ele insere na string e repete
        SPACE
        GUARDA_2REG AX,DX
        MOV AH,02           ;Printar um espaço e outro backspace para apagar a letra no visor
        MOV DL,08h
        INT 21H
        SOLTA_2REG AX,DX
        DEC DI              ;Volta uma posição do vetor
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
        ADD [SI],CH     ;Seto o contador da inserção de nome para a proxima posição
        LEA SI,Cadastro_Nota        ;Aponto SI para o contador de nota
        XOR BX,BX       ;Seto as linhas em BX de acordo com o contador
        MOV BL,[SI]     ;Coloco em BX a linha que precisa a inserção
        XOR DI,DI       ;Seto colunas
        MOV CH,3       ;Definindo o limitador
        PULA_LINHA      ;Pulo 2 linhas
        PULA_LINHA
    @INSERIR_NOTA:
        MOV AH,09           ;Imprimir mensagem da nota
        LEA DX,MSG_INSERIR_NOTA
        INT 21H
        PUSH BX     ;Guardo em qual linha estou
        XOR BX,BX   ;Seto o total
        MOV DH,2     ;Limite de 2 caracteres
        MOV AH,01       ;Leio o caracter
        INT 21H
    @auxINSERIR_NOTA:
        CMP AL,30H      ;Verifico se  é um numero, se nao vai pro erro
        JGE @continua
        CMP AL,39H
        JLE @continua
        JMP @ERRO_INSERIR
    @continua:
        AND AX,000FH        ;Transformo em numero
        PUSH AX         ;Guardo o numero na pilha
        MOV AX,10       ;Seto o multiplicador
        MUL BX          ;Faço totalx10
        POP BX          ;Volta o numero para bx
        ADD BX,AX       ;Faço o totalx10 + o numero
        CMP BX,1
        JNE @aux2INSERIR_NOTA       ;Se nao for igual a 1 vai ja inserir
        MOV AH,01
        INT 21H         ;Se for um leio outro numero
        CMP AL,13               ;Verifico se é enter, se for guarda a nota e vai para o proximo
        JE @aux2INSERIR_NOTA
        JMP @auxINSERIR_NOTA    ;Se nao, leio de novo
    @aux2INSERIR_NOTA:
        MOV AX,BX           ;Coloco o valor em AX
        POP BX          ;Volto a quantidade de linhas
        MOV Notas[BX+DI],AX     ;Insiro na matriz
        ADD DI,2                  ;Vou para a proxima coluna
        PULA_LINHA      ;Pulo 2 linhas
        DEC CH                  ;Decremento o contador limite
        JNZ @INSERIR_NOTA
    
    INC Cadastro_Aluno      ;Aumento a quantidade de aluno cadastrado em 1
    MOV CH,8            
    ADD [SI],CH  ;Pulo o contador de linhas para a proxima linha
    RET
    @FIM_SEM_ESPAÇO:
        LIMPA_TELA
        PULA_LINHA
        MOV AH,09           ;Impressao mensagem erro
        LEA DX,MSG_ESPACO    
        INT 21H
        PAUSE
        RET
    @ERRO_INSERIR:
        PULA_LINHA
        MOV AH,09           ;Impressao mensagem erro
        LEA DX,MSG_ERROR_NUMERO    
        INT 21H
        PULA_LINHA
        JMP @INSERIR_NOTA
INSERIR_ALUNO ENDP

IMPRIMIR_TABELA PROC
    ; CH -> Contador Nome e  para as notas
    ; CL -> Contador para impressao
    ; BX -> Contador de linhas
    GUARDA_4REG AX,BX,CX,DX
    LIMPA_TELA      ;Limpo tela e pulo uma linha
    PULA_LINHA
    XOR SI,SI           ;Seto SI para 0
    MOV CL,Cadastro_Aluno[SI]       ;Verifico quantos alunos foram cadastrados
    CMP CL,0        
    JNE @continua_impressao     ;Se for 0 da erro e fala que n tem nenhum
    JMP ERRO_ALUNO
    @continua_impressao:
    LEA SI,Nomes            ;Aponto SI para Nomes
    MOV CL,Cadastro_Aluno       ;Seto contador para a quantidade de alunos registrados
    CLD     ;Seto o DF
    MOV AH,09   
    LEA DX,MSG_IMPRESSAO        ;Print da menu da impressao
    INT 21H
    XOR DI,DI       ;Seto as linhas da matriz
    PULA_LINHA
    @IMPRESAO:
        PULA_LINHA
        MOV AH,02   ;Seto AH para imprimir
        MOV CH,20   ;Seto contador para 20
        SPACE
        IMPRESSAO_NOME:
            LODSB           ;Copio o caracter que SI aponta
            MOV DL,AL        ;Jogo para DL e printo
            INT 21H
            DEC CH
            JNZ IMPRESSAO_NOME      ;Faço isso 20x
        MOV CH,4        ;Seto contador de print de nota para 4
        CALL CALCULO_MEDIA      ;Calculo a media
        XOR BX,BX           ;Zero as colunas
        @auxIMPRIMIR_NOTA:
            MOV AX,Notas[DI+BX]     ;Pego o valor
            PUSH CX         ;Guardo o contador
            PUSH BX             ;Guardo as colunas
            MOV BX,10           ;Seto o divisor
            XOR CX,CX       ;Contador de digitos
        CALCULO_NOTA:
            XOR DX,DX       ;Divido o valor por 10 ate ser 0 e guardo na pilha
            DIV BX
            PUSH DX
            INC CH
            OR AX,AX
            JNZ CALCULO_NOTA
        MOV AH,02
        IMPRESSAO_NOTA:
            POP DX          ;Vou tirando da pilha e printando
            OR DL,30H
            INT 21H
            DEC CH
            JNZ IMPRESSAO_NOTA
            POP BX          ;Volto o valor de colunas
            ADD BX,2        ;Vou para a proxima coluna
            TAB         ;Dou tabs para formatação
            TAB
            POP CX      ;Volto o contador
            DEC CH
            JNZ @auxIMPRIMIR_NOTA       ;Faço 4x
        ADD DI,8    ;Vou para a proxima linha da matriz de notas
        DEC CL
        JNZ @IMPRESAO       ;Repito a quantidade de alunos registrados
    PAUSE
    SOLTA_4REG AX,BX,CX,DX
    RET
    ERRO_ALUNO:
        LIMPA_TELA
        PULA_LINHA      ;Print de erro de nenhum aluno e da RET
        MOV AH,09
        LEA DX,MSG_ERRO_NENHUM
        INT 21H
        PAUSE
        SOLTA_4REG AX,BX,CX,DX
        RET
IMPRIMIR_TABELA ENDP

CALCULO_MEDIA PROC
    ; BX -> Colunas
    ; DX -> Somatoria
    ; AX -> Intermediario para somatoria
    ; DI -> A linha
    ; AL ->dividendo
    GUARDA_4REG AX,BX,CX,DX     ;Guarda registradores
    PUSH SI

    XOR DX,DX       ;Seto a somatoria
    MOV CH,3        ;Contador pra somatoria
    XOR SI,SI       ;Seto SI para pegar os pesos
    XOR BX,BX       ;Reset das colunas
    @SOMA_NOTAS:
        MOV CL,Pesos[SI]        ;Pego o valor do peso, guardo em CL e o valor do nota, guardo em AX
        MOV AX,Notas[DI+BX]     
        MUL CL          ;Multiplico a nota pelo peso
        ADD DX,AX       ;Somo na somatoria
        ADD BX,2        ;Vou para a proxima coluna
        INC SI          ;Vou para o proximo peso
        DEC CH  
        JNZ @SOMA_NOTAS     ;Repito 3x

    MOV AX,DX       ;Guardo a somatoria em AX
    XOR SI,SI
    CMP Cadastro_Peso[SI],0     ;Verifico se alterou os pesos, se nao faço aritimetica
    JE @MediaAritmetica
     @MediaPonderada:
         MOV CH,10      ;Seto o divisor para 10 caso seja ponderada
         JMP @FIM_Media
    @MediaAritmetica:
        MOV CH,3    ;Setando divisor para 3 se for aritmetica
    @FIM_Media:
        DIV CH          ;Divido 
        XOR AH,AH       ;Zero o valor do resto
        MOV Notas[DI+BX],AX     ;Guardo o dividendo na posição da media na matriz de Notas

    POP SI
    SOLTA_4REG AX,BX,CX,DX      ;Volto os registradores
    RET
CALCULO_MEDIA ENDP

CORRIGIR_NOTAS PROC
    ;DL -> Limite de repetição, de acordo com quantos alunos ja foram inseridos
    ;DH -> linha da matriz de nota
    LIMPA_TELA
    PULA_LINHA
    XOR SI,SI       
    MOV CL,Cadastro_Aluno[SI]       ;Verifico quantos alunos foram cadastrados
    CMP CL,0
    JNE @continua_correcao      ;Se for 0 da erro e fala que n tem nenhum
    JMP @ERRO_ALUNO_CORRIGIR
    @continua_correcao:
    MOV AH,09
    LEA DX,MSG_CORRECAO
    INT 21H            ;Printo a mensagem
    MOV CX,20           ;Seto o contador para 20 max
    LEA DI,Nome_Correcao          ;Aponto DI para o começo da string_lida
    CLD                 ;Seto o DF
    MOV AH,01
    INT 21H         ;Leio caracter
    @REP_CORRECAO_LER:
        CMP AL,0DH          ;Verifico se é enter, se for termina a leitura
        JE @AUX_CORRECAO     
        CMP AL,08h          ;Verifico se é backspace, para corrigir, se nao for pula para @caracter
        JNE @CARACTER_CORRECAO
        SPACE
        GUARDA_2REG AX,DX
        MOV AH,02
        MOV DL,08h
        INT 21H
        SOLTA_2REG AX,DX
        INC CX              ;Incrementa o contador para que ele seja subtraido denovo no LOOP
        DEC DI          ;Volto DI para a posição interior
        JMP @REP_CORRECAO
    @CARACTER_CORRECAO:     STOSB           ;Guardo o caracter na string_lida
    @REP_CORRECAO:
        INT 21H         ;Leio outro caracter e faço o loop
        LOOP @REP_CORRECAO_LER
    @AUX_CORRECAO:
        XOR DX,DX
        XOR DI,DI
        LEA SI,Nomes      ;Aponto SI para string_lida
        MOV DL,Cadastro_Aluno[DI]
    @VERIFICA:
        LEA DI,Nome_Correcao           ;Aponto DI para o começo do nome inserido
        MOV CX,20       ;Seto o contador pra 20
        REPE CMPSB          ;E comparo enquanto for igual 
        JZ @INSERIR_NOTA_NOVA
        ADD DH,8
        DEC DL
        JNZ @VERIFICA
        JMP @ERRO_NOME
    @INSERIR_NOTA_NOVA:
        XOR BX,BX       ;Seto as linhas em BX de acordo com o contador
        MOV BL,DH    ;Coloco em BX a linha que precisa a inserção
        XOR DI,DI       ;Seto colunas
        MOV CH,3       ;Definindo o limitador
    @INSERIR_NOTA_CORRIGIDA:
       PULA_LINHA      ;Pulo 2 linhas
       PULA_LINHA
       MOV AH,09           ;Imprimir mensagem da nota
       LEA DX,MSG_INSERIR_NOTA
       INT 21H
       PUSH BX
       XOR BX,BX
       MOV DH,2     
       MOV AH,01       ;Leio o caracter
       INT 21H
   @auxINSERIR_NOTA_CORRIGIDA:
       CMP AL,30H      ;Verifico se  é um numero, se nao vai pro erro
       JNGE @ERRO_INSERIR_NOTA
       CMP AL,39H
       JNLE @ERRO_INSERIR_NOTA
       AND AX,000FH
       PUSH AX
       MOV AX,10
       MUL BX
       POP BX
       ADD BX,AX
       MOV AH,01
       INT 21H
       CMP AL,13
       JE @aux2INSERIR_NOTA_CORRIGIDA
       DEC DH
       JZ @aux2INSERIR_NOTA_CORRIGIDA
       JMP @auxINSERIR_NOTA_CORRIGIDA
   @aux2INSERIR_NOTA_CORRIGIDA:
       MOV AX,BX
       POP BX
       MOV Notas[BX+DI],AX     ;Se for numero insiro na matriz
       ADD DI,2                  ;Vou para a proxima coluna
       DEC CH                  ;Decremento o contador limite
       JNZ @INSERIR_NOTA_CORRIGIDA
    RET
    @ERRO_INSERIR_NOTA:
         PULA_LINHA
         MOV AH,09           ;Impressao mensagem erro
         LEA DX,MSG_ERROR_NUMERO    
         INT 21H
         PULA_LINHA
         JMP @INSERIR_NOTA_CORRIGIDA
     @ERRO_NOME:
        LIMPA_TELA
         MOV AH,09
         LEA DX,MSG_ERRO_NOME
         INT 21H
         PAUSE
         RET
    @ERRO_ALUNO_CORRIGIR:
        LIMPA_TELA
        PULA_LINHA
        MOV AH,09
        LEA DX,MSG_ERRO_NENHUM
        INT 21H
        PAUSE
        RET
 CORRIGIR_NOTAS ENDP

PESO PROC
    GUARDA_4REG AX,BX,CX,DX     ;Guardo registradores
    PUSH DI
        LIMPA_TELA      ;Limpa tela e pula
        PULA_LINHA
        MOV AH,09
        LEA DX,MSG_INSERIR_PESOS        ;Print da mensagem
        INT 21H

        LEA DI,Pesos    ;Aponto DI para pesos
        CLD             ;Seto DF

        MOV DL,31H       ;Contador das provas para print
        MOV CX,3        ;Contador do loop de pesos
        @INSERIR_PESOS:
            PULA_LINHA
            PUSH DX         ;Guardo em qual prova estau
            MOV AH,09
            LEA DX,MSG_INSERIR_PESO     ;Printa mensagem
            INT 21H

            POP DX      ;Volto o numero da prova
            MOV AH,02  ;Printo em que prova
            INT 21H
            PUSH DX     ;Guardo em qual prova estau

            MOV DL,':'      ;Print ':'
            INT 21H
            POP DX      ;Volto o numero da prova
            SPACE

            MOV AH,01       ;Leio o peso
            INT 21H
            AND AL,0FH      ;Transformo em numero
            STOSB           ;Guardo no vetor
            INC DL
            LOOP @INSERIR_PESOS     ;Repito 3x
        LEA DI,Cadastro_Peso
        MOV CL,1
        MOV [DI],CL     ;Mudo o cadastro de peso para 1
    POP DI
    SOLTA_4REG AX,BX,CX,DX      ;Volto registradores
    RET
PESO ENDP
END MAIN