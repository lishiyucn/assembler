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
			
			cmp al,1Eh
			je k1
			cmp al,1Eh+80h
			je k
			jmp int9ret
			
	k1:	mov ax,0b800h
			mov es,ax
			mov bx,0
			mov cx,2000
	s1:	mov BYTE ptr es:[bx],0
			add bx,2
			loop s1
			
			jmp int9ret
			
	k:		mov ax,0b800h
			mov es,ax
			mov bx,0
			mov cx,2000
			
	s:		mov BYTE ptr es:[bx],41h
			add bx,2
			loop s
			
			jmp int9ret
			
			
	
			
	int9ret:pop es
			  pop cx
			  pop bx
			  pop ax
			  iret
			  
int9end:nop
code ends
end start