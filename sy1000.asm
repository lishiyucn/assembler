assume cs:code 
data segment 
db '1975','1976','1977','1978','1979','1980','1981','1982','1983' 
db '1984','1985','1986','1987','1988','1989','1990','1991','1992' 
db '1993','1994','1995' 
dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514 
dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000 
dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226 
dw 11542,11430,15257,17800 
data ends 
stack segment 
dw 16 dup (0) 
stack ends 
code segment 
              start:mov ax,data 
                  mov ds,ax 
                   mov ax,stack 
                   mov ss,ax 
                   mov sp,32 
                   mov ax,0b800h 
                   mov es,ax 
                   mov bx,0 
                   mov bp,0 
                   mov di,0 
                   mov cx,21 
                s: mov si,10      ;21��loop    ע��SI��ֵΪ����һ��Ҫ��10����bpΪ����ÿ�μ�160 
                push cx     ;�������CXֵ 
                   mov cx,4       ;�ڲ����4�� 
                   push bx    ;��Ϊloop��bx��䣬���������ȱ��� 
                n1:push ds:[bx]        ;���  �ӵ�10�п�ʼ��ʾ     
                   pop es:[bp+si]
		   mov ax,2
                   mov es:[bp+si],ax ;��ɫ 
                   inc bx 
                   add si,2 
                   loop n1 
                   pop bx 
                   mov si,40     ;�����40�п�ʼ 
                   mov ax,84[bx] 
                   mov dx,86[bx] 
                   call dtoc 
                   mov si,80    ;������80�п�ʼ 
                   mov ax,168[di] 
                   mov dx,0 
                   call dtoc 
                   mov si,120   ;�˾������120�п�ʼ 
                   mov ax,84[bx] 
                   mov dx,86[bx] 
                   mov cx,168[di] 
                   call divdw 
                   call dtoc 
                   add bx,4     ;��ݺ�����Ϊ4�ֽڣ�ÿ�μ�4 
                   add di,2     ;����Ϊ2�ֽ�ÿ�μ�2 
                   add bp,160   ;bpÿ�μ�160�������� 
                   pop cx 
                   loop s 
                   mov ax,4c00h 
                   int 21h 
                
          divdw: push bx            ;���Ǵ�����ӳ���dx+ax����cx���̸�ΪDX��λΪAX����ΪCX 
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
          dtoc:push bx     ;���ǰѸ�16λ=dx��16λ=ax����ת��Ϊascll����ʾ����Ļ�ϵ��ӳ��� 
                push cx 
                  mov bx,0   ;һ��Ҫ����Ϊ0 
            b1:  mov cx,10      ;ע���������ж�һ��Ҫ�ȴ����������ж� 
               call divdw 
                 mov ch,02h ;������ʾ����ɫ 
                 add cl,30h ;����30h��ASCLL����ʾ 
                 push cx   ;�����ɫ����������� 
                 inc bx  ;������¼push�˼��� 
                  mov cx,ax;�������ж����Ƿ�Ϊ0 
                  jcxz jdx 
                jmp b1 
          jdx:   mov cx,dx 
               jcxz ok  
                 jmp b1 
        ok:     mov cx,bx ;push����ֱ��pop ���� 
           a1: pop es:[bp+si]   ;�����bp��siֱ������������ 
                add si,2 
                 loop a1 
                 pop cx 
                 pop bx 
                 ret  
code ends 
end start