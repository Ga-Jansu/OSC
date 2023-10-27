TITLE numero
.MODEL SMALL
.STACK 100h

.DATA
    MSG1 DB "Digite um caractere: $"
    SIM DB 10,13,"O caractere digitado e um numero.$"
    NAO DB 10,13,"O caractere digitado nao e um numero.$"
.CODE
    main proc
        ;Permite acesso as variaveis de DATA
        MOV AX,@DATA
        MOV DS,AX
        ;Print da variavel MSG1
        MOV AH,09
        MOV DX, OFFSET MSG1
        INT 21H
        ;Permite o usuario digitar um caracter e guarda em AL
        MOV AH,01
        INT 21H
        ;Copia conteudo de AL em BL
        MOV BL,AL
        ;Compara conteudo de BL com o numero 48(Na tabela asc é igual a '0'), se for menor salta pro rotulo NAONUMERO
        CMP BL,48
        JB NAOENUMERO
        ;Compara conteudo de BL com o numero 57(Na tabela asc é igual a '9'), se for maior salta pro rotulo NAONUMERO
        CMP BL,57
        JA NAOENUMERO
        ;Print da variavel SIM
        MOV AH,09
        MOV DX, OFFSET SIM
        INT 21H
        ;Salta pro rotulo FIM
        JMP FIM
    ;DEFINE O ROTULO NAONUMERO
    NAOENUMERO:
        ;Print da variavel NAO
        MOV AH,09
        MOV DX,OFFSET NAO
        INT 21H
    ;DEFINE O ROTULO FIM
    FIM:
        ;Finalização do programa
        MOV AH,4CH
        INT 21H
    main endp
    END MAIN