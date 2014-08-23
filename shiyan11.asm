assume cs:code


stack segment

	db 16 dup(0)

stack ends
code segment

start:	mov ax,0b800h
	mov ds,ax

	mov ax,stack
	mov ss,ax
	mov sp,10h

	mov di,4b0h
	mov bx,0
	mov cx,10
     s0:mov al,41h
	mov ah,00001010b
	mov ds:[bx+di],ax
	add bx,0a0h

	loop s0

	mov di,54eh
	mov bx,0
	mov cx,9
	mov si,552h
     s1:mov al,41h
	mov ah,00001010b
	mov ds:[bx+di],ax

	mov ds:[bx+si],ax
	add bx,0a0h

	loop s1

	mov di,5ech
	mov bx,0
	mov cx,8
	mov si,5f4h
     s2:mov al,41h
	mov ah,00001010b
	mov ds:[bx+di],ax

	mov ds:[bx+si],ax
	add bx,0a0h

	loop s2

	
	mov di,68ah
	mov bx,0
	mov cx,7
	mov si,696h
     s3:mov al,41h
	mov ah,00001010b
	mov ds:[bx+di],ax

	mov ds:[bx+si],ax
	add bx,0a0h

	loop s3



	mov ax,4c00h
	int 21h
code ends
end start
