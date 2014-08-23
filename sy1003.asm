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
	    

	       mov si,0 ;ds:siָ���ַ����׵�ַ
	       mov di,0
	       mov dh,8 ;�ӵڰ��п�ʼ
	       mov dl,3 ;�ṩ��ʾ����
	       mov cl,2 ;��ʾ����ɫ����
	       call show_str ;����Ҫ��ʾ�ַ������ӳ���

	      mov ax,4c00h
	      int 21h

	
	dtoc: 
        push ax ;�ӳ�����õļĴ�����ջ 
        push bx 
        push cx
        push dx
        push ds
         
        mov dx,0 
        mov bx,0ah 
        div bx   ;��dxax/bx 16λ����,dx������,ax����,ax���ṩ����ڲ��� 
        add dx,30h ;��������ת��ΪASCII�� 
        push dx ;��ջ 
	mov dx,0
	mov cx,ax 
       
        jcxz savedata 
        call dtoc   ;ͨ���ݹ�Ͳ��ÿ��ǳ�ջ������.
	savedata: 
		;��һ��:31 00 
		;�ڶ���:31 32 00 
		;������:31 32 36 00 
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
        ret  ;�ݹ��,ret���ص���savedata��Ŵ������һ��ret�ŷ��ص�mov dh,8��. 
	show_str: 
	;pushָ����ӳ����õ��ļĴ��� 
		push bx 
		push cx 
		push dx 
		push si 
		push di 
	;ָ���Դ����� 
		mov ax,0b800h 
		mov es,ax 
	;��ʼ���� 
		mov ax,0a0h
		sub dh,1
		mul dh 
		mov bx,ax 
	;��ʼ���� 
		mov ax,2 
		mul dl 
		mov di,ax 
	;���ַ����Դ���AH�� 
		mov ah,cl 
	 
	;��ʼ���ַ���ʾ 
	      s:mov cl,ds:[si]
		mov ch,0
		jcxz ok

		mov al,ds:[si]       ;Դ��ַDS:SIָ�����ݶ��ַ� 
		mov es:[bx+di],ax ;Ŀ���ַES:[BX+DI]��AH=���ԣ�AL=�ַ� 
		inc si           ;ָ�����ݶ���һ���ַ� 
		add di,2         ;ָ����һ�� 
		jmp s            ;���CX��0������ѭ��

	ok: 
	;�ָ������ļĴ��� 
		pop di 
		pop si 
		pop dx 
		pop cx 
		pop bx 
	;���ص��� 
        ret 

		 


	  

code ends
end start