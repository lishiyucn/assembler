;安装程序
;/***********汇编语言课程设计二 2014年3月 **************/
;			安装程序
;				||
;			引导程序-------------------写入0道0面1扇区
;				||
;			主任务及子任务-------------------写入2,3,4...... 调用时将此空间内容
;
assume cs:init
init segment
start:
			
			mov ax,zairu
			mov es,ax
			mov bx,0
			
			mov al,1
			mov dl,0
			mov dh,0
			mov ch,0
			mov cl,1
			mov ah,3
			int 13H
			
			
			mov ax,chengxu
			mov es,ax
			mov al,15;扇区数
			mov cl,2
			mov ah,3
			int 13H
			
			mov ax,4c00H
			int 21H
			
init ends

zairu segment
assume cs:zairu

			call ok
			mov ax,2000H
			push ax
			mov ax,0
			push ax
			retf
			
			
	ok:   mov ax,2000H
			mov es,ax
			mov bx,0
			
			mov al,15
			mov dl,0
			mov dh,0
			mov ch,0
			mov cl,2
			mov ah,2
			int 13H
			ret

zairu ends

chengxu segment
assume cs:chengxu			

yindao:  jmp short xuanze
			menutab dw offset restart,offset kaiji,offset time,offset sys_setclock
xuanze:
			call menu
			
			mov ah,0	;系统等待用户输入
			int 16H	
			
			cmp al,49		
			jb xuanze
			cmp al,52		
			ja xuanze
			
			sub al,49		
			mov bl,al
			mov bh,0
			add bx,bx
			call WORD  ptr menutab[bx]  ;选项的跳转
			
			
			jmp short xuanze		
			
	menu:	push ax
			push ds
			push si
			push bx
				
					jmp short menu_ok
				s1 db '1.reset pc',0
				s2 db '2.start system',0
				s3 db '3.clock',0
				s4 db '4.set clock',0
				s  dw s1,s2,s3,s4
		
		
		menu_ok:	mov ax,0b800H
					mov ds,ax
					mov si,160*9+35*2
					
					mov ah,0
		strs:		cmp ah,4
					jnb menu_end
					
					mov bl,ah
					mov bh,0
					add bx,bx
					mov bx,s[bx]
					
					push si
		xian:		
					mov al,cs:[bx]
					cmp al,0
					je huanhang
					mov ds:[si],al
					mov BYTE  ptr ds:[si+1],2
					add si,2
					inc bx
					jmp xian
					
		huanhang:pop si
					add si,160
					inc ah
					jmp short strs
		menu_end:
					pop bx
					pop si
					pop ds
					pop ax
					
					
					ret
				
		qing:		push ax
					push ds
					push si
					push cx
					
					mov ax,0b800H
					mov ds,ax
					mov si,0
					
					mov cx,160*25
					
			qs:	mov BYTE ptr ds:[si],' '
					mov BYTE ptr ds:[si+1],7
					add si,2
					loop qs
					
					pop cx
					pop si
					pop ds
					pop ax
					
					ret
			
restart: mov ax,0ffffh
			push ax
			mov ax,0
			push ax
			retf

			  
	kaiji:call qing
			mov ax,0h
			mov es,ax ;硬盘引导，硬盘的数据读取到0:7c00h处
			mov bx,7c00h
			mov al,1;读取的山区数
			mov ch,0 ;0磁道
			mov cl,1 ;1删去
			mov dl,80h ;代表硬盘的C盘
			mov dh,0;0面
			mov ah,2 
			int 13h
			mov ax,0h
			push ax
			mov ax,7c00h
			push ax
			retf
			 

		time:call qing
				jmp wai
		
		
		
			row:	db 9,8,7,4,2,0
			sg: 	db '/','/',' ',':',':',' '
			color db 02h
	
	wai:	mov si,offset row
			mov bp,offset sg
			mov ax,cs
			mov ds,ax
	
			mov di,160*12+36*2
			mov cx,6
			
	stime:
			push cx
			mov bl,ds:[si]
			mov al,bl
			out 70h,al
			in al,71h
			
			mov ah,al
			mov cl,4
			shr ah,cl
			and al,00001111b
			
			add ah,30h
			add al,30h
			
			mov dx,0b800h
			mov es,dx
			mov bx,0
			mov bl,color[0]
			
			mov BYTE ptr es:[di],ah
			mov BYTE  ptr es:[di+1],bl
			mov BYTE ptr es:[di+2],al
			mov BYTE ptr es:[di+3],bl
			mov dl,ds:[bp]
			mov BYTE ptr es:[di+4],dl
			mov BYTE ptr es:[di+5],bl
			
			add di,6
			inc si
			inc bp
			pop cx
			
			loop stime
			
 			 mov ah,1 ;调用16h中断的1号功能（非阻塞）
			 int 16h
			 cmp al,1bh ;判断是否为ESC
			 je timeover ;若是ESC，回到菜单
			 cmp ah,3bh ;判断是否为F1
			 je changecolor
			 jmp wai
			 
			 ;mov ah,0
			 ;int 16h
			 ;jmp wai
			 
			 
timeover:call qing
			 mov ah,0    ;0号功能清除键盘缓冲区
			 int 16h     
			 jmp  menu
			 
changecolor:inc color
			 mov ah,0   
			 int 16h     
			 jmp wai
			
				
		
		
		
		
				
						   
				;设置时钟
	sys_setclock:
 			 jmp short setclock
			 setclockdata db 'Input your time like "--/--/-- --:--:--"',0
			 
setclock: call qing
			 mov dh,6
			 mov dl,25
			 mov cl,02h
			 mov ax,cs
			 mov ds,ax
			 mov si,offset setclockdata
			 call show
			 call getstr 
			 call settime
			 mov ah,0
			 int 16h
			 call qing
			 jmp  menu
			
			
			;ds:si定位cmos端口位置
			settime:
			 jmp short seting
			 settable db 9,8,7,4,2,0
			seting:
			 mov bx,0
			 mov cx,6
			settimes:
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
			 loop settimes
			 ret
			 
			;子程序：接收字符串
			getstr:
			 			push ax
			getstrs:
						 mov ah,0
						 int 16h
						 cmp al,20h
						 jb nochar
						 mov ah,0
						 call charstack
						 mov ah,2
						 mov dh,8
						 mov dl,25
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
 
 
;子程序：字符串入栈，出栈和显示
;参数：(ah)=功能号，0入栈，1出栈，2显示
;  ds:si指向字符栈空间，对于0号功能，(al)表示入栈字符
;  1号功能，(al)返回的字符，对于2号功能，(dh)(dl)字符串在屏幕显示的行列位置
charstack:nop
			 jmp short charstart
			 table dw charpush,charpop,charshow
			 top  dw 0
			 
charstart:push bx
			 push dx
			 push di
			 push es
			 cmp ah,2
			 ja sret
			 mov bl,ah
			 mov bh,0
			 add bx,bx
			 jmp word ptr table[bx]
			 
charpush: mov bx,top
			 mov [si][bx],al
			 inc top
			 jmp sret
			 
charpop:  cmp top,0
			 je sret
			 dec top
			 mov bx,top
			 mov al,[si][bx]
			 jmp sret
			 
charshow: mov bx,0b800h
			 mov es,bx
			 mov al,160
			 mov ah,0
			 mul dh
			 mov di,ax
			 add dl,dl
			 mov dh,0
			 add di,dx
			 mov bx,0
			 
charshows:cmp bx,top
			 jne noempty
			 mov byte ptr es:[di],' '
			 mov byte ptr es:[di+1],02h
			 jmp sret
			 
			 
noempty:	 mov al,[si][bx]
			 mov es:[di],al
			 mov byte ptr es:[di+2],' '
			 mov byte ptr es:[di+1],02h
			 inc bx
			 add di,2
			 jmp charshows
			 
	sret:	 pop es
			 pop di
			 pop dx
			 pop bx
			 ret
			 
			 
  	show:  push ax
			 push cx
			 push dx
			 push si
			 push bp
			 push es
			 
			 mov ax,0b800h
			 mov es,ax
			 mov al,160
			 mul dh		;行号
			 mov dh,0
			 add dx,dx 
			 add ax,dx
			 mov bp,ax	;指定位置
	shows: mov ch,ds:[si]
			 cmp ch,0		
			 je showoff
			 mov es:[bp],ch
			 mov es:[bp+1],cl
			 add bp,2
			 inc si
			 jmp short shows
	showoff:
			 pop es
			 pop bp
			 pop si
			 pop dx
			 pop cx
			 pop ax
			 ret


chengxu ends
end start
