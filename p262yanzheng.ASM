assume cs:code

data segment

			db "welcome to masm!",0
			
data segment

code segment

	start:  mov ax,data
			  mov ds,ax
			  mov si,0
			  show: cmp BYTE ptr ds:[si],0
				je ok
				mov ax,0b800h
				mov es,ax
				mov di,160*10+2*10
				mov al,ds:[si]
				mov ah,2
				mov es:[di],al
				mov es:[di+2],ah
				inc si
				add di,2
				jmp show
		ok:	iret