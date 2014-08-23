assume cs:code,ds:data
data segment
		a db 3,2,1,0
		b db 0,1,2,3,4,5,6,7
data ends
code segment

	start:mov al,2
			mov ah,3
			int 7ch
	
			mov ax,4c00h
			int 21h
			
code ends
end start
						