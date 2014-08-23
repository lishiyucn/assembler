assume cs:code

code segment
	
	mov ax,cs
	mov ds,ax
	mov ax,076ah
	mov es,ax
	mov bx,0
	mov cx,23

    s:  mov al,ds:[bx]
	mov es:[001a+bx],al
	inc bx

	loop s

	mov ax,4c00h
	int 21h 
code ends
end