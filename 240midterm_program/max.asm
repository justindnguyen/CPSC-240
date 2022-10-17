;Author: Justin Nguyen
;Email: justindnguyen03@csu.fullerton.edu
;Date: October 12, 2022
;Section ID: Section 1 MW 12:00PM-01:50PM

global max

segment .data

segment .bss

segment .text

max:
push rbp
mov  rbp,rsp
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
mov r15, rdi
mov r14, rsi

mov rdx, 0
mov rcx, 0 
cvtsi2sd xmm15, rdx
cvtsi2sd xmm14, rcx

mov r13, 0
beginLoop:
    cmp r13, r14
    je outOfLoop

    movsd xmm15, [r15 + 8*r13]
    ucomisd xmm15, xmm14
    ja greater
  
    inc r13
    jmp beginLoop
greater:
    movsd xmm14, [r15+ 8*r13]
    inc r13
    jmp beginLoop

outOfLoop:
    pop rax
    movsd xmm0, xmm14
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