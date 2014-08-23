DATA SEGMENT   
      
INFO1 DB 0DH,0AH,'----------------------------------'       
INFO2 DB 0DH,0AH,'    Welcome To Music World  
   
INFO3 DB 0DH,0AH,'Input error!  
   
INFO4 DB 0DH,0AH,'Please input again!  
  
INFO5 DB 0Dh,0AH,'  
  
INFO6 DB 0Dh,0Ah,'^.^  
  
INFO7 DB 0DH,0AH,'       Welcome To Music World              $ '  
  
MUSLIST DB 0DH,0AH,' '  
         DB 0DH,0AH,'          The  Menu   '  
         DB 0DH,0AH,'-----------------------------  '  
         DB 0DH,0AH,' '  
         DB 0DH,0AH,'     1.<<Two Tigers>>  '   
         DB 0DH,0AH,'         Please input:1'  
         DB 0DH,0AH,' '  
         DB 0DH,0AH,'     2.<<Two Tigers(quick version)>>'  
         DB 0DH,0AH,'         Please input:2'  
         DB 0DH,0AH,' '  
         DB 0Dh,0AH,'     3.<<Two Tigers(time)>>'  
         DB 0DH,0AH,'         Please input:3'  
         DB 0DH,0AH,' '  
         DB 0DH,0AH,'     4.<<Two Tigers(Media Player)>>'  
         DB 0DH,0AH,'         Please input:4'  
         DB 0DH,0AH,' '  
         DB 0DH,0AH,'     5.<<Mary Had a little Lamb>>'  
         DB 0DH,0AH,'         Please input:5'  
         DB 0DH,0AH,' '  
         DB 0DH,0AH,'     6.EXIT---exit '   
         DB 0DH,0AH,'         Please input:Q'  
         DB 0DH,0AH,' '  
         DB 0DH,0AH,'----------------------------- '  
         DB 0DH,0AH,'  
   
  
                  
;���ֲ���ʱ����ʾ���ַ�  
msgdoing  DB 0DH,0AH,0DH,0AH  
          DB 0DH,0AH,'Now,playing the music which you chose '  
          DB 0DH,0AH,'please waiting...'  
          DB 0DH,0AH,0DH,0AH,'  
  
          
;-----------------------------���� -----------------------------  
MUS_FREG1 dw 262,294,330,262,262,294,330,262                     ;��ֻ�ϻ�_Ƶ�ʱ�  
            dw 330,349,392,330,349,392,392,440  
            dw 392,349,330,262,392,440,392,349  
            dw 330,262,294,196,262,294,196,262,-1   
MUS_TIME1 dw 10 dup(25)                                          ;��ֻ�ϻ�_����ʱ���  
            dw 50,25,25,50,4 dup(12),25,25  
            dw 4 dup(12),4 dup(25),50,25,25,50  
MUS_FREG2 dw 262,294,330,262,262,294,330,262                     ;��ֻ�ϻ�_Ƶ�ʱ�  
            dw 330,349,392,330,349,392,392,440  
            dw 392,349,330,262,392,440,392,349  
            dw 330,262,294,196,262,294,196,262,-1  
MUS_TIME2 dw 10 dup(12)                                         ;��ֻ�ϻ�(�ӿ��)_����ʱ���  
            dw 25,12,12,25,4 dup(6),12,12  
            dw 4 dup(6),4 dup(12),25,12,12,25  
MUS_FREG3 dw 330,294,262,294,3 dup(330),3 dup(294),330,392,392    ;��Mary Had a little Lamb��Ƶ�ʱ�  
            dw 330,294,262,294,4 dup(330),294,294,330,294,262,-1       ;��Mary Had a little Lamb�����һ��-1���ƽ���  
MUS_TIME3  dw 6 dup(25),50,2 dup(25,25,50),12 dup(25),100   
             
                      
DATA ENDS  
;-------------------���ݶ�finsh-----------------------------  
  
  
;----------------------��ջ��-----------------------------  
STACK SEGMENT   
      
DB 300 DUP('STACK����')   
  
STACK ENDS   
;----------------------��ջ��finsh-----------------------------  
  
  
  
;----------------------�����-----------------------------  
  
CODE SEGMENT   
;------------------------------------------------------------  
main proc far  
      
   ASSUME DS:DATA,SS:STACK,CS:CODE   
  
START:   
  
   MOV AX,DATA   
   MOV DS,AX   
   MOV AH, 0                   ;ah������ʾ��ʽ  
   MOV AL,00                   ;AL=00�������40*25 �ڰ��ı���16���Ҷ�   
   INT 10H                     
  
;-----------------------����������ʾ�ַ����ĺ�  
SHOW MACRO b   
   LEA DX,b   
   MOV AH,9                 ;��ʾ�ַ���  
   INT 21H   
ENDM   
  
;-----------------------���ֵ�ַ��   
ADDRESS MACRO A,B   
   LEA SI,A                   ;��A�ĵ�ַ����SI�Ĵ���  
   LEA BP,DS:B                ;�����ݶ�Data��B�ĵ�ַ����BP�Ĵ���  
ENDM   
  
;-----------------------------  
  
show INFO1   
show MUSLIST   
  
INPUT:   
   MOV AH,01H                   ;����1��Q��ѡ��ʼ���˳�  
   INT 21H   
   CMP AL,'Q'   
   JZ RETU1   
   CMP AL,'1'   
   JNZ B0   
  
   ADDRESS MUS_FREG1,MUS_TIME1   
   CALL MUSIC0  
   JMP EXIT1   
  
B0:  
   CMP AL,'2'   
   JNZ C0   
   ADDRESS MUS_FREG2,MUS_TIME2   
   CALL MUSIC0   
   JMP EXIT1   
  
C0:   
   CMP AL,'3'   
   JNZ D0  
   ADDRESS MUS_FREG1,MUS_TIME1   
   CALL MUSIC1   
  
D0:  
   cmp al,'4'  
   jnz E0  
   address MUS_FREG1,MUS_TIME1  
   CALL MUSIC2  
   JMP EXIT1  
  
E0:  
   CMP AL,'5'  
   JNZ EXIT  
   ADDRESS MUS_FREG3,MUS_TIME3  
   CALL MUSIC0  
  
EXIT1:  
   show INFO4   
   JMP INPUT   
RETU1:  
   JMP RETU  
EXIT:    
   show INFO3   
   show INFO4  
   show INFO1   
   show MUSLIST   
   jmp INPUT   
  
RETU:  
   MOV AH,4CH   
   INT 21H   
   RET  
main endp     
;----------------------------------------------------------����   
  
GENSOUND PROC NEAR   
   PUSH AX   
   PUSH BX   
   PUSH CX   
   PUSH DX   
   PUSH DI   
  
   MOV AL,0B6H     ;�ÿ����ֶԶ�ʱ��2���г�ʼ��  
   OUT 43H,AL      ;43�˿���һ��������  
   MOV DX,12H      ;DX��Ÿߵ�ַ  
   MOV AX,348ch    ;AX��ŵ͵�ַ  
   DIV DI          ;value of freq  
   OUT 42H,AL     ;�����ΰ�ax��  
   MOV AL,AH      ;�������  
   OUT 42H,AL     ;�䵽�˿�42H  
   IN AL,61H       ;�Ѷ˿�61H�������͵�AL  
   MOV AH,AL      ;����˿�61H�ĳ�ʼ����  
   OR AL,3           
   OUT 61H,AL       ;turn on the speaker  
WAIT1:              ;ʱ���ӳ�  
   MOV CX,5000      ;ѭ��������wait for specified interval  
   CALL waitf   
DELAY1:   
   DEC BX   
   JNZ WAIT1   
   MOV AL,AH  ;  
   OUT 61H,AL ;turn off the speaker  
     
   POP DI   
   POP DX   
   POP CX   
   POP BX   
   POP AX   
   RET   
GENSOUND ENDP   
;--------------����finish--------------------  
  
  
;-----------------------------   
WAITF PROC NEAR   
   PUSH AX   
WAITF1:   
   IN AL,61H        ;��ض˿�61H��ŵ�AL��  
     
   AND AL,10H       ;���PB4λ�Ƿ�Ϊ1  
   CMP AL,AH        ;did it just change       
   JE WAITF1        ;wait for change  
   MOV AH,AL        ;save the new PB4 status  
   LOOP WAITF1      ;continue until CX becomes 0  
   POP AX   
   RET   
WAITF ENDP   
  
;-----------------------------  
  
MUSIC0 PROC NEAR   
   SHOW msgdoing   
   PUSH DS   
   SUB AX,AX   
   PUSH AX   
FREG0: MOV DI,[SI];��SIָ������ݴ���DI   
   CMP DI,-1        ;�ж��Ƿ��˵������  
   JE END_MUS0   
   MOV BX,DS:[BP]    ;�����ݶε����ݣ����ı�����BX  
   CALL GENSOUND   
   ADD SI,2   
   ADD BP,2    
   JMP FREG0   
END_MUS0:   
   RET   
MUSIC0 ENDP   
  
MUSIC1 PROC NEAR    
   PUSH DS   
   SUB AX,AX   
   PUSH AX   
FREG1:   
   MOV DI,[SI]        ;��SIָ������ݴ���DI   
   CMP DI,-1          ;�ж��Ƿ��˵������  
   JE END_MUS1   
   MOV BX,DS:[BP]    
NEW_NOTE:  
   MOV AH,01H   
   int 21H  
   CMP AL,'0'  
   JNE NEW_NOTE  
  
     
   CALL GENSOUND  
   ADD SI,2   
   ADD BP,2    
   JMP FREG1   
  
END_MUS1:   
   RET   
MUSIC1 ENDP   
  
MUSIC2 PROC NEAR   
   SHOW INFO7  
   PUSH DS   
   SUB AX,AX   
   PUSH AX   
FREG2:   
   MOV DI,[SI]      ;��SIָ������ݣ�Ƶ�ʱ�����DI   
   CMP DI,-1        ;�ж��Ƿ��˵������  
   JE END_MUS2   
   MOV BX,DS:[BP]   ;�����ݶε����ݣ����ı�����BX  
   CALL GENSOUND   
  
   MOV AH,9  
   MOV AL,13  
   MOV CX,50  
   INT 10H  
  
   SHOW INFO6  
  
   ADD SI,2   
   ADD BP,2    
   JMP FREG2   
  
END_MUS2:   
   RET   
MUSIC2 ENDP   
  
CODE ENDS   
END START  