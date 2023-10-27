.MODEL SMALL
.STACK 100H
.DATA
    Nomes   DB 10 DUP(?), DB 10 DUP(?), DB 10 DUP(?), DB 10 DUP(?), DB 10 DUP(?)

    Notas   DB 2 DUP(?),    DB 2 DUP(?),    DB 2 DUP(?)
            DB 2 DUP(?),    DB 2 DUP(?),    DB 2 DUP(?)
            DB 2 DUP(?),    DB 2 DUP(?),    DB 2 DUP(?)
            DB 2 DUP(?),    DB 2 DUP(?),    DB 2 DUP(?)
            DB 2 DUP(?),    DB 2 DUP(?),    DB 2 DUP(?)

    Medias DB 2 DUP(?), DB 2 DUP(?), DB 2 DUP(?), DB 2 DUP(?), DB 2 DUP(?)

    DEZ DB 10,13,'10$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV AH,4CH  ;Retorno ao DOS
    INT 21H
MAIN ENDP

INSERÇÃO PROC


    RET
INSERÇÃO ENDP

CORREÇÃO PROC


    RET
CORREÇÃO ENDP

IMPRESSÃO PROC

    
    RET
IMPRESSÃO ENDP
END MAIN


