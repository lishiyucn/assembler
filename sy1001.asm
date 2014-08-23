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