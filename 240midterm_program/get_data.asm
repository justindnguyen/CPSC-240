;Author: Justin Nguyen
;Email: justindnguyen03@csu.fullerton.edu
;Date: October 12, 2022
;Section ID: Section 1 MW 12:00PM-01:50PM

extern printf
extern scanf
extern atof
extern isfloat

global get_data

segment .data
    string_format db "%s", 0

segment .bss

segment .text

get_data:
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

;store array
    mov r15, rdi   
;store array size
    mov r14, rsi
;begin loop counter
    mov r13, 0

beginOfLoop:
    cmp r13, r14
    je outOfLoop

    mov rax, 0
    mov rdi, string_format
    mov rsi, rsp
    call scanf

    cdqe
    cmp rax, -1
    je outOfLoop

    mov rax, 0
    mov rdi, rsp
    call isfloat
    cmp rax, 0
    je invalid_input

    mov rax, 0
    mov rdi, rsp
    call atof
    movsd xmm15, xmm0

    movsd [r15 + 8 * r13], xmm15
    inc r13

    cmp r13, r14
    je outOfLoop

    jmp beginOfLoop

invalid_input:
    jmp beginOfLoop

outOfLoop:
    pop rax
    mov rax, r13
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