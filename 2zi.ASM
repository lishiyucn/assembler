wai:	mov bl,9
			mov di,160*12+36*2
			mov cx,3
			
	nian:	push cx
			mov al,bl
			out 70h,al
			in al,71h
			
			mov ah,al
			mov cl,4
			shr ah,cl
			and al,00001111b
			
			add ah,30h
			add al,30h
			
			mov dx,0b800h
			mov es,dx
			pop cx
			mov BYTE ptr es:[di],ah
			mov BYTE ptr es:[di+2],al
			cmp cx,1
			je k
			mov BYTE ptr es:[di+4],'/'
			
		k:	add di,6
			dec bl
			
			loop nian
			
			mov cx,3
			mov bh,4
	shi:	push cx
			mov al,bh
			out 70h,al
			in al,71h
			
			mov ah,al
			mov cl,4
			shr ah,cl
			and al,00001111b
			
			add ah,30h
			add al,30h
			
			pop cx
			mov BYTE ptr es:[di],ah
			mov BYTE ptr es:[di+2],al
			cmp cx,1
			je k1
			mov BYTE ptr es:[di+4],':'
	k1:	add di,6
			dec bh
			dec bh
			
			loop shi
			mov cx,5000
	kong: nop
			loop kong
			jmp wai