assume cs:code,ds:data
data segment
		a db 3,2,1,0
		b db 0,1,2,3,4,5,6,7
data ends
code segment

	start:mov ax,data
			mov ds,ax
			
			mov bx,0
			mov cx,4
			
	s:		mov ah,a[bx]
			push cx
			
			mov cx,8
			mov si,0
		s1:mov al,b[si]
			inc si
			int 7ch
			call delay
			loop s1
			inc bx
			pop cx
			
			call delay
			loop s
			
			
	delay:push ax
			push dx
			mov dx,10h
			mov ax,0
			
		s3:sub ax,1
			sbb dx,0
			cmp ax,0
			jne s3
			cmp dx,0
			jne s3
			pop dx
			pop ax
			ret
			
			
			
			mov ax,4c00h
			int 21h
			
code ends
end start
						