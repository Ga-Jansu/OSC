TITLE EXERCICIO_3

.MODEL SMALL

.DATA ;Mensagens para o usuario
    PRIMEIRONUMERO DB "Digite o primeiro numero a ser somado: $"
    SEGUNDONUMERO DB 10,13,"Digite o segundo numero a ser somado: $"
    RESULTADO DB 10,13,"A soma dos dois numeros digitados eh: $"

.CODE
    MAIN PROC
        ;Importanto o endereço de DATA, para poder utilizar as variaveis
        MOV AX,@DATA
        MOV DS,AX

        ;Print da primeira string (PRIMEIRONUMERO)
        MOV AH,09
        MOV DX, OFFSET PRIMEIRONUMERO
        INT 21H

        ;Leitura do primeiro numero e guardado em BL
        MOV AH,01
        INT 21H
        MOV BL,AL

        ;Conversão do primeiro numero (De caracter para decimal)
        SUB BL,48

        ;Print da segunda string (SEGUNDONUMERO)
        MOV AH,09
        MOV DX, OFFSET SEGUNDONUMERO
        INT 21H

        ;Leitura do segundo numero e guardado em CL
        MOV AH,01
        INT 21H
        MOV CL,AL

        ;Conversão do segundo numero (De caracter para decimal)
        SUB CL,48

        ;Operação de soma dos dois numeros
        ADD BL,CL

        ;Conversão do resultado (De decimal para caracter)
        ADD BL,48

        ;Print da terceira string(RESULTADO)
        MOV AH,09
        MOV DX, OFFSET RESULTADO
        INT 21H

        ;Print do resultado em si
        MOV AH,02
        MOV DL,BL
        INT 21H

        ;Finalização do programa
        MOV AH,4CH
        INT 21H  

    MAIN ENDP
    END MAIN