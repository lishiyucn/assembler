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
			rep movsb  ;�����ǰ��ն˳�����뵽�ڴ��е� 0:200��
			
			mov ax,0
			mov es,ax
			mov WORD ptr es:[7ch*4],200h
			mov WORD ptr es:[7ch*4+2],0
			mov ax,4c00h
			int 21h
			
	lp:   push bp
		   mov bp,sp
			dec cx
			jcxz lpret ;���cxֵΪ0��ѭ������ֱ������
			add ss:[bp+2],bx ;���� sp=bp  spΪջ����ַ  bp+2�õ�se ��ƫ�Ƶ�ַ se��s ��ת��λ�Ʒ��� bx�У��ټ��� bxֵ��������ѭ���������ִ��
			
	lpret:pop bp
			iret
	lpend:nop
	
code ends
end start