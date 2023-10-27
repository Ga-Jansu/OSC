TITLE lab06_01
.MODEL SMALL
.DATA
    LEITURA DB 10,13,"Digite um numero: $"      ;Mensagens par o usuario
    PRINT DB 10,13,"O numero que digitou foi: $"
.CODE
main PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,4    ;Inicialização do contator como no max 4
    LER:    
        MOV AH,09
        MOV DX, OFFSET LEITURA
        INT 21H         ;Leitura do numero que o usuario digitar
        MOV AH,01
        INT 21H
        MOV BL,AL   ;Armazeno em BL
        CMP BL,'0'  ;Comparo com o numero '0'
        JNE IMPRIME     ; Se for diferente ja pula para imprimir
        MOV BL,'X'      ; Se for igual ja troco pra 'X'
    IMPRIME:
        MOV AH,09       
        MOV DX, OFFSET PRINT
        INT 21H         ;Print do caracter digitado
        MOV AH,02
        MOV DL,BL
        INT 21H
        LOOP LER    ;Enquanto o CX for diferente de 0 vai voltar pra LER
    MOV AH,4CH  ;Finalização do programa
    INT 21H
main ENDP
END MAIN