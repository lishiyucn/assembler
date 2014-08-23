assume cs:code 
code segment

	start:mov bx,offset begin
			mov ax,cs
			mov es,ax
			
			
			mov al,1
			mov ch,0
			mov cl,1
			mov dl,0
			mov dh,0
			
			mov ah,3
			int 13h
			
			mov ax,4c00h
			int 21h
			
			
			
	begin:jmp menu
		s1: db '1) reset pc'
		s2: db '2) start system'
		s3: db '3) clock'
		s4: db '4) set clock'
		s5: db 'please input your choose my deer friends:'
		s : dw offset s1,offset s2,offset s3, offset s4, offset s5
		row: db 4,6,8,10,11
		
	menu: mov ax,cs		;这里是显示菜单部分----一直到loop ok
		 mov ds,ax
		 mov bx,offset s
		 mov si,offset row
		 mov cx,4
		 
	ok: mov bh,0
		 mov dh,ds:[si]
		 mov dl,0
		 mov ah,2
		 int 10h
		 
		 mov dx,ds:[bx]
		 mov ah,9
		 int 21h
		 inc si
		 add bx,2
		 loop ok
code ends
end start