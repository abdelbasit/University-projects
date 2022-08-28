name "add-sub"

org 100h

.data
var db 10 dup(?)

.code
 mov si,offset var
 mov cl,0

input: MOV AH,01
       INT 21H
       cmp al,'a'
       jz set
       cmp al,'e'
       jz set
       cmp al,'i'
       jz set
       cmp al,'o'
       jz set 
       cmp al,'u'
       jz set
       

       CMP AL,'$'
       jNZ input 
        
      set:
      MOV [SI],AL
      INC SI
      inc cl
      cmp cl,10
      jz end 
       CMP AL,'$'
       jNZ input 
      
 end:
 call clrscr
 mov [si] ,'$'
 mov dx, offset var
		mov ah, 9
		int 21h
		ret
		
		clrscr proc near
   mov ax,0b800h
   mov es,ax
   mov di,0
   mov al,' '
   mov ah,07d
   loop_clear_12:
        mov word ptr es:[di],ax
        inc di
        inc di
        cmp di,4000
        jle loop_clear_12
        ret
endp
      



