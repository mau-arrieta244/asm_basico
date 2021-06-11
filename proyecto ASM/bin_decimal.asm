
; binario 8 bits a decimal

.model small
.stack 100h

.data 
    arrayBinario db 8 dup (?)
    decimal db ?
     
    
.code
    mov decimal,0
    
    
    mov ah, 1
	int 21h
	mov arrayBinario[0],al
	
	mov ah, 1
	int 21h
	mov arrayBinario[1],al
	
	mov ah, 1
	int 21h
	mov arrayBinario[2],al
	
	mov ah, 1
	int 21h
	mov arrayBinario[3],al
	
	mov ah, 1
	int 21h
	mov arrayBinario[4],al
	
	mov ah, 1
	int 21h
	mov arrayBinario[5],al
	
	mov ah, 1
	int 21h
	mov arrayBinario[6],al
	
	mov ah, 1
	int 21h
	mov arrayBinario[7],al 
	
	xor ax,ax
	
	;cmp arrayBinario[0],1
	;je agrega128 
	MOV AL, arrayBinario[0]   ; AL = 0C8h
    MOV BL,128 
    MUL BL
    add decimal,al  
    
    MOV AL, arrayBinario[1]   ; AL = 0C8h
    MOV BL,64 
    MUL BL
    add decimal,al
    
    MOV AL, arrayBinario[2]   ; AL = 0C8h
    MOV BL,32 
    MUL BL
    add decimal,al
    
    MOV AL, arrayBinario[3]   ; AL = 0C8h
    MOV BL,16 
    MUL BL
    add decimal,al  
    
    MOV AL, arrayBinario[4]   ; AL = 0C8h
    MOV BL,8 
    MUL BL
    add decimal,al
    
    MOV AL, arrayBinario[5]   ; AL = 0C8h
    MOV BL,4 
    MUL BL
    add decimal,al
    
    MOV AL, arrayBinario[6]   ; AL = 0C8h
    MOV BL,2 
    MUL BL
    add decimal,al
    
    MOV AL, arrayBinario[7]   ; AL = 0C8h
    MOV BL,1 
    MUL BL
    add decimal,al
    
    jmp final
    
	;============================= 
	;=============================
	final: 
	    CALL PTHIS
	    db '  =  ',0
	    
	    mov al,decimal
	    sub al,208
	    CALL display            ;Calls procedure display to display number

        MOV AH, 4CH
        INT 21H   
	
	    
	    
	    
	
	
    
    
      
      
  
   ;=============================================================
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
    ;------------------------------------------------------------
    ;------------------------------------------------------------
    ;------------------------------------------------------------
    
    
    DEFINE_PTHIS     MACRO
    LOCAL   next_char, printed, skip_proc_pthis, temp1

    ; protect from wrong definition location:
    JMP     skip_proc_pthis

    PTHIS PROC NEAR

    MOV     CS:temp1, SI  ; store SI register.

    POP     SI            ; get return address (IP).

    PUSH    AX            ; store AX register.

    next_char:      
        MOV     AL, CS:[SI]
        INC     SI            ; next byte.
        CMP     AL, 0
        JZ      printed        
        MOV     AH, 0Eh       ; teletype function.
        INT     10h
        JMP     next_char     ; loop.
    printed:

        POP     AX            ; re-store AX register.

        ; SI should point to next command after
        ; the CALL instruction and string definition:
        PUSH    SI            ; save new return address into the Stack.

        MOV     SI, CS:temp1  ; re-store SI register.
        
        RET
        temp1  DW  ?    ; variable to store original value of SI register.
        PTHIS ENDP

        skip_proc_pthis:

             ENDM
	
	    ;CALL PTHIS
	    ;db 'Hola mundo',0   ;cuando encuentra el 0 ya detiene string 
	    
	    
	    
	;------------------------------------------------------------  
    ;------------------------------------------------------------
    ;------------------------------------------------------------
    ;------------------------------------------------------------   
	    
	    
	    
     
      
    DEFINE_PTHIS
      
end