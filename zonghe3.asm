assume cs:code

stack segment

	db 16 dup (0)

stack ends
code segment

start:	mov ax,20h
	mov ds,ax

	mov ax,stack
	mov ss,ax
	mov sp,10h

	

	
	mov bx,0
	mov cx,128
   s0:  mov ds:[bx],bx
	inc bx
	loop s0

	mov cx,8
	mov bx,0
   s3:  push cx

		mov cx,8
		mov di,0
		mov si,0fh
	     s: mov al,ds:[bx+di]
		mov ah,ds:[bx+si]
		mov ds:[bx+si],al
		mov ds:[bx+di],ah
		inc di
		sub si,1h
		loop s

	add bx,10h
	pop cx
	loop s3

	mov cx,10h
	mov bx,0
s1:     push cx
		mov cx,4
		mov di,0h
		mov si,70h
	   s2:  mov al,ds:[bx+di]
		mov ah,ds:[bx+si]

		mov ds:[bx+si],al
		mov ds:[bx+di],ah

		add di,10h
		sub si,10h

		loop s2

	add bx,1h
	pop cx
	loop s1

	

	mov ax,4c00h
	int 21h

code ends
end start
