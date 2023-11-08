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
    Nomes   DB 25 DUP(?)
            DB 25 DUP(?)
            DB 25 DUP(?)
            DB 25 DUP(?)
            DB 25 DUP(?)
    
    Notas   DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)

    MSG_MENU    DB ' Escolha uma das opcoes: '
                DB 10,13,9,' 1- Inserir um aluno'
                DB 10,13,9,' 2- Corrigir a nota'
                DB 10,13,9,' 3- Imprimir a tabela'
                DB 10,13,9,' 0- Finalizar o programa'
                DB 10,13,' Opcao escolhida: $'
    
    MSG_CORRIGIR DB 'Digite o nome do aluno que deseja corrigir a nota, escreva exatamente!$'

    MSG_INSERIR_NOME DB 'Nome (Max. 25): $'

    MSG_INSERIR_NOTA DB 'Nota: $'

    MSG_IMPRESSAO DB 'Nome',9,'Nota P1',9,'Nota P2',9,'Nota P3',9,'Media$'

    MSG_ERROR DB 9,'Numero digitado invalido!$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    REPEAT_MENU:
        PULA_LINHA
        MOV AH,09
        LEA DX,MSG_MENU
        INT 21H
        MOV AH,01
        INT 21H
        PULA_LINHA
        CMP AL,'0'
        JL ERRO
        JE FIM
        CMP AL,'3'
        JA ERRO
        CMP AL,'1'
        JNE @OPCAO2
        CALL INSERIR_ALUNO
        JMP REPEAT_MENU
    @OPCAO2:
        CMP AL,'2'
        JNE @OPCAO3
        CALL CORRIGIR_NOTAS
        JMP REPEAT_MENU
     @OPCAO3:
        CALL IMPRIMIR_TABELA
        JMP REPEAT_MENU
    ERRO:
        PULA_LINHA
        PULA_LINHA
        MOV AH,09
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
    RET
INSERIR_ALUNO ENDP

CORRIGIR_NOTAS PROC
    RET
CORRIGIR_NOTAS ENDP

IMPRIMIR_TABELA PROC
    RET
IMPRIMIR_TABELA ENDP
END MAIN