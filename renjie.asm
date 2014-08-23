assume cs:code

data segment
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
        db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
        db '1993','1994','1995'
        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2579000,3753000,4649000,5937000
        dw 3,7,913,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
        dw 11542,14430,15257,17800
data ends

table segment
        db 21 dup ('year summ ne ?? ')
table ends

code segment
 start: mov ax,data
        mov ds,ax

        mov ax,table
        mov es,ax

        mov bx,0
        mov bp,0
        mov cx,21

     s: mov dx,cx
        mov cx,4

        mov si,0
    s1: mov al,[bx]
        mov es:[bp+si],al
        inc si
        inc bx

        loop s1
        add bp,10h
        mov cx,dx

        loop s

        mov cx,21
        mov bp,0
        
	mov bx,5
    s3: mov dx,cx
        mov si,0
        mov cx,2

    s4: mov ax,[bx]
        mov [5+bp+si],ax
        add bx,2
        add si,2

        loop s4

        add bp,10h
        mov cx,dx
        loop s3
        


        mov ax,4c00h
        int 21h
code ends
end start

