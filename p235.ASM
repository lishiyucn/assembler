assume cs:code

data segment
		db "Beginner's All-purpose Sysbolic Instruction Code.",0
data ends

code segment

		start: mov ax,data
				 mov ds,ax
				 mov si,0
				 call letterc
				 
				 mov ax,4c00h
				 int 21h
				 
			letterc:push si
					  push ax
					  
				  k1:mov ax,ds:[si]
				  	  cmp al,0
				  	  je k2
				  	  inc si
				  	  cmp al,'a'
				  	  jb k1
				  	  cmp al,'z'
				  	  ja k1
				  	  add al,'A'-'a'
				  	  mov ds:[si-1],al
				  	  jmp k1
				
				  	  
				 k2:pop ax
				    pop si
				    ret
				    
				    
code ends
end start