assume cs:code

code segment
	start:mov ax,cs
			mov ds,ax
			mov si,offset show
			
			mov ax,0
			mov es,ax
			mov di,200h
			mov cx,offset showend-offset show		;将程序放入 0:200安全空间去
			cld
			rep movsb
			
			
			mov ax,0
			mov es,ax
			mov WORD ptr es:[7ch*4],200h		;修改7ch中断向量表到我们的中断程序中
			mov WORD ptr es:[7ch*4+2],0
			
			mov ax,4c00h
			int 21h
			
	show: push cx
			cmp BYTE ptr ds:[si],0
			je ok
			mov ax,0b800h
			mov es,ax
			mov di,160*10+2*10
			mov al,ds:[si]
			mov es:[di],al
			inc si
			add di,2
			jmp show
	ok:	pop cx
			iret
	showend:nop

code ends
end start
			