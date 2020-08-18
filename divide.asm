; How to complie this .asm file to .exe?
; copy just.asm to NASM folder.
; open cmd cd to NASM folder.
; type >>> nasm -f obj divide.asm && bcc32 divide.obj driver.obj asm_io.obj && divide

%include "asm_io.inc"
segment _DATA public align=4 class=DATA use32

message1 db "Enter 1st number: ",0
message2 db "Enter 2nd number: ", 0
message3 db "Enter 3rd number: ", 0
number1  db "1st number is: ",0
number2  db "2nd number is: ",0
number3  db "3rd number is: ",0
result   db "The result is: ",0


segment _BSS public align=4 class=BSS use32

input1	 resd    1              ; first number entered
result1  resd    0

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

        mov     eax, number1     ; print message " The result is: "
        call    print_string
        mov     eax,[input1]
        call    print_int
        call    print_nl

        ;divide
        mov al,[input1]
        mov bl,3
        div bl
        mov [result1],ax

        mov     eax, result     ; print message " The result is: "
        call    print_string
        mov     eax,[result1]
        call    print_int
        call    print_nl



        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret