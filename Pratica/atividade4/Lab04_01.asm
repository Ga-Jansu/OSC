TITLE lab04_01
.MODEL SMALL
.DATA
    LF EQU 10 ;Constante para pular a linha
.CODE
main proc
    MOV CX,50    ;Definir o contador
    MOV DL,'*'  ;Deixar o '*' em DL
    MOV AH,02
    MESMALINHA: ;Função para imprimir o '*' e decrementar CL ate ser igual a 0 
        INT 21H     
        DEC CL
        JNZ MESMALINHA
    MOV CL,50   ;Resetando o contador
    PROXIMALINHA:   ;Função para fazer exatamente o mesmo que a anterior, mas pulando linha
        MOV DL,LF   ;Pula linha
        INT 21H
        MOV DL,'*'
        INT 21H
        DEC CL
        JNZ PROXIMALINHA
    MOV AH,4CH  ;Finalização do programa
    INT 21H
main endp
END MAIN