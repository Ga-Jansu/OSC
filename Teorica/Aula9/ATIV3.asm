TITLE ativ3
.MODEL SMALL
.CODE
main PROC
    MOV DL,'*'
    MOV CX,80
    MOV AH,02
PRINT:  ;FOR(cx=80, cx<0, cx--)
    INT 21H
    LOOP PRINT
    MOV AH,4CH
    INT 21H
main ENDP
END MAIN