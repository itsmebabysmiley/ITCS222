; How to complie this .asm file to .exe?
; copy just.asm to NASM folder.
; open cmd cd to NASM folder.
; type >>> nasm -f obj Max.asm && bcc32 Max.obj driver.obj asm_io.obj && Max
%include "asm_io.inc"
segment _DATA public align=4 class=DATA use32

message1 db "Enter 1st number: ",0
message2 db "Enter 2nd number: ", 0
message3 db "Enter 3rd number: ", 0

result   db "The result is: ",0


segment _BSS public align=4 class=BSS use32

input1	 resd    1              ; first number entered
input2   resd    1
input3   resd    1
max      resd    1

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
        mov     [input2], eax

        mov     eax, message3     ; print out second message
        call    print_string
        call    read_int          ; input second number
        mov     [input3], eax

        ;compare
        mov     eax, [input1]     ; eax = input1
        cmp     eax, [input2]     ; if eax > input2
        jg      compare             ;     jump when eax > input2
        mov     eax, [input2]     ; else eax = input2 (input2 is greater)

compare:
        cmp     eax, [input3]     ; if eax > input3
        jg      exit              ;     jump when eax > input3
        mov     eax, [input3]


exit:   
        mov    [max] , eax
        mov    eax, result
        call   print_string       ;print 'The result is: '
        mov    eax, [max]
        call   print_int
        call   print_nl
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
