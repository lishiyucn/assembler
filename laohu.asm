;程序功能：播放两只老虎乐曲
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
         pop es ;使数据段、附加段与代码段同段

         lea si,tiger_freq ;对应的频率值地址
         lea bx,tiger_time ;对应的节拍值地址
;激活扬声器，使之发出指定频率、指定时长的声音，奏乐
Sound: 
   mov al,0b6h ;向计数器写控制字
   out 43h,al ;方式3、双字节写和二进制计数方式写到控制口
   mov dx,12h ;设置被除数
   mov ax,word ptr [si]
   test ax,0ffffh
   jz   over
   mov ax,34cdh
   
   div word ptr [si] ;其商ax为预置值
   out 42h,al ;先送LSB
   mov al,ah
   out 42h,al ;后送MSB
   in al,61h ;读端口原值
   mov ah,al
   or al,3
   out 61h,al ;接通扬声器
   mov cx,[bx]
   
Waitf1: push cx
   mov cx,9ff0h ;设单次循环次数
delay1: loop delay1
   pop cx ;循环持续cx次，即传进来的节拍时间   
   loop Waitf1 
   
   inc si
   inc si ;下一个频率值
   inc bx
   inc bx ;下一个节拍值
   mov al,ah ;写回61h端口值，关闭扬声器
   out 61h,al ;关闭扬声器
   jmp Sound

over:   mov ah,4ch ;结束程序
   int 21h
Code ENDS
   END   Start ;编译到此结束 ; 本程序通过编译，运行正确