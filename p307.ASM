assume cs:code

code segment

	start: call getstr
	
		getstr:	push ax
		
		getstrs: mov ah,0
					int 16h
					cmp al,20h
					jb nochar