;Author: Justin Nguyen
;Email: justindnguyen03@csu.fullerton.edu
;Date: October 12, 2022
;Section ID: Section 1 MW 12:00PM-01:50PM

extern printf
extern fgets
extern stdin
extern strlen
extern get_data
extern show_data
extern max

array_size equ 6

global manager

segment .data
    input_name_prompt db 10, "Please enter your name: ", 0
    instruction_prompt1 db 10, "Please enter float point numbers separated by ws to be stored in an array of size 6 cells.", 10, 0
    instruction_prompt2 db "After the last input, press <enter> followed by <control+d>.", 10, 0
    array_result db 10, "These numbers are stored in the array.", 10, 0
    largest_value db "The largest value in the array is %lf.", 10, 10, 0
    string_format db "%s", 0

segment .bss
    name: resb 256
    buffer: resb 256
    float_array: resq array_size

segment .text

manager:
    push rbp
    mov rbp, rsp
    push rdi                
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf
    push qword 0

start:
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, input_name_prompt
    call printf
    pop rax

input_name:
    push qword 0
    mov rax, 0
    mov rdi, name
    mov rsi, buffer
    mov rdx, [stdin]
    call fgets

    mov rax, 0
    mov rdi, name
    call strlen
    mov byte [name + rax - 1], 0
    pop rax

input_floats:
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, instruction_prompt1
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, instruction_prompt2
    call printf
    pop rax

    mov rax, 0
    mov rdi, float_array
    mov rsi, array_size
    call get_data
    mov r15, rax
    pop rax

array_out:
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, array_result
    call printf
    pop rax

    mov rax, 0
    mov rdi, float_array
    mov rsi, r15
    call show_data
    pop rax

largest:
    push qword 0
    mov rax, 0
    mov rdi, float_array
    mov rsi, r15
    call max
    movsd xmm15, xmm0
    pop rax

    push qword 0
    mov rax, 1
    mov rdi, largest_value
    movsd xmm0, xmm15
    call printf

return:
    mov rax, name
    jmp restore_gpr_reg

restore_gpr_reg:
    popf
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp

    ret