assume cs:code

data segment

			db "welcome to masm!",0
			
data ends

code segment

	start:  mov ax,data
			  mov ds,ax
			  mov si,0
	show:		mov ax,0b800h
				mov es,ax
				mov di,160*10+2*10
	showa: cmp BYTE ptr ds:[si],0
				je ok
				
				mov al,ds:[si]
				mov es:[di],al
				mov ah,2
				
				mov es:[di+1],ah
				inc si
				add di,2
				jmp showa
		ok:	ret
		
code ends
end start