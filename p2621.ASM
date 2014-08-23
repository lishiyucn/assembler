assume cs:code,ds:data

data segment
		db "Welconme to masm!",0
data ends

code segment

	start: mov dh,10 ;显示在第十行第十列
			 mov dl,10
			 mov cl,2
			 mov ax,data
			 mov ds,ax
			 mov si,0
			 int 7ch
			 
			 mov ax,4c00h
			 int 21h
			 
code ends
end start