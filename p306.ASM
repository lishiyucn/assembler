assume cs:code

code segment
	getstr:	push ax
				
	getstrs:	mov ah,0
				int 16h
				cmp al,20h		;ASCII码小于20H，说明不是字符
				jb	 nochar
				mov ah,0
				call charstack
				mov ah,2		;显示栈中的字符
				call charstack
				jmp getstrs
				
	nochar:	cmp ah,0eh		;退格键的扫描码
				je backspace
				cmp ah,1ch		;Enter键的扫描码
				je ente
				jmp getstrs
				
	backspace:mov ah,1
				 call charstack		;字符出栈
				 mov ah,2
				 call charstack		;显示栈中的字符
				 jmp getstrs
				 
	ente:	 	 mov al,0		;将0入栈，作为返回标识
				 mov ah,0		
				 call charstack
				 mov ah,2		;ah=2，对应2功能
				 call charstack
				 pop ax
				 ret
				 
	
	charstack:jmp short charstart
				 
		table		dw charpush,charpop,charshow
		top		dw 0
		
		charstart:push bx
					 push dx
					 push di
					 push es
					 
					 cmp ah,2
					 ja sret
					 mov bl,ah
					 mov bh,0
					 add bx,bx
					 jmp WORD ptr table[bx]
					 
		charpush: mov bx,top
					 mov [si][bx],al
					 inc top
					 jmp sret
					 
		charpop:	 cmp top,0
					 je sret
					 dec top
					 mov bx,top
					 mov al,[si][bx]
					 jmp sret
					 
		charshow: mov bx,0b800h
					 mov es,bx
					 mov al,160
					 mov ah,0
					 mul dh
					 mov di,ax		;行的偏移地址给di
					 add dl,dl		;列的地址*2 = 偏移地址 
					 mov dh,0		;行的偏移 + 列的偏移
					 add di,dx
					 
					 mov bx,0
					 
		charshows:cmp bx,top
					 jne noempty
					 mov BYTE ptr es:[di],' '
					 jmp sret
		noempty:	 mov al,[si][bx]
					 mov es:[di],al
					 mov BYTE ptr es:[di+2],' '
					 inc bx
					 add di,2
					 jmp charshows
					 
		sret:		pop es
					pop di
					pop dx
					pop bx
					ret
			
			mov ax,4c00h
			int 21h
	
	
code ends
end getstr
