assume cs:code,ds:data

data segment
	db 'welcome to masm!'
data ends

code segment

  start: mov ax,data
	 mov ds,ax

	 mov ax,0b800h
	 mov es,ax

	 mov si,0
	 mov di,0

	 mov bx,0
	 mov cx,10h
    s:		
		 mov al,ds:[si]
		 mov ah,00001010b
		 mov es:[bx+744h+di],ax
		 inc si
		 add di,2

	 inc si
	 add di,2

	 loop s

	 mov si,0
	 mov di,0

	add bx,0a0h
	 mov cx,10h
    s1:		
		 mov al,ds:[si]
		 mov ah,00101100b
		 mov es:[bx+744h+di],ax
		 inc si
		 add di,2

	 inc si
	 add di,2

	 loop s1

	 mov si,0
	 mov di,0

	 add bx,0a0h
	 mov cx,10h
    s2:		
		 mov al,ds:[si]
		 mov ah,01111001b
		 mov es:[bx+744h+di],ax
		 inc si
		 add di,2

	 inc si
	 add di,2

	 loop s2

	 mov ax,4c00h
	 int 21h


	 

code ends
end start