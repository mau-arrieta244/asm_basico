
.MODEL Small
.DATA
        Msg DB 10,13,'Digite una tecla: ','$'
        Msg2 DB 10,13,'No preciono tecla "Enter"!','$'
        Msg3 DB 10,13,'Tecla "Entrer" presionada...!','$'
.CODE
        Start:
                mov ax,@data
                mov ds,ax

                ciclo:
                        mov ah,9
                        mov dx, Offset Msg
                        int 21h

                        mov ah,00h
                        int 16h     ;Se captura la tecla

                        cmp al,13   ;Enter --> 13 representa el ASCII 
                        je final

                        mov ah,9
                        mov dx, Offset Msg2
                        int 21h

                        jmp ciclo                        

                final:
                        mov ah,9
                        mov dx, Offset Msg3
                        int 21h
                        
                        mov ah,4ch
                        int 21h
        END Start               
