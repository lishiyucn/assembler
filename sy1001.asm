assume cs:code,ds:data,ss:stack

data segment

	db 'Welcome to masm!',0

data ends

stack segment

	db 16 dup (0)

stack ends

code segment

start:  mov dh,8
	mov dl,3
	mov cl,2
	mov ax,0b800h
	mov es,ax
	mov ax,data
	mov ds,ax
	mov si,0
	mov di,0
	
	call show_str

	mov ax,4c00h
	int 21h

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

        mov ax,2 
        mul dl 
        mov di,ax  
        mov ah,cl 

      s:mov cl,ds:[si]
	mov ch,0
	jcxz ok

        mov al,ds:[si]       
        mov es:[bx+di],ax
        inc si           
        add di,2        
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