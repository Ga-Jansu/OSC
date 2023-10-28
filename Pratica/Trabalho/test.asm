.MODEL SMALL
.DATA
    VET DB 5 DUP(?)
.CODE
;description
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    XOR SI,SI
    XOR AL,AL
    MOV CH,5
    MOV AH,01
    @Insere_Nome:
        INT 21H
        CMP CH,0
        JE @SAI2
        CMP AL,13
        JE @SAI2
        MOV VET[SI],AL
        INC SI
        DEC CH
        JMP @Insere_Nome

    @SAI2:
        XOR SI,SI
        XOR CH,CH
        MOV BH,5
        @QTD_NUMEROS:
            CMP VET[SI],'0'
            JL @NAO
            CMP VET[SI],'9'
            JA @NAO
            INC CH
        @NAO:
            INC SI
            DEC BH
            JNZ @QTD_NUMEROS

     MOV AH,02
     MOV DL,10
     INT 21H    
     MOV DL,13
     INT 21H
     MOV DL,CH
     OR DL,30H
     INT 21H

    @SAI:
         XOR SI,SI   ;Contador do vetor
         MOV AH,02
         @Imprime_Nome:
             MOV DL,VET[SI]
             INT 21H
             INC SI
             DEC CH
             JNZ @Imprime_Nome
     
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN