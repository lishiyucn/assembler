assume cs:code,ds:yihang

yihang segment

	dw 80 dup('A')

yihang ends

stack segment

	db 16 dup(0)

stack ends
code segment

start:	mov ax,yihang
	mov ds,ax

	mov ax,0b800h
	mov es,ax

	mov ax,stack
	mov ss,ax
	mov sp,10h

	mov bx,0
	mov cx,12

	s1:push cx
		mov di,0
		mov cx,40
		mov si,0

	      s:push cx
	      
		mov al,ds:[si]
		mov ah,00001010b
		mov es:[bx+di],ax
		add di,4
		add si,2

		pop cx
		loop s

		mov di,2
		mov cx,40
		mov si,0
		add bx,0a0h

	     s0:push cx
	      
		mov al,ds:[si]
		mov ah,00001010b
		mov es:[bx+di],ax
		add di,4
		add si,2

		pop cx
		loop s0



	pop cx
	add bx,0a0h

	loop s1

	mov di,0
	mov cx,40
	mov si,0

      s2:mov al,ds:[si]
	mov ah,00001010b
	mov es:[bx+di],ax
	add di,4
	add si,2

	loop s2

	mov ax,4c00h
	int 21h
code ends
end start