assume cs:code,ss:stack,ds:data

stack segment

	dw 8 dup (0)

stack ends

data segment 

	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '

data ends

code segment

start:  mov ax,data
	mov ds,ax

	mov ax,stack
	mov ss,ax
	mov sp,10h

	mov cx,4
	mov bx,0
s0:     push cx
		
		mov cx,4
		mov si,3h
	    s1: mov al,ds:[bx+si]
		and al,11011111B
		mov ds:[bx+si],al
		inc si

		loop s1
		
	
	add bx,10h
	pop cx
	loop s0




	mov ax,4c00h
	int 21h

code ends
end start