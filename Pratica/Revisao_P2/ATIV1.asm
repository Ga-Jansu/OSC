TITLE EXERCICIO_1

.MODEL SMALL

.DATA ;Mensagens para o usuario
    MSG1 DB  "Digite um caracter: $"
    MSG2 DB 10,13,"O caracter que voce digitou eh: $"

.CODE
    main proc 
        ;Importanto o endereço de DATA, para poder utilizar as variaveis contidas em .DATA
        MOV AX,@DATA
        MOV DS,AX

        ;Print da primeira string (MSG1)
        MOV AH,09
        MOV DX, OFFSET MSG1
        INT 21H

        ;Leitura do caracter a ser digitado, e guardado em BL
        MOV AH,01
        INT 21H
        MOV BL,AL

        ;Print da segunda string (MSG1)
        MOV AH,09 
        MOV DX, OFFSET MSG2
        INT 21H

        ;Print do caracter que foi digitado (salvo em BL)
        MOV AH,02
        MOV DL,BL
        INT 21H

        ;Finalização do programa
        MOV AH,4CH
        INT 21H 

    main ENDP
    END MAIN
        
