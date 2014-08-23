assume cs:code

code segment
	start:push ax
			push cx
			push si
			push di
			
			sub ax,ax ;Ω´cf…Ë÷√Œ™0
			
			mov cx,8
		s: mov ax,ds:[si]
			adc ax,ds:[di]
			mov ds:[si],ax
			inc si
			inc si
			inc di
			inc di
			loop s
			
			pop di 
			pop si
			pop cx
			pop ax
			
			ret
			
			mov ax,4c00h
			int 21h

code ends
end start