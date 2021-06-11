include 'emu8086.inc'


data segment     
    cant db 0
    Hora db "06:25:44"   
    cant_h dw ?
    cant_m dw ?
    cant_s dw ?
    msg  db 'Total de segundos: '
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax
      
    ;El registro di apunta hacia la variable            
    mov di, offset Hora                     
    
    ;Se obtiene la cantidad de horas
    mov al, [di] 
    sub al, 30h
    mov bl, 10
    mul bl
    mov cant_h, ax 
    inc di
    mov al, [di]  
    sub al, 30h
    add cant_h, ax         
    
    ;Se obtienen los minutos
    add di,2
    xor ax, ax
    mov al,[di]
    sub al, 30h
    mov bl, 10
    mul bl
    mov cant_m, ax 
    inc di
    mov al, [di]  
    sub al, 30h
    add cant_m, ax
    
    ;Se obtienen los segundos
    add di,2
    xor ax, ax
    mov al,[di]
    sub al, 30h
    mov bl, 10
    mul bl
    mov cant_s, ax 
    inc di
    mov al, [di]  
    sub al, 30h
    add cant_s, ax                  
    
    ;Se obtiene el equivalente en segundos
    xor ax,ax
    xor bx,bx
    
    mov ax, cant_h
    mov bx, 3600
    mul bx  
    add cant_s, ax
    
    mov ax, cant_m
    mov bx, 60
    mul bx  
    add cant_s, ax
                                                                                             
    
    LEA  SI, msg       
    CALL print_string  
                                                                                            
    mov ax, cant_s                                               
    CALL   print_num      ; print number in AX.
                                                                     
	mov   ax,0C07h			; Call bios function "GET KEYSTROKE"
	int   21h
	          
             


DEFINE_PRINT_STRING
DEFINE_PRINT_NUM  
DEFINE_PRINT_NUM_UNS  ; required for print_num.

end start     

ends 
