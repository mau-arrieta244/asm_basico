

.model small 
.stack 100h
.data 
    arrayBinario db 8 dup (?) 
    
     
    
    
    
    
.code  
   
                
    CALL PTHIS 
    db 'Digite numero decimal: ',0
    
    
    mov dx,0 ; inicia en 0
     
    mov arrayBinario[0],0
    mov arrayBinario[1],0
    mov arrayBinario[2],0
    mov arrayBinario[3],0
    mov arrayBinario[4],0
    mov arrayBinario[5],0
    mov arrayBinario[6],0
    mov arrayBinario[7],0
    
    
    
    
    call SCAN_NUM ;almacena en CX, numeros multi-digito
    
    mov ax,cx ; ingresado
    
    xor cx,cx
    mov bl,7 ;indice
    
    
    ciclo:  
    
        mov cx,2 ; /2
        div cx ;division 16 bits, AX = resultado  , DX = restante div 
        mov arrayBinario[bx],dl
        
        
        dec bl
        
        cmp al,0 ;comparar antes de dividir para no hacer algo/2
        je final
        
        
        ;else
        jmp ciclo
    
    
    final:
        call pthis
        db '                         ',0
        
        mov ah, 2
	    mov al, arrayBinario[0]
	    add al,48
	    mov dl,al
	    int 21h
	    
	    mov ah, 2
	    mov al, arrayBinario[1]
	    add al,48
	    mov dl,al
	    int 21h
	    
	    mov ah, 2
	    mov al, arrayBinario[2]
	    add al,48
	    mov dl,al
	    int 21h
	    
	    
	    mov ah, 2
	    mov al, arrayBinario[3]
	    add al,48
	    mov dl,al
	    int 21h
	    
	    
	    mov ah, 2
	    mov al, arrayBinario[4]
	    add al,48
	    mov dl,al
	    int 21h
	    
	    
	    mov ah, 2
	    mov al, arrayBinario[5]
	    add al,48
	    mov dl,al
	    int 21h
	    
	    
	    mov ah, 2
	    mov al, arrayBinario[6]
	    add al,48
	    mov dl,al
	    int 21h
	    
	    mov ah, 2
	    mov al, arrayBinario[7]
	    add al,48
	    mov dl,al
	    int 21h
	    
	    
	    
	    
	       
        mov ah,4ch       
	    int 21h 
	    

	    
 
       
        
    
     
       
 
	;**************************************************************************
	;**************************************************************************
	
	
	
	; This macro defines a procedure that gets the multi-digit SIGNED number from the keyboard,
    ; and stores the result in CX register:
    DEFINE_SCAN_NUM          MACRO
    LOCAL make_minus, ten, next_digit, set_minus
    LOCAL too_big, backspace_checked, too_big2
    LOCAL stop_input, not_minus, skip_proc_scan_num
    LOCAL remove_not_digit, ok_AE_0, ok_digit, not_cr

    ; protect from wrong definition location:
    JMP     skip_proc_scan_num

    SCAN_NUM        PROC    NEAR
        PUSH    DX
        PUSH    AX
        PUSH    SI
        
        MOV     CX, 0

        ; reset flag:
        MOV     CS:make_minus, 0

    next_digit:

        ; get char from keyboard
        ; into AL:
        MOV     AH, 00h
        INT     16h
        ; and print it:
        MOV     AH, 0Eh
        INT     10h

        ; check for MINUS:
        CMP     AL, '-'
        JE      set_minus

        ; check for ENTER key:
        CMP     AL, 13  ; carriage return?
        JNE     not_cr
        JMP     stop_input
    not_cr:


        CMP     AL, 8                   ; 'BACKSPACE' pressed?
        JNE     backspace_checked
        MOV     DX, 0                   ; remove last digit by
        MOV     AX, CX                  ; division:
        DIV     CS:ten                  ; AX = DX:AX / 10 (DX-rem).
        MOV     CX, AX
        ;PUTC    ' '                     ; clear position. 
        mov ah, 2
	    mov dl, ' '
	    int 21h
        
        
        ;PUTC    8                       ; backspace again.
        mov ah, 2
	    mov dl, 8
	    int 21h
	    
        JMP     next_digit
    backspace_checked:


        ; allow only digits:
        CMP     AL, '0'
        JAE     ok_AE_0
        JMP     remove_not_digit
    ok_AE_0:        
        CMP     AL, '9'
        JBE     ok_digit
    remove_not_digit:       
        ;PUTC    8       ; backspace.
        mov ah, 2
	    mov dl, 8
	    int 21h
        
        ;PUTC    ' '     ; clear last entered not digit. 
        mov ah, 2
	    mov dl, ' '
	    int 21h
        
        ;PUTC    8       ; backspace again. 
        mov ah, 2
	    mov dl, 8
	    int 21h       
        JMP     next_digit ; wait for next input.       
    ok_digit:


        ; multiply CX by 10 (first time the result is zero)
        PUSH    AX
        MOV     AX, CX
        MUL     CS:ten                  ; DX:AX = AX*10
        MOV     CX, AX
        POP     AX

        ; check if the number is too big
        ; (result should be 16 bits)
        CMP     DX, 0
        JNE     too_big

        ; convert from ASCII code:
        SUB     AL, 30h

        ; add AL to CX:
        MOV     AH, 0
        MOV     DX, CX      ; backup, in case the result will be too big.
        ADD     CX, AX
        JC      too_big2    ; jump if the number is too big.

        JMP     next_digit

    set_minus:
        MOV     CS:make_minus, 1
        JMP     next_digit

    too_big2:
        MOV     CX, DX      ; restore the backuped value before add.
        MOV     DX, 0       ; DX was zero before backup!
    too_big:
        MOV     AX, CX
        DIV     CS:ten  ; reverse last DX:AX = AX*10, make AX = DX:AX / 10
        MOV     CX, AX
        ;PUTC    8       ; backspace. 
        mov ah, 2
	    mov dl, 8
	    int 21h
        
        ;PUTC    ' '     ; clear last entered digit.
        mov ah, 2
	    mov dl, ' '
	    int 21h
        
        ;PUTC    8       ; backspace again. 
        mov ah, 2
	    mov dl, 8
	    int 21h
	           
        JMP     next_digit ; wait for Enter/Backspace.
        
        
    stop_input:
        ; check flag:
        CMP     CS:make_minus, 0
        JE      not_minus
        NEG     CX
    not_minus:

        POP     SI
        POP     AX
        POP     DX
        RET
    make_minus      DB      ?       ; used as a flag.
    ten             DW      10      ; used as multiplier.
    SCAN_NUM        ENDP

    skip_proc_scan_num:

      ENDM 
    
    
    
    
    ;------------------------------------------------------------  
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
	    
	    
	    
     
    DEFINE_SCAN_NUM  
    DEFINE_PTHIS
end
    