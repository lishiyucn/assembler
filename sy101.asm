assume cs:code,ds:data

data segment

	db 'We',0

data ends

;stack segment

;	db 16 dup (0)

;stack ends

code segment

start:  mov dh,8
	mov dl,15
	mov cl,2
	mov ax,0b800h
	mov es,ax
	mov ax,data
	mov ds,ax
	;mov al,0a0h
	;mov ds:[32],al
	;mov al,2
	;mov ds:[33],al
	mov si,0
	mov di,0
	
	call far ptr show_str

	mov ax,4c00h
	int 21h

show_str:
	 push ax
	 push dx
	 push bx
	; push es
	 ;push ds
	 push cx

	 

	 mov cl,ds:[si]
	 mov ch,0
	 jcxz ok

	 
	 mov al,0a0h
	 mul dh
	 mov bx,ax

	 mov al,2
	 mul dl
	 add bx,ax

	 mov al,ds:[si]
	 pop cx
	 mov ah,cl
	 mov es:[bx+di],ax
	 inc si
	 add di,2

	 jmp show_str

      ok:pop cx
         ;pop ds
	; pop es
	 pop bx
	 pop dx
	 pop ax
	 retf
	 
code ends
end start