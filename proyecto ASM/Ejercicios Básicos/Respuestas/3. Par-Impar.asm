.model small
.stack
.data

   var1 db ?
   num  db ?
   aux  db ?  
   msgp db 'El numero introducido es par.$'
   msgi db 'El numero introducido es impar.$'
 
.code
.startup

    mov ah,01h              
    int 21h      
    sub al,30h   
    and al,1
    cmp al,1
   
    je impar
    mov dx,offset msgp   
    jmp continua
    impar:
    mov dx,offset msgi       
    continua:             
    mov ah,09h           
    int 21h
    RET

.exit
end