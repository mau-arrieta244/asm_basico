.model tiny
.data
      num1 db 0
      num2 db 0      
      Menos DB          '-'          
      Msg2 DB 10,13,    'NUMERO NEGATIVO ','$'      
      Msg3 DB 10,13,    'NUMERO POSITIVO ','$'    
.code
.startup
  
	mov num1, 5   
	mov num2, 7	
	mov al,num2
	sub num1,al    
	
	cmp num1, 0
	JGE POSTIVO
		    
	mov ah,9 
    mov dx,offset Msg2
    int 21h    
              
    xor dx,dx              
    mov ah,02h 
    mov dl,Menos
    int 21h    
    
    NEG num1	       ;Esta operando convierte a complemento base 2
    mov dl,num1  
    add dl,30h 
    mov ah,02h             
    int 21h  
    
    JMP FIN
    
    POSTIVO: 
        
    mov ah,9 
    mov dx,offset Msg3
    int 21h     
       
    mov dl,num1  
    add dl,30h 
    mov ah,02h             
    int 21h       
    
    FIN:
                 		       					              
	mov ah,0			
    int 16h             
.exit

end