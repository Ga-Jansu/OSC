.MODEL SMALL
.CODE
MAIN PROC
    MOV AX,7444h
    OR AX,8001h
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN