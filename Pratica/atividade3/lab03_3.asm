TITLE alfabeto

.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB "Maiusculas: $"
    MSG2 DB 10,13,"Minusculas: $"
.CODE
main proc
    ;Permite acesso as variaveis de DATA
    MOV AX,@DATA
    MOV DS,AX
    ;Print da variavel MSG1
    MOV AH,09
    MOV DX, OFFSET MSG1
    INT 21H
    ;Coloca em BL o numero 64(Na tabela asc é igual a '@')
    MOV BL,64
    MAIUSCULAS:
        ;Adiciona 1 em BL
        ADD BL,1
        ;Printa BL
        MOV AH,02
        MOV DL,BL
        INT 21H
        ;Compara conteudo de BL com o numero 90(Na tabela asc é igual a 'Z'), se for menor salta pro rotulo MAIUSCULA e repete
        CMP BL,90
        JB MAIUSCULAS
    ;Coloca em BL o numero 96(Na tabela asc é igual a ' ´ ')
    MOV BL,96
    ;Print da variavel MS2
    MOV AH,09
    MOV DX, OFFSET MSG2
    INT 21H
    MINUSCULAS:
        ;Adiciona 1 em BL
        ADD BL,1
        ;Printa BL
        MOV AH,02
        MOV DL,BL
        INT 21H
        ;Compara conteudo de BL com o numero 122(Na tabela asc é igual a 'z'), se for menor salta pro rotulo MINUSCULA e repete
        CMP BL,122
        JB MINUSCULAS
    ;Finalização do programa
    MOV AH,4CH
    INT 21H

main endp
END MAIN