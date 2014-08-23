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
	    

	      ;mov al,0a0h  
	      ;mov ds:[32],al
	      ;mov al,2
	      ;mov ds:[33],al

	     ; mov di,0
	      ;mov dh,8 ;从第八行开始
	      ;mov dl,3 ;提供显示列数
	      ;mov cl,2 ;显示的颜色属性
	     ; mov si,0 ;ds:si指向字符串首地址
	      ;mov bx,0
	      ;call show_str ;调用要显示字符串的子程序

	      mov ax,4c00h
	      int 21h

	
	 dtoc:	   mov ax,12666
		s: mov bl,10
		   div  bl
		   add ah,30h
		   mov ds:[si],ah
		   
		   mov ah,0;ah中方的是余数，把余数放到内存中后，赋值为0，这样每次循环下一次的被除数就是上一次的商

		   mov cl,al ;如果商为0时，就不再循环
		   mov ch,0
		   jcxz kk
		   inc si
		   
		   jmp s


		  kk:ret

	show_str:push cx

		 mov cl,ds:[si]
		 mov ch,0
		 jcxz ok

		 
		 mov al,dh
		 mul byte ptr ds:[32]
		 mov bx,ax

		 mov al,dl
		 mul byte ptr ds:[33]
		 add bx,ax

		 mov al,ds:[si]
		 pop cx
		 mov ah,cl
		 mov es:[bx+di],ax
		 inc si
		 add di,2

		 jmp show_str

		 ok:  ret

		 


	  

code ends
end start