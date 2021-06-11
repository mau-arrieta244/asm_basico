.model tiny
.data
      num1 db 0
      num2 db 0
      Titulo DB         'Ejemplo - Suma ','$'
      Msg1 DB 10,13,    'Digite el primer n£mero: ','$'
      Msg2 DB 10,13,    'Digite el segundo n£mero: ','$'
      Result DB 10,13,  'El Resultado de la suma es: ','$'
      TipoOperacion DB 10,13,  'Digite "S" para Suma o "R" para Resta: ','$'
.code
.startup

    mov dx, offset Titulo
    mov ah,9			
	int 21h			    
	       
	mov dx, offset Msg1
    mov ah,9			
	int 21h			    
	       
	mov ah,01h			
    int 21h             
    sub al,48           
    mov num1,al  			
                
    mov dx, offset Msg2
    mov ah,9			
	int 21h			    
	       
	mov ah,01h          ;Capturar una tecla y la deja en AL			
    int 21h             ;Int 21 (DOS)              
    sub al,48           
	mov num2,al    	             	        
	         
	mov dx, offset TipoOperacion	
    mov ah,9			
	int 21h	       
	
	mov ah,01h			
    int 21h             
    cmp al, "R"              
    jne Suma
	xor al, al          ;xor x, x = mov x, 0	              
    mov al, num2	             
    sub num1, al  
    jmp Sig      
	Suma:	              
    xor al, al	              
    mov al, num2	             
    add num1, al    
           
    Sig:           
    add num1, 30h
	                                  
    mov dx, offset Result	
    mov ah,9			
	int 21h	      	
	          
    xor dx, dx	          
	mov dl, num1	
    mov ah,02h			
	int 21h	
                 		       					              
	mov ah,0			
    int 16h             
.exit

end