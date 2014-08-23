assume cs:code

code segment

	start:mov ax,0b800h
			mov es,ax
			mov si,8*160+12*2
	
			
			mov al,0
			mov ah,00010000b
			mov es:[si],al
			mov es:[si+1],ah
			
			
			
code ends
end start