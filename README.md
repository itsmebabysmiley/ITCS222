# Assembly
## [Read my text](https://github.com/itsmebabysmiley/Assembly/blob/master/text)
ref:
http://pacman128.github.io/pcasm/  
Could you please create beautiful readme for my resp?
<mark># ALL YOU NEED IN COM ARCH </mark>
***
## general register 
eax, ebx, ecx, edx  >>32 bits  
&nbsp;&nbsp;-eax บวกลบเลข  
&nbsp;&nbsp;-ecx นับลูป  
***
## Data type  
### 1. char  
&nbsp;&nbsp;-byte(1 bytes / 8 bits)  
&nbsp;&nbsp;-sbyte(signed byte)  
### 2. int(turbo c)  
&nbsp;&nbsp;-word(2 bytes / 16bits)  
&nbsp;&nbsp;-sword(signed word)  
### 3. int(java)  
&nbsp;&nbsp;-dword(4 bytes / 32 bits)    
&nbsp;&nbsp;-sdword(signed dword)  
### 4. other
&nbsp;&nbsp;-fword(6 bytes)  
&nbsp;&nbsp;-qword(8 bytes)  
&nbsp;&nbsp;-tbyte(10 bytes)  
***
## common flags
|flags |     name    |    1       |   0          |
|------|:-----------:|:----------:|:------------:|
|cf    | carry flag  |  carry     | no carry     |
|pf    | parity flag |  even      | odd          |
|zf    | zero flag   |  zero      | non zero     |     
|sf    | sign flag   |  negative  | positive     |     
|of    | overflow    |  overflow  | not overflow |         
***
## common command
### 1. mov  
mov a,b >> a = b\
**condition is**  
&nbsp;&nbsp;-size of a must equal b\
&nbsp;&nbsp;-register to register\
&nbsp;&nbsp;-memory to register\
&nbsp;&nbsp;-register to memory\
&nbsp;&nbsp;-can't move memory to memory. For example you want to do a = b\
&nbsp;&nbsp;&nbsp;&nbsp; ```mov a,b``` \
#### &nbsp;&nbsp;-You have to do this.\
&nbsp;&nbsp;&nbsp;&nbsp;```mov eax,a```\
&nbsp;&nbsp;&nbsp;&nbsp;```mov b,eax ```
         
$ call
call    >>call functions

$ add addition
add a,b >>a = a + b ; a is register . b is register or ตัวแปร or memory
ex.
  mov eax,1 ;eax = 1
  add eax,2 ;eax = 1+2

$ sub subtraction
sub a,b >> a = a - b
ex.
  mov eax,1 ; eax = 1
  sub eax,2 ; eax = 1 -2
  
$ neg negative
neg a >> a = -a
$ inc increase (i++)
inc a >> a = a + 1  ;faster than add
$ dec decease (i--)
dec a >> a = a - 1  ;faster than sub
$ shl shift left
shl a,b >> a = a << b shift left
ex.
  mov ax, 10001b  ; ax = 10001 (b is binary)
  shl ax,1        ; ax = 00010
  mov ax ,12345h  ; ax = 12345 (hex)
  shl ax,4        ; ax =23450 (1 binary = 1 hex)
$ shr shift right
shr a,b >> a = b >> b shift right
--------------------------------
| signed is มีเครื่องหมาย          |
| unsigned is ไม่มีเครื่องหมาย      |
--------------------------------
$ movsx
movsx a,b >> a = b(signed) b is smaller than a
ex.
  mov bx,5 ; eax = 0005
  movsx eax,bx  ; eax = 00000005
  
---------------------------
| ffffffff is negative    |
---------------------------

$ movzx
movzx a,b >> a = b(unsigned)

***********เบสิก อินพุด เอ้าพุด***********
*   https://pastebin.com/jYb9iaF6   
*************************************
***********ซอสศรีราชา อาเรย์***********
* https://pastebin.com/BFc9fkYD     
************************************

## Arrays
$ how to create array?
byteArrays BYTE  11h,12h,13h  >>heximal array
wordArrays WORD  5566h,8899h  >>heximal array
dwordArrays DWORD 1,2,3       >>integer array
string BYTE "h","e","l","l","o",0 ; "hello', 0 ; 0 is newline  >>string array

OFFSET ตำแหน่ง
TYPE ขนาดarrayแต่ละช่อง
LENGTHOF ความยางของอาเรย์
SIZEOF ขนาดอาเรย์ทั้งหมด length * type

$ Direct Address
print แค่สมมุด
print dwordArrays ; show 1
print [dwordArrays + 4] ; show 2
print dwordArrays[4] ; show 2
กาก คอมพายไม่เช็คให้ ถ้า dword + 1 ก้ได้แต่ผิด จะได้ค่าขยะ บวกหนึ่งในเมมไม่ได้แปลว่าขยับไปช่องหนึ่ง
dwordArray[2*TYPE dwordArray] ;ใช้งี้ กันพลาด

$ Indirect operand
.data
  dwordArray BYTE 1,2,3,4
.code
 
 main:
  move ecx , lengthof dwordArray    ;ecx ต้องการลูปกี่ครั้ง
  move esi , Offset dwordArray      ;source index ตัวที่เท่าไหล่ นิยมใช่ esi กับ edi เพราะ optimize มาเพื่อส้นตีนไรอะ ถ้าก้อปปี้ก้แบบ edi = esi 
  
 L1:
  mov eax , [esi] ; ต้องใส่วงเล็บ เพราะ เราต้องการค่าที่esiชี้อยู่ คล้ายๆ index = 0 array[index] = 1 ถ้าเราใช้ esi จะได้ 0 แต่[esi] = 1 เราอยากได้ 1
  call print      ; show eax
  add esi , Type dwordArray   ; ขยับไปตัวถัดไป
  loop L1 ;กลับไปลูปใหม่่ โดย จะลด ecx -= 1 อัตโนมัติ จน 0 จึงจลลูป ; jmp l1
  
  exit จบโปรแกรม
  
$ Index operand
main:
  move ecx , lengthof dwordArray    ;ecx ต้องการลูปกี่ครั้ง
  move esi , 0       
  
 L1:
  mov eax , [2*TYPE dwordArray]
  call print      ; show eax
  inc esi
  loop L1 ;กลับไปลูปใหม่่ โดย จะลด ecx -= 1 อัตโนมัติ จน 0 จึงจลลูป ; jmp l1

## Condition if else
  cmp ;compare
  jmp jump to dis-ti-na-tion
  *****flags เขาสอนแหละ แต่กุลืม*****
  $ condition jump
  jump flags
  JZ zf =1    | JNZ zf =0
  JC cf =1    | JNC cf =0
  JO of =1    | JNO of =0
  JS sf =1    | JNS sf =0
  JP pf =1    | JNP pf =0
  
  $ unsigned
  cmp eax,ebx
  JA L1; eax>ebx ;jump to L1
  JB eax<ebx
  JE eax=ebx ; JE = JZ ;zf =1
  JAE eax>=ebx
  JBE eax<=ebx
  JN___ <jump not ....>
  
  $signed
  JG eax>ebx
  JL eax<ebx
  JE eax = ebx
  JGE eax>=ebx
  JLE eax<=ebx
  ex. find max 2 and 5
    mov eax, 2        ; eax = 2
    cmp eax, 5        ;
    jg  <...>         ; if eax > 5  jump to dis-ti-na-tion
    mov [max],eax  ; else max = eax ; max = 5
    
***********source code condition*************
*  https://gist.github.com/anonymous/3787684
*********************************************
  
  binary ดูหลักสุดท้ายบอก 0 = odd 1 = even
 
## multiply
  mul a ;unsinged
  imul a; singed
  ขนาด | ตัวตั้ง | ผลลัพเก้บ เป้นสองเท่า
    8     AL      AH:AL  = AX ; 8 bits ล่างเก็บ al 8 bits บนเก้บ ah
    16    AX      DX:AX
    32    EAX     EDX:EAX
   ex. 2*3
      mov al,2
      mov bl,3
      mul bl
            al = 6 ; ah = 0 ignore มัน
## devide
  div a ;unsigned
  idiv a;signed
  -------------------------------
   ขนาด | ตัวตั้ง | ผลลัพ  | เศษ
    8     AX      AL       AH 
    16    DX:AX   AX       DX
    32    EDX:EAX EAX      EDX     
  
  ขยายเมม singed
  cbw (convert btye to word) : al -> ax
  cwd (convert word to dword): ax -> dx:ax
  cdq convert dword to qword): eax-> edx:eax
  ex. 16/3 assume 16 and 3 are singed
    mov al,16
    cbw
    mov bl,3
    idiv bl       16/3 = 5 r 1
        al = 5 ; เก็บผลลัพไว้ al
        ah = 1 ; เก็บเศษไว้ใน ah
