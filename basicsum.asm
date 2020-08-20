; How to complie this .asm file to .exe?
; copy just.asm to NASM folder.
; open cmd cd to NASM folder.
; type >>> nasm -f obj basicsum.asm && bcc32 basicsum.obj driver.obj asm_io.obj && basicsum

%include "asm_io.inc"
segment _DATA public align=4 class=DATA use32

message1 db "Enter 1st number: ",0
message2 db "Enter 2nd number: ", 0
message3 db "Enter 3rd number: ", 0
number1  db "1st number is: ",0
number2  db "2nd number is: ",0
number3  db "3rd number is: ",0
message4 db "The result is: ",0


segment _BSS public align=4 class=BSS use32

input1	resd    1                ; first number entered
input2	resd	1		 ; second number 
input3  resd    1    
sum     resd    1
result  resd    1

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
        mov     [input2],eax

        mov     eax, message3     ; print out third message
        call    print_string
        call    read_int          ; input third number
        mov     [input3],eax

        ;sum
        mov eax,[input1]          ;eax = input1
        add eax,[input2]          ;eax = eax + input2
        add eax,[input3]          ;eax = eax + input3
        mov [sum],eax             ;store eax into sum

        mov     eax, message4     ; print message " The result is: "
        call    print_string    
        mov     eax, [sum]      
        call    print_int
        call    print_nl



        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
