assume cs:code

code segment
		start:mov al,8		;�˿ڴ�ֵ���뾭��al����8���͸�al
				out 70h,al	;��70h��ַ�˿�д��Ҫ���ʵĵ�ַ��Ԫ
				in al,71h	;��71h�˿ڶ�������Ҫ���ʵĶ˿ڵ�Ԫ��ַ������
				
				mov ah,al
				mov cl,4
				shr ah,cl	;�ѵ���λ�������Ƴ���ʣ�¸���λ����Ϊʮλ����ֵ
				add al,00001111b  ;and�����㣬 0--0 1����  or����1  1--1 0����
				
				add ah,30h
				add al,30h	;BCD��ֵ + 30h =ʮ��������Ӧ��ASCII��
				
				mov bx,0b800h
				mov es,bx
				mov BYTE ptr es:[160*12+40*2],ah
				mov BYTE ptr es:[160*12+40*2+2],al
				
				mov ax,4c00h
				int 21h
code ends
end start
				