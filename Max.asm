

;nasm -f obj mmax.asm
;bcc32 first.obj driver.obj asm_io.obj

%include "asm_io.inc"
segment _DATA public align=4 class=DATA use32

message1 db "Enter a number: ",0
message2 db "Enter another number: ", 0
message3 db "Enter another number: ", 0
message4 db "The larger number is: ", 0

segment _BSS public align=4 class=BSS use32

input1	resd    1                ; first number entered
input2	resd	1		 ; second number 
input3  resd    1    
input4  resd    1

group DGROUP _BSS _DATA

segment _TEXT public align=1 class=CODE use32
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, message1     ; print out first message
        call    print_string
        call    read_int          ; input first number
        mov     [input1], eax

        mov     eax, message2     ; print out second message
        call    print_string
        call    read_int          ; input second number
        xor     ebx, ebx          ; ebx = 0
        cmp     eax, [input1]     ; compare second and first number
        setg    bl                ; ebx = (input2 > input1) ?          1 : 0
        neg     ebx               ; ebx = (input2 > input1) ? 0xFFFFFFFF : 0
        mov     ecx, ebx          ; ecx = (input2 > input1) ? 0xFFFFFFFF : 0
        and     ecx, eax          ; ecx = (input2 > input1) ?     input2 : 0
        not     ebx               ; ebx = (input2 > input1) ?          0 : 0xFFFFFFFF
        and     ebx, [input1]     ; ebx = (input2 > input1) ?          0 : input1
        or      ecx, ebx          ; ecx = (input2 > input1) ?     input2 : input1
        mov     [input3],ecx

        mov     eax, message3     ; print out third message
        call    print_string
        call    read_int          ; input third number
        xor     ebx, ebx          ; ebx = 0
        cmp     eax, [input3]     ; compare second and first number
        setg    bl                ; ebx = (input2 > input1) ?          1 : 0
        neg     ebx               ; ebx = (input2 > input1) ? 0xFFFFFFFF : 0
        mov     ecx, ebx          ; ecx = (input2 > input1) ? 0xFFFFFFFF : 0
        and     ecx, eax          ; ecx = (input2 > input1) ?     input2 : 0
        not     ebx               ; ebx = (input2 > input1) ?          0 : 0xFFFFFFFF
        and     ebx, [input3]     ; ebx = (input2 > input1) ?          0 : input1
        or      ecx, ebx          ; ecx = (input2 > input1) ?     input2 : input1
        mov     [input4],ecx


        mov     eax, message4     ; print out result
        call    print_string
        mov     eax, [input4]
        call    print_int
        call    print_nl

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


