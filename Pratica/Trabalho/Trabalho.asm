.MODEL SMALL
PULA_LINHA MACRO
        MOV AH,02
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        ENDM

TAB_LINHA MACRO
    MOV AH,02
    MOV DL,9
    INT 21H
    ENDM

GUARDA_REGS MACRO
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    ENDM

VOLTA_REGS MACRO
    POP AX
    POP BX
    POP CX
    POP DX
    ENDM
   

.STACK 100H
.DATA
    Nomes   DB 5*10 DUP(?)

    Notas   DB 3 DUP(?)
            DB 3 DUP(?)
            DB 3 DUP(?)
            DB 3 DUP(?)
            DB 3 DUP(?)

    Medias DB 5 DUP(?)

    

    Error_Menu DB 'Opcao invalida, digite novamente!$'
    Error_Nota DB 'Nota invalida, digite novamente!$'

    Inserir_Nome DB 'Nome do Aluno(Maximo 10 caracteres): $'
    Inserir_Nota DB 'Nota do Aluno: $'

     MSG_Menu    DB  'Digite a opcao que quer:'
                DB  10,13,9,9,'|    1 - Insercao de novo aluno   |'
                DB  10,13,9,9,'|    2 - Vizualizar  as notas     |'
                DB  10,13,9,9,'|    3 - Corrigir uma nota        |'
                DB  10,13,9,9,'|    0 - Sair                     |'
                DB  10,13,10,13,9,'Opcao escolhida: $'

.CODE
MAIN PROC
    ;CL = contador da linha
    MOV AX,@DATA
    MOV DS,AX

    XOR CL,CL
    
    CALL MENU
       
    FIM:
        MOV AH,4CH  ;Retorno ao DOS
        INT 21H
MAIN ENDP

MENU PROC
    EntMenu:
        PULA_LINHA
        PULA_LINHA
        TAB_LINHA
        MOV AH,09
        LEA DX,MSG_Menu
        INT 21H
        MOV AH,01
        INT 21H
    
    CMP AL,33H
    JA ErroMenu
    CMP AL,30H
    JL ErroMenu
    JE @FimMenu

    CMP AL,31H
    JNE @RepMenu2
    CALL INSERÇÃO
    CALL Calculo_Media
    JMP @Volta
    @RepMenu2:
        CMP AL,32H
        JNE @RepMenu3
        CALL IMPRESSÃO
        JMP @Volta
    @RepMenu3: 
        CMP AL,33H
        JNE @FimMenu
        CALL CORREÇÃO

    @Volta: JMP EntMenu

    @FimMenu:
        RET
    ErroMenu:
        PULA_LINHA
        TAB_LINHA
        MOV AH,09
        LEA DX,Error_Menu
        INT 21H
        PULA_LINHA
        JMP EntMenu
MENU ENDP

INSERÇÃO PROC
    ;CH = Contador de coluna
    ;SI -> Linhas
    ;CL = linha
    GUARDA_REGS
    PULA_LINHA
    PULA_LINHA

    XOR SI,SI
    CALL VERF_VETOR
    MOV AH,09
    LEA DX,Inserir_Nome
    INT 21H
    XOR AL,AL
    MOV CH,10
    MOV AH,01
    @Insere_Nome:
        CMP CH,0
        JZ @Insere_Meio
        CMP AL,13
        JE @Insere_Meio
        INT 21H
        MOV Nomes[SI],AL
        DEC CH
        JMP @Insere_Nome
    @Insere_Meio:
        PULA_LINHA
        XOR SI,SI
        CALL VERF_MATRIZ
        XOR BX,BX
        MOV CH,3
    @Insere_Matriz:
        CALL VERF_NOTA
        MOV Notas[SI+BX],AL
        INC BX
        CMP BX,3
        JNE @Insere_Matriz
    VOLTA_REGS
    RET
INSERÇÃO ENDP

Calculo_Media PROC
    GUARDA_REGS
    XOR SI,SI
    CALL VERF_MATRIZ
    XOR BX,BX
    MOV CH,3
    XOR AL,AL
    @REPEAT_MEDIA:
        MOV AH,Notas[SI+BX]
        ADD AL,AH
        INC BX
        CMP BX,3
        JNE @REPEAT_MEDIA
    XOR AH,AH
    DIV CH
    XOR SI,SI
    CALL VERF_VETOR
    MOV Medias[SI],AL
    VOLTA_REGS
    INC CL
    RET
Calculo_Media ENDP

CORREÇÃO PROC


    RET
CORREÇÃO ENDP

IMPRESSÃO PROC
    
    
    RET
IMPRESSÃO ENDP

VERF_VETOR PROC
    CMP CL,1
    JNE @VERF_VETOR2
    JMP @FIM_VERF_VETOR

    @VERF_VETOR2:
        CMP CL,2
        JNE @VERF_VETOR3
        ADD SI,10
        JMP @FIM_VERF_VETOR

    @VERF_VETOR3:
        CMP CL,3
        JNE @VERF_VETOR4
        ADD SI,20
        JMP @FIM_VERF_VETOR

    @VERF_VETOR4:
        CMP  CL,4
        JNE @VERF_VETOR5
        ADD SI,30
        JMP @FIM_VERF_VETOR
    @VERF_VETOR5:   ADD SI,40

    @FIM_VERF_VETOR:    RET
VERF_VETOR ENDP

VERF_MATRIZ PROC
    CMP CL,1
    JNE @VERF_MATRIZ2
    JMP @FIM_VERF_MATRIZ

    @VERF_MATRIZ2:
        CMP CL,2
        JNE @VERF_MATRIZ3
        ADD SI,4
        JMP @FIM_VERF_MATRIZ

    @VERF_MATRIZ3:
        CMP CL,3
        JNE @VERF_MATRIZ4
        ADD SI,8
        JMP @FIM_VERF_MATRIZ

    @VERF_MATRIZ4:
        CMP  CL,4
        JNE @VERF_MATRIZ5
        ADD SI,16
        JMP @FIM_VERF_MATRIZ
    @VERF_MATRIZ5:   ADD SI,32

    @FIM_VERF_MATRIZ:    RET
VERF_MATRIZ ENDP

VERF_NOTA PROC
    @VERFI_NOTA:
        PULA_LINHA
        MOV AH,09
        LEA DX,Inserir_Nota
        INT 21H
        MOV AH,01
        INT 21H
        CMP AL,'0'       ;Comparo com o '0', se nao for maior ou igual a 0 vai pedir de novo
        JNGE @ERRO_NOTA
        CMP AL,'9'        ;Comparo com o '9', se nao for menor ou igual a 6 vai pedir de novo
        JNLE @ERRO_NOTA
    RET
    @ERRO_NOTA:
        MOV AH,09
        LEA DX,Error_Nota
        INT 21H
        JMP @VERFI_NOTA
VERF_NOTA ENDP

END MAIN


