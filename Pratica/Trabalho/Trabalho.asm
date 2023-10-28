.MODEL SMALL
PULA_LINHA MACRO
        LEA DX, LINHA       ;Função para pular linha
        MOV AH,9
        INT 21H
        ENDM
    

.STACK 100H
.DATA
    Nomes   DB 10 DUP(?), 10 DUP(?),10 DUP(?), 10 DUP(?), 10 DUP(?)

    Notas   DB 2 DUP(?), 2 DUP(?),  2 DUP(?)
            DB 2 DUP(?), 2 DUP(?),  2 DUP(?)
            DB 2 DUP(?), 2 DUP(?),  2 DUP(?)
            DB 2 DUP(?), 2 DUP(?),  2 DUP(?)
            DB 2 DUP(?), 2 DUP(?),  2 DUP(?)

    Medias DB 2 DUP(?), 2 DUP(?), 2 DUP(?), 2 DUP(?), 2 DUP(?)

    DEZ DB 10,13,'10$'

    LINHA DB 10,13,'$'

    MSG_Menu    DB  10,13,9,'Digite a opcao que quer:'
                DB  10,13,9,9,'|    1 - Insercao de novo aluno   |'
                DB  10,13,9,9,'|    2 - Vizualizar  as notas     |'
                DB  10,13,9,9,'|    3 - Corrigir uma nota        |'
                DB  10,13,9,9,'|    0 - Sair                     |'
                DB  10,13,10,13,9,'Opcao escolhida: $'

    Error_Menu  DB 10,13,9,'Opcao invalida, digite novamente!$'


.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    REPEAT:
        CALL MENU
        JNZ REPEAT
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
    
    CMP AL,3
    JG ErroMenu
    CMP AL,0
    JL ErroMenu

    CMP AL,1
    JNE @RepMenu2
    CALL INSERÇÃO
    CALL Calculo_Media
    JMP @Volta
    @RepMenu2:
        CMP AL,2
        JNE @RepMenu3
        CALL IMPRESSÃO
        JMP @Volta
    @RepMenu3: 
        CMP AL,3
        JNE @FimMenu
        CALL CORREÇÃO

    @Volta: JMP EntMenu

    @FimMenu:
        OR AL,AL
        RET
    ErroMenu:
        MOV AH,09
        LEA DX,Error_Menu
        INT 21H
        PULA_LINHA
        JMP EntMenu
MENU ENDP

INSERÇÃO PROC
    ;CH = Contador de coluna
    ;CL = Contador de linha

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


