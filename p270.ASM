assume cs:code

code segment
		start:mov al,8		;端口传值必须经过al，把8传送给al
				out 70h,al	;在70h地址端口写入要访问的地址单元
				in al,71h	;从71h端口读出我们要访问的端口单元地址的数据
				
				mov ah,al
				mov cl,4
				shr ah,cl	;把低四位，向右移除，剩下高四位，作为十位数码值
				add al,00001111b  ;and是清零， 0--0 1不变  or是置1  1--1 0不变
				
				add ah,30h
				add al,30h	;BCD码值 + 30h =十进制数对应的ASCII码
				
				mov bx,0b800h
				mov es,bx
				mov BYTE ptr es:[160*12+40*2],ah
				mov BYTE ptr es:[160*12+40*2+2],al
				
				mov ax,4c00h
				int 21h
code ends
end start
				