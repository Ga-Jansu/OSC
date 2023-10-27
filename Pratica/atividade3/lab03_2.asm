TITLE ATIV2

.MODEL SMALL
.STACK 100h

.DATA
    MSG1 DB "Digite um caractere: $"
    NUMERO DB 10,13,"O caractere digitado eh um numero.$"
    LETRA DB 10,13,"O caractere digitado eh uma letra.$"
    DESCONHECIDO DB 10,13,"O caractere digitado eh desconhecido.$"

.CODE
    main proc
        ;Permite acesso ao conteudo de DATA
        MOV AX,@DATA
        MOV DS,AX

        ;Print da MSG1 na tela
        MOV AH,09
        MOV DX, OFFSET MSG1
        INT 21H

        ;Permite o usuario digitar um caractere e guarda em AL
        MOV AH,01
        INT 21H
        ;Copia o caractere para BL
        MOV BL,AL
        ;Compara o caractere com o 48(Na tabela asc é igual a '0'),se for menor salta para o rotulo CARACTERDESCONHECIDO
        CMP BL,48
        JB CARACTERDESCONHECIDO
        ;Compara o caractere com o 57(Na tabela asc é igual a '9'),se for menor salta para o rotulo CARACTERNUMERO
        CMP BL,57
        JB CARACTERNUMERO
        ;Compara o caractere com o 65(Na tabela asc é igual a 'A'),se for menor salta para o rotulo CARACTERDESCONHECIDO
        CMP BL,65
        JB CARACTERDESCONHECIDO
        ;Compara o caractere com o 90(Na tabela asc é igual a 'Z'),se for menor salta para o rotulo CARACTERLETRA
        CMP BL,90
        JB CARACTERLETRA
        ;Compara o caractere com o 97(Na tabela asc é igual a 'a'),se for menor salta para o rotulo CARACTERDESCONHECIDO
        CMP BL,97
        JB CARACTERDESCONHECIDO
        ;Compara o caractere com o 122(Na tabela asc é igual a 'z'),se for menor salta para o rotulo CARACTERLETRA
        CMP BL,122
        JB CARACTERLETRA
        ;Salta para o rotulo FIM
        JMP FIM

    ;Define o rotulo CARACTERDESCONHECIDO
    CARACTERDESCONHECIDO:
        ;Print da mensagem DESCONHECIDO na tela
        MOV AH,09
        MOV DX, OFFSET DESCONHECIDO
        INT 21H
        JMP FIM
    ;Define o rotulo CARACTERNUMERO
    CARACTERNUMERO:
    ;Print da mensagem  NUMERO na tela
        MOV AH,09
        MOV DX, OFFSET NUMERO
        INT 21H
        JMP FIM
    ;Define o rotulo CARACTERLETRA
    CARACTERLETRA:
        ;Print da mensagem LETRA na tela
        MOV AH,09
        MOV DX, OFFSET LETRA
        INT 21H
     ;Define o rotulo FIM   
    FIM:
        ;Finaliza o programa
        MOV AH,4CH
        INT 21H
    main endp
END MAIN