;�����ܣ�������ֻ�ϻ�����
Code Segment
   Assume CS:Code,DS:Code
tiger_freq   dw 262,262,294,330,262,262,294,330,262
             dw 330,349,392,330,349,392,392,440
             dw 392,349,330,262,392,440,392,349
             dw 330,262,294,196,262,294,196,262,0
             
tiger_time   dw 250*8,250*8,250*8,250*8,250*8,250*8,250*8,250*8,250*8,250*8,250*8
             dw 500*8,250*8,250*8,500*8,120*8,120*8,120*8,120*8,250*8,250*8
             dw 120*8,120*8,120*8,120*8,250*8,250*8,250*8,250*8,500*8,250*8,250*8,500*8
   
Start:   push cs
         pop ds
         push cs
         pop es ;ʹ���ݶΡ����Ӷ�������ͬ��

         lea si,tiger_freq ;��Ӧ��Ƶ��ֵ��ַ
         lea bx,tiger_time ;��Ӧ�Ľ���ֵ��ַ
;������������ʹ֮����ָ��Ƶ�ʡ�ָ��ʱ��������������
Sound: 
   mov al,0b6h ;�������д������
   out 43h,al ;��ʽ3��˫�ֽ�д�Ͷ����Ƽ�����ʽд�����ƿ�
   mov dx,12h ;���ñ�����
   mov ax,word ptr [si]
   test ax,0ffffh
   jz   over
   mov ax,34cdh
   
   div word ptr [si] ;����axΪԤ��ֵ
   out 42h,al ;����LSB
   mov al,ah
   out 42h,al ;����MSB
   in al,61h ;���˿�ԭֵ
   mov ah,al
   or al,3
   out 61h,al ;��ͨ������
   mov cx,[bx]
   
Waitf1: push cx
   mov cx,9ff0h ;�赥��ѭ������
delay1: loop delay1
   pop cx ;ѭ������cx�Σ����������Ľ���ʱ��   
   loop Waitf1 
   
   inc si
   inc si ;��һ��Ƶ��ֵ
   inc bx
   inc bx ;��һ������ֵ
   mov al,ah ;д��61h�˿�ֵ���ر�������
   out 61h,al ;�ر�������
   jmp Sound

over:   mov ah,4ch ;��������
   int 21h
Code ENDS
   END   Start ;���뵽�˽��� ; ������ͨ�����룬������ȷ