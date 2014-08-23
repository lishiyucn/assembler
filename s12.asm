					assume cs:code
					
					code segment
					start:	mov ax,0b800h
								mov ds,ax
								mov di,0
								mov si,0
								mov cx,2000
					
					   s:   mov al,ds:[di]
							  cmp al,'z'+1
					        jb next
					        call qita
					     p: add si,2
							  add di,2
						     loop s
								
					
								mov ax,4c00h
								int 21h
								
					    next:cmp al,'A'-1
								ja next1
								call qita
								
								
					   next1:cmp al,'Z'+1
					   	   jb da
					   	   cmp al,'a'-1
					   		ja xiao
					   		call qita
					   		
					   	
						   da:mov ah,1010b
								mov ds:[si+1],ah
								mov ds:[si],al
								
								jmp p 
								
						 xiao:mov ah,1001b
								mov ds:[si+1],ah
								mov ds:[si],al
								
								jmp p
								
						qita: mov ah,0b
								mov ds:[si+1],ah
								mov ds:[si],al
								
								jmp p
					
					code ends
					end start