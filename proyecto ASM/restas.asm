
;resta de punto flotante
include 'emu8086.inc'
.model small

.data
   ;entero1 db ?
   ;flotante1 db ? 
   
   ;entero2 db ?
   ;flotante2 db ? 
   
   entero1 dw 9 dup (?) ;7 posiciones, 3 entero, 1 punto, 3 parte fraccionaria
                        
   ;indice1 db ?
   
.code 
    
    ;mov indice1,0 ; inicia en 0, va aumentando 
    mov bl,0
    ;----------------------------------------------------------

    mov ah, 1 ;ingreso primer digito
	int 21h
	
	mov entero1[bx],ax ;almacenamos primer digito en entero1[0]
	
	
	;mov ah, 2
	;mov dx, entero1[bx]
	;int 21h 
	
	inc bl  ;indice+=1
	;---------------------------------------------------------- 
	
	mov ah, 1
	int 21h
	mov entero1[bx],ax ;almacenamos segundo dig. en entero1[1] 
	
    inc bl 
    ;-----------------------------------------------------------
	 
	
	mov ah, 1
	int 21h
	mov entero1[bx],ax ;almacenamos tercer dig. en entero1[2] 
	
    inc bl 
    ;----------------------------------------------------------- 
    
    mov ah, 1
	int 21h
	mov entero1[bx],ax ;almacenamos cuarto dig. en entero1[3] 
	
    inc bl 
    ;----------------------------------------------------------- 
    
    
    mov ah, 1
	int 21h
	mov entero1[bx],ax ;almacenamos quinto dig. en entero1[4] 
	
    inc bl 
    ;-----------------------------------------------------------
    
    
    mov ah, 1
	int 21h
	mov entero1[bx],ax ;almacenamos sexto dig. en entero1[5] 
	
    inc bl 
    ;-----------------------------------------------------------
    
    
    mov ah, 1
	int 21h
	mov entero1[bx],ax ;almacenamos setimo dig. en entero1[6] 
	
    inc bl 
    ;----------------------------------------------------------- 
    
    
    ;almacenar parte entera en variable (hasta el '.') 
    xor bx,bx ;limpiamos registro B para indices
    mov bx,0 
    
    mov al,0
    add ax,entero1[bx] 
        
    printn    
    mov ah, 2
	mov dx, ax
	int 21h
    
    inc bl 
    
    add ax,entero1[bx]
    
    
    printn    
    mov ah, 2
	mov dx, ax
	int 21h
	;----------
    
    inc bl
    
    add ax,entero1[bx]
    
    inc bl
    
    add ax,entero1[bx]
    
    inc bl
    
    ;call print_sum ; procedimiento
    
    
    
	
	
	
	  
	PRINT_SUM PROC NEAR
    CMP AL, 0
    JNE PRINT_AX
    PUSH AX
    MOV AL, '0'
    MOV AH, 0EH
    INT 10H
    POP AX
    RET 
        PRINT_AX:    
        PUSHA
        MOV AH, 0
        CMP AX, 0
        JE PN_DONE
        MOV DL, 10
        DIV DL    
        CALL PRINT_AX
        MOV AL, AH
        ADD AL, 30H
        MOV AH, 0EH
        INT 10H    
        PN_DONE:
            POPA  
            RET  
    PRINT_SUM ENDP  
	
	
	
	
	    
	    
	    
	;------------------------------------------------------------  
    ;------------------------------------------------------------
    ;------------------------------------------------------------
    ;------------------------------------------------------------   
	    
	    
	    
    DEFINE_PRINT_NUM_UNS 
    DEFINE_SCAN_NUM  
    DEFINE_PTHIS

end