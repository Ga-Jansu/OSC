.MODEL SMALL
.STACK 100h
ENTER MACRO
    PUSH AX
    PUSH DX
    MOV AH,02
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    POP DX
    POP AX
    ENDM
TAB MACRO
    PUSH AX
    PUSH DX
    MOV AH,02
    MOV DL,9
    INT 21H
    POP DX
    POP AX
    ENDM
GUARDAR_1 MACRO AUX
    PUSH AUX
    ENDM
GUARDAR_2 MACRO AUX,AUX_2
    PUSH AUX
    PUSH AUX_2
    ENDM
GUARDAR_3 MACRO AUX,AUX_2,AUX_3
    PUSH AUX
    PUSH AUX_2
    PUSH AUX_3
    ENDM
GUARDAR_4 MACRO AUX,AUX_2,AUX_3,AUX_4
    PUSH AUX
    PUSH AUX_2
    PUSH AUX_3
    PUSH AUX_4
    ENDM
SOLTA_1 MACRO AUX
    POP AUX
    ENDM
SOLTA_2 MACRO AUX,AUX_2
    POP AUX
    POP AUX_2
    ENDM
SOLTA_3 MACRO AUX,AUX_2,AUX_3
    POP AUX
    POP AUX_2
    POP AUX_3
    ENDM
SOLTA_4 MACRO AUX,AUX_2,AUX_3,AUX_4
    POP AUX
    POP AUX_2
    POP AUX_3
    POP AUX_4
    ENDM
IMPRIME_MENU MACRO
    GUARDAR_2 AX,DX
    MOV AH,09
    LEA  DX,MENU
    INT 21H
    SOLTA_2 DX,AX
    ENDM
.DATA
    NOMES DB 5*20 DUP(?)

    NOTAS   DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
            DB 4 DUP(?)
    
    REGISTRO DB 0

    MENU    DB 10,13,' Escolha uma opcao:'
            DB 10,13,9, ' 1- Inserir um aluno novo (Maximo 5)'
            DB 10,13,9, ' 2- Imprimir a lista de notas'
            DB 10,13,9, ' 3- Corrigir alguma nota'
            DB 10,13,9, ' 0- Finalizar o programa'
            DB 10,13, ' Digite aqui: $'


    ERROR_MENU DB 10,13,9,'Valor invalido digite novamente!$'
    
    TEMPLATE DB ' Nome:',9,9,'P1',9,9,'P2',9,9,'P3',9,9,'Media$'

    MSG_INSERIR_NOME DB 10,13,9,'Insira o nome (maximo 20 caracteres): $'
    MSG_INSERIR_NOTA DB 10,13,9,'Insira a nota: $'

    MSG_CORRIGIR DB 10,13,9,'Digite o nome que deseja corrigir: $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    VOLTA_MAIN:
        ENTER
        IMPRIME_MENU
        MOV AH,01
        INT 21HJ
        CMP DL,'0'
        JE FIM_MAIN
        JL ERRO_MAIN
        CMP DL,'4'
        JG ERRO_MAIN

        JMP VOLTA_MAIN
    ERRO_MAIN:
        MOV AH,09
        LEA DX,ERROR_MENU
        INT 21H
        ENTER
        JMP VOLTA_MAIN
    FIM_MAIN:
        MOV AH,4CH
        INT 21H
MAIN ENDP

END MAIN