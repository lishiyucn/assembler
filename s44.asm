assume cs:code

code segment

	mov ax,0b810h
	mov ds,ax

	mov bx,0h;

	mov ah,00a1h
	mov al,'a'
	mov cx,66

      s:mov ds:[bx],ax
        inc bx
	inc bx
	loop s

	mov ax,4c00h
	int 21h
code ends
end