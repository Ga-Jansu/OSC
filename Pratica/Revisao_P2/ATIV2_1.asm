TITLE Conversao

.MODEL SMALL

.DATA ;Mensagens para o usuario
    MINUSCULA DB "Digite uma letra minuscula: $"
    MAIUSCULA DB 10,13,"A forma maisucula da letra digitada eh: $"

.CODE
    MAIN PROC
        ;Importanto o endereço de DATA, para poder utilizar as variaveis contidas em .DATA
        MOV AX,@DATA
        MOV DS,AX

        ;Print da primeira string (MINUSCULA)
        MOV AH,09
        MOV DX, OFFSET MINUSCULA
        INT 21H

        ;Leitura do caracter a ser digitado, e guardado em BL
        MOV AH,01
        INT 21H
        MOV BL,AL

        ;Conversão do caracter minuscula para o maiusculo
        SUB BL,32

        ;Print da secunda string (MAIUSCULA)
        MOV AH,09
        MOV DX, OFFSET MAIUSCULA
        INT 21H

        ;Print do caracter digitado maiusculo
        MOV AH,02
        MOV DL,BL
        INT 21H

        ;Finalização do programa
        MOV AH,4CH
        INT 21H


    MAIN ENDP
    END MAIN