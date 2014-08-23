assume cs:code

code segment
	row:	db 9,8,7,4,2,0
	sg: 	db '/','/',' ',':',':',' '
	color db 02h
	
	start:nop
	wai:	mov si,offset row
			mov bp,offset sg
			mov ax,cs
			mov ds,ax
	
			mov di,160*12+36*2
			mov cx,6
			
	s:		push cx
			mov bl,ds:[si]
			mov al,bl
			out 70h,al
			in al,71h
			
			mov ah,al
			mov cl,4
			shr ah,cl
			and al,00001111b
			
			add ah,30h
			add al,30h
			
			mov dx,0b800h
			mov es,dx
			mov bx,0
			mov bl,color[0]
			
			mov BYTE ptr es:[di],ah
			mov BYTE  ptr es:[di+1],bl
			mov BYTE ptr es:[di+2],al
			mov BYTE ptr es:[di+3],bl
			mov dl,ds:[bp]
			mov BYTE ptr es:[di+4],dl
			mov BYTE ptr es:[di+5],bl
			
			add di,6
			inc si
			inc bp
			pop cx
			
			loop s
			
			 mov ah,1 ;����16h�жϵ�1�Ź��ܣ���������
			 int 16h
			 cmp al,1bh ;�ж��Ƿ�ΪESC
			 je timeover ;����ESC���ص��˵�
			 cmp ah,3bh ;�ж��Ƿ�ΪF1
			 je changecolor
			 jmp wai
			 
timeover:;call cls
			 mov ah,0    ;16h�жϵ�1�Ź��ܲ���������̻��������´ζ�ȡ�������
			 int 16h     ;����0�Ź������һ��
			 jmp  off
			 
changecolor:inc color
			 mov ah,0    ;16h�жϵ�1�Ź��ܲ���������̻��������´ζ�ȡ�������
			 int 16h     ;����0�Ź������һ��
			 jmp wai
			
			
			jmp wai
			off:nop
			
			mov ax,4c00h
			int 21h
code ends
end start