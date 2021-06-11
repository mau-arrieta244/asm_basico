.MODEL SMALL
.STACK
.DATA
 MSG DB '','$'
.CODE

START:  MOV AX, @DATA
         MOV DS, AX

        MOV AH, 09H
        LEA DX, MSG
        INT 21H           ;Calls MS DOS to display message
  
        MOV AX, 9887  ;Number to be displayed
        CALL display            ;Calls procedure display to display number

        MOV AH, 4CH
        INT 21H

display   proc       ;Beginning of procedure
   MOV BX, 10     ;Initializes divisor
   MOV DX, 0000H    ;Clears DX
   MOV CX, 0000H    ;Clears CX
    
          ;Splitting process starts here
.Dloop1:  MOV DX, 0000H    ;Clears DX during jump
   div BX      ;Divides AX by BX
   PUSH DX     ;Pushes DX(remainder) to stack
   INC CX      ;Increments counter to track the number of digits
   CMP AX, 0     ;Checks if there is still something in AX to divide
   JNE .Dloop1     ;Jumps if AX is not zero
    
.Dloop2:  POP DX      ;Pops from stack to DX
   ADD DX, 30H     ;Converts to it's ASCII equivalent
   MOV AH, 02H     
   INT 21H      ;calls DOS to display character
   LOOP .Dloop2    ;Loops till CX equals zero
   RET       ;returns control
display  ENDP



END START

;OUTPUT
;The multiple digit number is: 1234