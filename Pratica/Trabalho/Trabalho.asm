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

    DEZ DB '10$'

    MSG_Menu    DB  10,13,9,'Digite a opcao que quer:'
                DB  10,13,9,9,'|    1 - Insercao de novo aluno   |'
                DB  10,13,9,9,'|    2 - Vizualizar  as notas     |'
                DB  10,13,9,9,'|    3 - Corrigir uma nota        |'
                DB  10,13,9,9,'|    0 - Sair                     |'
                DB  10,13,10,13,9,'Opcao escolhida: $'

    Error_Menu  DB 'Opcao invalida, digite novamente!$'

    Inserir_Nome DB 'Nome do Aluno(Máximo 10 caracteres): $'
    Inserir_Nota DB 'Nota do Aluno: $'


.CODE
MAIN PROC
    ;BL = contador da linha
    MOV AX,@DATA
    MOV DS,AX

    XOR BL,BL
    
    CALL MENU
       
    FIM:
        MOV AH,4CH  ;Retorno ao DOS
        INT 21H
MAIN ENDP

MENU PROC
    EntMenu:
        PULA_LINHA
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
    ;CL = Contador de linha
    ;

    XOR BX,BX
    XOR SI,SI




    RET
INSERÇÃO ENDP

Calculo_Media PROC


    RET
Calculo_Media ENDP

CORREÇÃO PROC


    RET
CORREÇÃO ENDP

IMPRESSÃO PROC

    
    RET
IMPRESSÃO ENDP
END MAIN


