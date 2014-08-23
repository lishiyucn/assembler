assume cs:code

code segment

	start:mov ax,cs
			mov ds,ax
			mov si,offset lp
			
			mov ax,0
			mov es,ax
			mov di,200h
			mov cx,offset lpend-offset lp
			cld
			rep movsb  ;以上是把终端程序加入到内存中的 0:200处
			
			mov ax,0
			mov es,ax
			mov WORD ptr es:[7ch*4],200h
			mov WORD ptr es:[7ch*4+2],0
			mov ax,4c00h
			int 21h
			
	lp:   push bp
		   mov bp,sp
			dec cx
			jcxz lpret ;如果cx值为0后，循环结束直接跳出
			add ss:[bp+2],bx ;计算 sp=bp  sp为栈顶地址  bp+2得到se 的偏移地址 se与s 的转移位移放在 bx中，再加上 bx值，可跳回循环程序继续执行
			
	lpret:pop bp
			iret
	lpend:nop
	
code ends
end start