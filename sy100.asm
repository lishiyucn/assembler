assume cs:code,ds:data,ss:stack
data segment

	dw 16 dup(0) 
	dw 1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995;����׵�ַΪDS:20H

	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514,345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000	;�������׵�ַΪDS:4AH

	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226,11542,14430,15257,17800;�������׵�ַΪDS:9EH

	dd 21 dup(0) ;�˾������׵�ַΪDS:C8H

data ends


stack segment
	dw 48 dup(0)
stack ends


code segment

main:   mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,60h
	mov cx,21

	mov bx,0
	mov bp,0
	mov si,0

	mov dh,0
print_table:push cx
	mov cl,02h
	mov ax,ds:20h.[bp]
	call wtoc
	mov dl,2
	call show_str ;��ʾ���




	push dx
	mov ax,4ah.[bx]
	mov dx,4ah.[bx+2]

	call dwtoc
	pop dx
	mov dl,0ch
	call show_str

	mov ax,ds:9eh.[bp]
	call wtoc
	mov dl,16h
	call show_str ;��ʾ������

	push dx
	mov ax,4ah.[bx]
	mov dx,4ah.[bx+2]
	mov cx,ds:9eh.[bp]
	call divdw
	mov 0c8h.[bx],ax
	mov 0c8h.[bx+2],dx


	call dwtoc
	pop dx
	mov dl,20h
	mov cl,02h
	call show_str

	add bp,2
	add bx,4 
	inc dh
	pop cx
	loop print_table

	mains: mov ax,0 
	jmp mains 

	mov ax,4c00h
	int 21h 

	
	;�����������ĳ�����������dword�ͣ�����word�ͣ�
	; ���Ϊdword�� 
	;����(in):(AX)=dword�����ݵ�16λ��(DX)=dword�����ݸ�16λ��
	; (CX)=���� 
	;����(out): (DX)=����ĸ�16λ��(AX)=����ĵ�16λ��
	; (CX)=����

 divdw: push bx
	push ax
	mov ax,dx
	mov dx,0
	div cx
	mov bx,ax
	pop ax
	div cx
	mov cx,dx
	mov dx,bx
	pop bx
	ret 


	;���ƣ�dwtoc 
	;���ܣ���32λ����תΪ�ַ���ʽ����0��β���׵�ַλsi 
	;����(in):(AX)=dword�����ݵ�16λ��(DX)=dword�����ݸ�16λ,
	; DS��SIΪʮ�����ַ����׵�ַ
	;����(out):SI,ʮ�����ַ����׵�ַ 
 dwtoc: push si ;�����ַ����׵�ַ
	push cx
	push bx
	push dx
	push ax
	mov bx,si
	mov ch,0 ;������ʮ�����ַ������ڴ�ռ���0
	dwclr_si: mov cl,[si]
	jcxz dclrsi_fnsh
	mov byte ptr [si],0
	inc si
	jmp dwclr_si
	dclrsi_fnsh: mov si,bx
	mov bx,0
	div_ten: mov cx,10
	call divdw
	push cx
	inc bx   ;ʮ������ʽ���ݵ�λ����1
	mov cx,dx
	jcxz dxIsZero
	jmp div_ten
	dxIsZero: mov cx,ax
	jcxz axIsZero
	jmp div_ten
	axIsZero: mov cx,bx
	out_rem: pop bx
	add bl,30h
	mov [si],bl
	inc si
	loop out_rem 
	pop ax
	pop dx
	pop bx
	pop cx
	pop si
	ret 

	;���ƣ�wtoc 
	;���ܣ���16λ����תΪ�ַ���ʽ����0��β���׵�ַλsi 
	;����(in):(AX)=word�����ݣ�DS��SIΪʮ�����ַ����׵�ַ 
	;����(out):SI,ʮ�����ַ����׵�ַ 
  wtoc: push si
	push dx
	push cx
	push bx
	push ax
	mov bx,si
	mov dx,0  ;��������16λ��0
	mov ch,0
	clr_si: mov cl,[si]
	jcxz clrSI_finish
	mov byte ptr [si],0
	inc si
	jmp clr_si 
	clrSI_finish: mov si,bx
	mov bx,0
	divid_ten: mov cx,10 
	call divdw
	push cx
	inc bx
	mov cx,ax
	jcxz div_finish
	jmp divid_ten 
	div_finish: mov cx,bx
	rem_out_stck: pop bx
	add bl,30h
	mov [si],bl
	inc si
	loop rem_out_stck
	pop ax
	pop bx
	pop cx
	pop dx
	pop si
	ret 


	;show_str
	;(in):(DH)=�к�(0~24),(DL)=�к�(0~79)
	; (CL)=��ɫ������,DS:SIָ���ַ����׵�ַ
show_str: push dx
	push cx
	push bx
	push si
	push di
	push ax
	push es
	mov ax,0b800h ;��ʾ�������ε�ַ
	mov es,ax

	mov al,0a0h
	mul dh
	mov di,ax
	mov al,2h
	mul dl
	add di,ax
	mov bl,cl
  show: mov cl,[si]
	mov ch,0
	jcxz finish_show

	mov ch,bl
	mov es:[di],cx
	add di,2
	inc si
	jmp short show

	finish_show: pop es
	pop ax
	pop di
	pop si
	pop bx
	pop cx
	pop dx
	ret
	code ends
	end main