assume cs:code
code segment
	show_mm:	push ax
			push ds
			push si
			push bx
			
			jmp short smm_start
		mmstr1 db '1.reset pc',0
		mmstr2 db '2.start system',0
		mmstr3 db '3.clock',0
		mmstr4 db '4.set clock',0
		mmtab  dw mmstr1,mmstr2,mmstr3,mmstr4
smm_start:		
			mov ax,0b800H
			mov ds,ax
			mov si,0
			
			mov ah,0
strs:		cmp ah,4
			jnb mmend
			
			mov bl,ah
			mov bh,0
			add bx,bx
			mov bx,mmtab[bx]
			
			push si
item:		
			mov al,cs:[bx]
			cmp al,0
			je itemend
			mov ds:[si],al
			inc si
			mov BYTE  ptr ds:[si],2
			inc si
			inc bx
			jmp item
itemend:	
			pop si
			add si,160
			inc ah
			jmp short strs
mmend:
			pop bx
			pop si
			pop ds
			pop ax
			ret
		
clsscr:		
			push ax
			push ds
			push si
			push cx
			
			mov ax,0b800H
			mov ds,ax
			mov si,0
			
			mov cx,160*25
			
cs_lp:		mov BYTE ptr ds:[si],' '
			inc si
			mov BYTE ptr ds:[si],2
			inc si
			loop cs_lp
			
			pop cx
			pop si
			pop ds
			pop ax
			ret
code ends
end start