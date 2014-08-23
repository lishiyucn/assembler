assume cs:code,ds:data,es:table,ss:stack

data segment

	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'

	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'

	db '1993','1994','1995'
	;以上是21年的 21个 字符串

	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514

	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
	;以上是21年公司总收入的21个dword型数据


	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226

	dw 11542,14430,15257,17800
data ends

table segment

	db 21 dup ('year summ ne ?? ')

table ends

stack segment
	dw 8 dup (0)
stack ends

code segment

start:	mov ax,data
	mov ds,ax

	mov ax,table
	mov es,ax

	mov ax,stack
	mov ss,ax
	mov sp,10h
	

	mov cx,21
	mov di,168
	mov si,0
	mov bx,0
	mov dx,0
   s3:  mov ax,ds:[si]	;放入年份
	mov es:[bx+0],ax
	mov ax,ds:[si+2]
	mov es:[bx+2],ax

   
	mov ax,ds:[di];放入雇员数
	mov es:[bx+10],ax


	mov ax,ds:[si+84];放入收入
	mov dx,ds:[si+86]
	mov es:[bx+5],ax
	mov es:[bx+7],dx
	div word ptr ds:[di]

	mov es:[bx+13],ax


	add di,2
	add si,4
	add bx,10h
 
	loop s3




	mov ax,4c00h
	int 21h

code ends
end start