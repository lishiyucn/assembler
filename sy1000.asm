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
                s: mov si,10      ;21次loop    注意SI的值为列数一定要清10后以bp为变量每次加160 
                push cx     ;保存外层CX值 
                   mov cx,4       ;内层年份4次 
                   push bx    ;因为loop后bx会变，所以这里先保存 
                n1:push ds:[bx]        ;年份  从第10列开始显示     
                   pop es:[bp+si]
		   mov ax,2
                   mov es:[bp+si],ax ;加色 
                   inc bx 
                   add si,2 
                   loop n1 
                   pop bx 
                   mov si,40     ;收入从40列开始 
                   mov ax,84[bx] 
                   mov dx,86[bx] 
                   call dtoc 
                   mov si,80    ;人数从80列开始 
                   mov ax,168[di] 
                   mov dx,0 
                   call dtoc 
                   mov si,120   ;人均收入从120列开始 
                   mov ax,84[bx] 
                   mov dx,86[bx] 
                   mov cx,168[di] 
                   call divdw 
                   call dtoc 
                   add bx,4     ;年份和收入为4字节，每次加4 
                   add di,2     ;人数为2字节每次加2 
                   add bp,160   ;bp每次加160用来换行 
                   pop cx 
                   loop s 
                   mov ax,4c00h 
                   int 21h 
                
          divdw: push bx            ;这是大除法子程序dx+ax除以cx后商高为DX低位为AX余数为CX 
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
          dtoc:push bx     ;这是把高16位=dx低16位=ax的数转化为ascll码显示在屏幕上的子程序 
                push cx 
                  mov bx,0   ;一定要重置为0 
            b1:  mov cx,10      ;注意用商来判断一定要先存余数后再判断 
               call divdw 
                 mov ch,02h ;加上显示的颜色 
                 add cl,30h ;加上30h用ASCLL码显示 
                 push cx   ;保存加色后的余数到载 
                 inc bx  ;用来记录push了几次 
                  mov cx,ax;下面是判断商是否为0 
                  jcxz jdx 
                jmp b1 
          jdx:   mov cx,dx 
               jcxz ok  
                 jmp b1 
        ok:     mov cx,bx ;push几次直接pop 几次 
           a1: pop es:[bp+si]   ;这里的bp和si直接来至主程序 
                add si,2 
                 loop a1 
                 pop cx 
                 pop bx 
                 ret  
code ends 
end start