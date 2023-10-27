TITLE while
.MODEL SMALL
.CODE
MAIN PROC
    INICIO:
        MOV AH,01   ;Le o que o usuario digita
        INT 21H
        MOV BL,AL   ;Copia em BL
        CMP BL,13   ;Verifica se o usuario der ENTER, enquanto nao for, vai voltar pra INICIO
        JNE INICIO  
    MOV AH,4CH  ;Finalização do programa
    INT 21H
MAIN ENDP
END MAIN