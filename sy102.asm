assume cs:code 

stack segment 
        dw 8 dup(0) 
stack ends 

code segment 
start:  mov ax,stack 
        mov ss,ax 
        mov sp,16 
        mov ax,4240h ;被除数为000f4240H 
        mov dx,0fh  
        mov cx,0ah ;除数为0aH   
        call divdw ;int(H/N) 
         
        mov ax,4c00h 
        int 21h 
         
divdw:  push ax 
        mov ax,dx ;因为此时要做的是16位的除法，所以要设置AX,DX。根据公式这里做的是被除数的高位除以除数，被除数的高位为0FH，放到在16位除法中就应该是dx=0000h,ax=000fh 

        mov dx,0 
        div cx 
         
        mov bx,ax ;16位除法完后商会保存在ax中，我们先把高位除以除数的商保存在bx中 
        pop ax ;把被除数的低位从栈中取出 
        div cx ;[rem(H/N)*65536+L]/N，65536是10进制数，转换为16进制也就是10000. 
               ;这里很多人要问，我们并没有用高位的余数*10000H+低位，而是直接用低位当被除数直接开始除法了！类似与L/N了，我想说你错了！
	       ;因为在高位的除法中它的余数直接保留在DX中，而在低位除法中，DX正是这次除法的高位！ 
               ;也就是说，rem(H/N)*10000H这一步我们已经做了，这段公式不就说让我们把高位的余数放到高位吗?
	       ;然后再加上低位组成一个新的被除数再除以除数[rem(H/N)*65536+L]这段公式的目的并不是要我们把数值相加，
	       ;而是让我们完成一个32位的被除数，也就是用原始被除数的余数与原始被除数低位凑成一个完整的数如：设rem(H/N)值为0006H,L=4240H，这个数应该是00064240H 

        mov cx,dx 
        mov dx,bx 
        ret 
code ends 
end start 