assume cs:code

code segment
	row:	db 9,8,7,4,2,0
	sg: 	db '/','/',' ',':',':',' '
	
	start:nop
	wai:	mov si,offset row
			mov bp,offset sg
			mov ax,cs
			mov ds,ax
	
			mov di,160*12+36*2
			mov cx,6
			
	s:		push cx
			mov bl,ds:[si]
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
			mov dl,ds:[bp]
			mov BYTE ptr es:[di+4],dl
			
			add di,6
			inc si
			inc bp
			
			loop s
			
			
			;mov cx,5000
	;kong: nop
			;loop kong
			jmp wai
			
			mov ax,4c00h
			int 21h
code ends
end start