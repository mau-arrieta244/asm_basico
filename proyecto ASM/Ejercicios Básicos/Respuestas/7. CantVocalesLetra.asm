data segment     
    cant db 0
    Hora db "Hola mundo"   
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax
      
    ;El registro bx apunta hacia la variable        
    xor bx, bx            
    mov bx, offset Hora                     
    
    
    ;Realizo un ciclo para determinar cuantas vocales existen   
    ciclo:    
        cmp [bx+si], "a"
            je vocal
        cmp [bx+si], "e"
            je vocal
        cmp [bx+si], "i"
            je vocal    
        cmp [bx+si], "o"
            je vocal        
        cmp [bx+si], "u"
            je vocal            
        cmp [bx+si], 0 ;El cero (0) determina que la cadena llego a su fin
            je salir   
                    
        ;Asigna el valor de cada posicion en al (por ejemplo: 68h (104d) --> que corresponde a la h de hola)             
        xor ax,ax    
        mov al,[bx+si]       
        
        inc si
        jmp ciclo    
                                                         
                 
    vocal:  
        add cant,1
        inc si    
        jmp ciclo
    
    salir:
        mov ah,00h ;Establece el modo de texto
        mov al,03h
        int 10h
          
    mov ax, 2           
ends

end start
