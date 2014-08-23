assume cs:code,ss:stack


stack segment

	db 16 dup(0)

stack ends
code segment

start:	mov ax,0b800h
	mov ds,ax

	mov ax,stack
	mov ss,ax
	mov sp,10h

        mov si,4b0h
        mov di,4b0h
        mov cx,10
     s1:push cx
		mov bx,0
		pop cx
		push cx
	     s0:mov al,41h
		mov ah,00001010b
		mov ds:[bx+di],ax
		mov ds:[bx+si],ax
		add bx,0a0h

		loop s0

	sub di,2
	add di,0a0h
	add si,2
	add si,0a0h
	pop cx
	loop s1

	mov ax,4c00h
	int 21h
code ends
end start
