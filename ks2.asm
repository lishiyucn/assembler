assume cs:code
code segment
start:  jmp short mune
        a: db '1) reset pc     ',0
        b: db '2) start system ',0
        c: db '3) clock        ',0
        d: db '4) set clock    ',0
        ;e: db 'please chose :  ',0
        f dw offset a,offset b,offset c,offset d
    
   mune:call cls
	mov dh,6	
	mov ax,cs
	mov ds,ax
	mov di,0
	mov cx,4
mune2:	push cx
	mov dl,30
	mov cl,07h
	mov si,f[di]
	call sys_showstr 
	add di,2
	add dh,2
	pop cx
	loop mune2       
          
        call getchar
	jmp mune
        mov ax,4c00h
        int 21h


getchar:
	mov  ah,0
        int 16h
             
        cmp al,31h
        je reset
        cmp al,32h
        je system
        cmp al,33h
        jne set4
	call clock	
	ret
     set4:cmp al,34h
       je setclock1
	jmp mune

reset: mov ax,0ffffh
	push ax
	mov ax,0
	push ax
	retf

system:call cls
	mov ax,0h
        mov es,ax
	mov bx,7c00h

	mov al,1
	mov ch,0
	mov cl,1
	mov dl,80h
	mov dh,0

	mov ah,2
	int 13h

	mov ax,0h
	push ax
	mov ax,7c00h
	push ax
	retf 

setclock1:call setclock2
       jmp mune

    cls:mov ax,0b800h
        mov es,ax
        mov bx,0
        mov cx,2000
   cls1:mov byte ptr es:[bx],0
        add bx,2
        loop cls1
        ret

setclock2:
        jmp short setclock
	sc1 db 'The current time is:',0
	sc2 db 'Enter the new time :',0
setclock:push ax
	push bx
	push cx
	push dx
	push si
	push di
	call cls
	mov dh,6
	mov dl,0
	mov cl,07h
	mov ax,cs
	mov ds,ax
	mov si,offset sc1
	call sys_showstr

	mov dh,6
	mov dl,20
	call clock1

        mov dh,9
	mov dl,0
        mov cl,07h
	mov ax,cs
	mov ds,ax
	mov si,offset sc2
	call sys_showstr

	mov dh,9
    fu3:mov dl,20
        call getstr
	call settime
        pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret	

settime:
	jmp short time1
	settable db 9,8,7,4,2,0
time1:
	mov bx,0
	mov si,12*160
	mov cx,6
time2:	
	mov dh,ds:[si]
	inc si
	mov dl,ds:[si]
	add si,2
	mov al,30h
	sub dl,al
	sub dh,al
	shl dh,1
	shl dh,1
	shl dh,1
	shl dh,1
	or dl,dh
	mov al,settable[bx]
	out 70h,al
	mov al,dl
	out 71h,al
	inc bx
	loop time2
	ret

getstr:
	push ax
	push bx
	mov bx,offset top
	mov word ptr cs:[bx],0
	pop bx
getstrs:
	mov ah,0
	int 16h

	cmp al,20h
	jb nochar
	mov ah,0
	call charstack
	mov ah,2
	call charstack
	jmp getstrs
nochar:
	cmp ah,0eh
	je backspace
	cmp ah,1ch
	je enter
	jmp getstrs
backspace:
	mov ah,1
	call charstack
	mov ah,2
	call charstack
	jmp getstrs
enter:
	mov al,0
	mov ah,0
	call charstack
	mov ah,2
	call charstack
	pop ax
	ret



charstack:
	jmp short charstart
	table dw charpush,charpop,charshow
	top  dw 0
	sc3 db 'the system cannot accept the time entered',0
charstart:
	push bx
	push dx
	push di
        push es

      
        mov si,12*160
	cmp ah,2
	ja sret
	mov bl,ah
	mov bh,0
	add bx,bx
	jmp word ptr table[bx]
charpush:
	mov bx,top
	cmp bx,2
	je  fu
	cmp bx,5
	je  fu
	cmp bx,8
	je  fa
	cmp bx,11
	je  fb
	cmp bx,14
	je  fb
fu1:   mov [si][bx],al
	inc top
	jmp sret

fu:	cmp al,'/'
	je fu1
	jmp f3
fa:	cmp al,' '
	je fu1
	jmp f3
fb:	cmp al,':'
	je fu1
	jmp f3

f3:	call wrong	
	add dh,2
	mov dl,0
	jmp fu2	
	;jmp sret
	
fu2:    mov cl,07h
	mov ax,cs
	mov ds,ax
	mov si,offset sc2
	call sys_showstr

;       mov dl,20
	jmp fu3
 ;   	call getstr
;	call settime
;	ret
wrong: 
	add dh,2
	mov dl,0
	mov cl,07h
	mov ax,cs
	mov ds,ax
	mov si,offset sc3
	call sys_showstr
	ret

sret:
	pop es
	pop di
	pop dx
	pop bx
	ret

charpop:
	cmp top,0
	je sret
	dec top
	mov bx,top
	mov al,[si][bx]
	jmp sret
charshow:
	mov bx,0b800h
	mov es,bx
	mov al,160
	mov ah,0
	mul dh
	mov di,ax
	add dl,dl
	mov dh,0
	add di,dx
	mov bx,0
charshows:
	cmp bx,top
	jne noempty
	mov byte ptr es:[di],' '
	;mov byte ptr es:[di+1],07h
	jmp sret
noempty:
	mov al,[si][bx]
	mov es:[di],al
	mov byte ptr es:[di+2],' '
	;mov byte ptr es:[di+1],07h
	inc bx
	add di,2
	jmp charshows



sys_showstr:
	push ax
	push cx
	push dx
	push si
	push bp
	push es
	call dingwei
showstr_s:
	mov ch,ds:[si]
	cmp ch,0
	je showstr_return
	mov es:[bp],ch
	inc bp
	mov es:[bp],cl
	inc bp
	inc si
	jmp short showstr_s
showstr_return:
	pop es
	pop bp
	pop si
	pop dx
	pop cx
	pop ax
	ret

dingwei:push ax
	push cx
	push dx
	push si
	push es
	mov ax,0b800h
	mov es,ax
	mov al,160
	mul dh
	mov dh,0
	add dx,dx
	add ax,dx
	mov bp,ax
	pop es
	pop si
	pop dx
	pop cx
	pop ax
	ret


 	
clock: call cls
clock3:	mov dh,5
	mov dl,30
	call clock1
        mov ah,1
        int 16h
        cmp al,1bh
        je mune1
        cmp ah,3bh
        je f1
        jmp short clock3

clock1:
        jmp short clock_set
  	r1:  db 9,8,7,4,2,0
  	r2:   db '// :: '
clock_set:
        mov bx,cs
        mov ds,bx
        mov si,offset r1       
        mov di,offset r2 
     
        call dingwei
                            
        mov cx,6
 clock2: push cx
        mov al,ds:[si]                
        out 70h,al
        in al,71h

        mov ah,al
        mov  cl,4
        shr ah,cl
        and al,00001111b
           
        add ah,30h
        add al,30h

        mov byte ptr es:[bp],ah
        mov byte ptr es:[bp+2],al
        
        add bp,4
        mov al,ds:[di]        
       
        mov es:[bp],al
        add bp,2
        add di,1
        add si,1
        pop cx
        loop clock2
        ret
  mune1:mov ah,0
        int 16h
        jmp mune
	
	
     f1:mov ah,0
        int 16h
        mov ax,0b800h
        mov es,ax
        mov bx,5*160+29
        mov cx,40
   f1_1:inc byte ptr es:[bx]
	and byte ptr es:[bx],00000111b
        add bx,2
	cmp bx,5*160+65
	je f1_1	
	loop f1_1
        jmp  clock3
    

 

code ends
end start
