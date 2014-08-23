assume cs:code


code segment

	start: mov ax,0b800h
			 mov es,ax
			 mov di,25*160
			 mov bx,35
			 
			 mov cx,12
		ban:mov al,'='
			 mov ah,2
			 mov es:[bx+di],al
			 mov es:[bx+di+1],ah
			 add di,2
			 loop ban
			 
			 int 9
			 
			 cmp al,4bh
			 je zuo
			 cmp al,4d
			 je you
			 jmp off
			 
		zuo:sub bx,2
			 jmp ban
			 
		you:add bx,2
			 jmp ban
			 
		off:iret
		
		mov ax,4c00h
		int 21h
		
code ends
end start
			 
			 
			 