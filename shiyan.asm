assume cs:code

code segment
	dw 0101h,0202h,0303h,0404h
  start: mov ax,0b810h
	 mov ds,ax

	 mov bx,0h
	 mov cx,4

    s:   mov ax,cs:[bx]
         mov ds:[bx],ax
	 add bx,2
	 

	 loop s

	 mov ax,4c00h
	 int 21h

	 

code ends
end