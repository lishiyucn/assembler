assume cs:code

stack segment
		db 128 dup(0)
stack ends

code segment

	start:mov ax,stack
			mov ss,ax
			mov sp,128
			
			push cs
			pop ds
			
			mov ax,0
			mov es,ax
			
			mov si,offset int9
			mov di,204h
			mov cx,offset int9end-offset int9
			cld
			rep movsb
			
			push es:[9*4]
			pop es:[200h]
			push es:[9*4+2]
			pop es:[202h]
			
			cli
			mov WORD ptr es:[9*4],204h
			mov WORD ptr es:[9*4+2],0
			sti
			
			mov ax,4c00h
			int 21h
			
	int9:	push ax
			push bx
			push cx
			push es
			
			in al,60h
			pushf
			call DWORD ptr cs:[200h]		;当此中断例程执行时cs=0
			
			cmp al,02			;f1的扫描码是3bh
			je hao1
			cmp al,03
			je hao2
			cmp al,04
			je hao3
			cmp al,05
			je hao4
			jmp int9ret
			
		hao4:mov al,2
			  mov ah,3
			  int 7ch
			  jmp int9ret
			  
		hao3:mov al,7
			  mov ah,2
			  int 7ch
			  jmp int9ret
			  
		hao2:mov al,2
			  mov ah,1
			  int 7ch
			  jmp int9ret
			  
			  hao1:mov al,2
			  mov ah,0
			  int 7ch
			  jmp int9ret
			
	int9ret:pop es
			  pop cx
			  pop bx
			  pop ax
			  iret
			  
int9end:nop
code ends
end start
			
						