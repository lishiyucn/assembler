assume cs:code,ss:stack

stack segment
	dw 0101h,0202h,0303h,0404h
stack ends

code segment
	
  start: mov ax,0b810h
	 mov ds,ax

	 mov ax,stack
	 mov sp,0h

	 mov bx,0h
	 mov cx,4

    s:   pop ax
         mov ds:[bx],ax
	 add bx,2
	 

	 loop s

	 mov ax,4c00h
	 int 21h

	 

code ends
end