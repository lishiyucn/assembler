assume cs:code,ds:data

data segment

	db 10 dup (0)

data ends


stack segment

	db 16 dup (0)

stack ends

code segment

	start:mov ax,12666
	      mov bx,data
	      mov ds,bx
	      mov si,0

	      call dtoc
	      
	      mov bx,0b800h
	      mov es,bx
	    

	       mov si,0 ;ds:si指向字符串首地址
	       mov di,0
	       mov dh,8 ;从第八行开始
	       mov dl,3 ;提供显示列数
	       mov cl,2 ;显示的颜色属性
	       call show_str ;调用要显示字符串的子程序

	      mov ax,4c00h
	      int 21h

	
	dtoc: 
        push ax ;子程序调用的寄存器入栈 
        push bx 
        push cx
        push dx
        push ds
         
        mov dx,0 
        mov bx,0ah 
        div bx   ;用dxax/bx 16位除法,dx放余数,ax放商,ax是提供的入口参数 
        add dx,30h ;把数据码转变为ASCII码 
        push dx ;入栈 
	mov dx,0
	mov cx,ax 
       
        jcxz savedata 
        call dtoc   ;通过递归就不用考虑出栈的数量.
	savedata: 
		;第一次:31 00 
		;第二次:31 32 00 
		;第三次:31 32 36 00 
		;...... 
		pop dx         
		mov ds:[si],dx 
		inc si 
		mov byte ptr ds:[si],0 
		 
		pop ds       
		pop dx        
		pop cx       
		pop bx       
		pop ax       
        ret  ;递归后,ret返回到了savedata标号处，最后一层ret才返回到mov dh,8处. 
	show_str: 
	;push指令保护子程序用到的寄存器 
		push bx 
		push cx 
		push dx 
		push si 
		push di 
	;指定显存区域 
		mov ax,0b800h 
		mov es,ax 
	;初始化行 
		mov ax,0a0h
		sub dh,1
		mul dh 
		mov bx,ax 
	;初始化列 
		mov ax,2 
		mul dl 
		mov di,ax 
	;将字符属性存入AH中 
		mov ah,cl 
	 
	;开始逐字符显示 
	      s:mov cl,ds:[si]
		mov ch,0
		jcxz ok

		mov al,ds:[si]       ;源地址DS:SI指向数据段字符 
		mov es:[bx+di],ax ;目标地址ES:[BX+DI]，AH=属性，AL=字符 
		inc si           ;指向数据段下一个字符 
		add di,2         ;指向下一列 
		jmp s            ;如果CX≠0，继续循环

	ok: 
	;恢复保护的寄存器 
		pop di 
		pop si 
		pop dx 
		pop cx 
		pop bx 
	;返回调用 
        ret 

		 


	  

code ends
end start