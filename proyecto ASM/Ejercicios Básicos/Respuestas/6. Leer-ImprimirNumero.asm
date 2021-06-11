.model small
.stack
.data

   var1 db ?
   num  db ?
   aux  db ?
 
.code
.startup

    mov var1,0   ;Residuo de cero
    mov ah,01h   
    int 21h    
    sub al,30h   
    mov num,al   
    
    mov al,num  
    mov bl,10    
    mul bl       
    mov aux,al   
    
    mov var1,0   
    mov ah,01h
    int 21h      
    sub al,30h
    add aux,al   
    mov bl,aux   
    mov num,bl                                                    
    
    mov ah,02h   ;Imprimimos signo de igual
    mov dl,'='
    int 21h
                             
    ;Procedemos a imprimir el numero   
    mov al, num
    xor ah, ah ;Pongo el byte de mayor peso a cero.
    mov bh, 10 ;Voy a dividir entre 10.
    div bh
    mov bh, ah ;Guardo el resto de la division.
    
    cmp al, 0 ;Si el resultado es cero, estamos ante un numero de una sola cifra.
    je segund ;Por lo tanto, no imprimo la primera ya que es un cero.
    
    mov dl,al ;pongo en dl el numero a imprimir
    add dl,30h ; agrego 30 (48Dec) para obtener el caracter
    mov ah,02h ;funcion para imprimir un caracter en pantalla
    int 21h
    
    ;Imprimo el resto de la division:
    segund:
    mov dl, bh
    add dl, 30h
    mov ah, 02h
    int 21h


.exit
end
  

  mov ah,09h
  lea Dx,cad
  int 21h

.exit
end