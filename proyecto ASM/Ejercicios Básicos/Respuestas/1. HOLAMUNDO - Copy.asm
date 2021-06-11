.model tiny
.data
      msg   db "Hello World!$" ; The string must ends with a $
      var1 dw ?
.code
	.startup
	mov   dx,offset msg ; Get the address of our message in the DX 
	
	
	mov   ah,9			; Function 09h in AH means "WRITE STRING TO STANDARD OUTPUT"	
	   
	   
	mov bl,1010b;color azul
	mov cx,12 ; numero de caracteres
	int 10h;
	
	int   21h
	
				; Call the DOS interrupt (DOS function call)
	
	mov   ax,0C07h			; Call bios function "GET KEYSTROKE"
	int   21h
	.exit
end