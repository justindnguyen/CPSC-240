;/*=====================================================================================================================================
;Author: Justin Nguyen
;Email: justindnguyen03@csu.fullerton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-01-02, MW 1200PM-0150PM, CS104
;Start Date: 24 October, 2022
;
;Program Name: Pure Assembly with Cosine
;Programming Languages: x86-64 Assembly
;Date of Last Update: 29 October, 2022
;Date of Reorganization of Comments: 29 October, 2022
;Files in this Program: manager.asm, strlen.asm, itoa.asm, ftoa.asm, atof.asm, degtorad.asm, cosine.asm, run.sh
;Status: Finished. The program was tested with no errors on WSL Ubuntu 20.04.4 LTS. 
;
;Program Description: This program accepts any degree as a float and converts it to its equivalent radians and calculates
;the cosine of the degree. The program also prints the time in ticks at the beginning and at the end of the program.
;
;Purpose of this File: Assembly file that defines the _start function used with the linker. It is the central module that
;contains calls to multiple child functions. Prints the time in ticks and results from their respective child function.
;
;File name: manager.asm
;Language: X86-64 with Intel syntax.
;Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
;Link: ld -o main.out manager.o strlen.o itoa.o atof.o cosine.o ftoa.o degtorad.o
;Run: sh run.sh
;
;Copyright (C) 2022 Justin Nguyen
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
;======================================================================================================================================*/

global _start

;Declare library functions
extern strlen
extern itoa
extern atof
extern ftoa
extern cosine
extern degtorad

;Data destinations
Stdin equ 0
Stdout equ 1
Stderror equ 2

;Kernel function code numbers
system_read equ 0
system_write equ 1
system_terminate equ 60

;Named constants
Null equ 0
Line_feed equ 10
Exit_with_success equ 0
Numeric_string_array_size equ 32

segment .data
    welcome_prompt db "Welcome to Accurate Cosines by Justin Nguyen.", Line_feed, Line_feed, Null
    time_result1 db "The time is now ", Null
    tics db " tics.", Line_feed, Line_feed, Null
    angle_prompt db "Please enter an angle in degrees and press enter: ", Null
    angle_result db Line_feed, "You entered ", Null
    radians_result db Line_feed, Line_feed, "The equivalent radians is ", Null
    cosine_result db Line_feed, Line_feed, "The cosine of those degrees is ", Null
    time_result2 db Line_feed, Line_feed, "The time is now ", Null
    bye db "Have a nice day. Bye.", Line_feed, Line_feed, Null

segment .bss
    degree_string resb Numeric_string_array_size
    radians_string resb 30
    cosine_string resb 30

segment .text

_start:
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

welcome:
    ;Get welcome_prompt length
    mov rax, Stdin
    mov rdi, welcome_prompt
    call strlen
    mov r12, rax

    ;Output welcome_prompt - "Welcome to Accurate Cosines by Justin Nguyen."
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, welcome_prompt
    mov rdx, r12
    syscall

time1:
    ;Get time_result1 length
    mov rax, Stdin
    mov rdi, time_result1
    call strlen
    mov r12, rax

    ;Output time_result1 - "The time is now "
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, time_result1
    mov rdx, r12
    syscall

    ;Pauses all other proceses
    cpuid
    ;Get clock from cpu returned into rdx and rax
    rdtsc
    ;Shift bits by 32 bits and combine registers into r8 
    shl rdx, 32
    or rdx, rax
    mov r8, rdx
    ;Convert tics to string
    mov rax, 0
    mov rdi, r8
    call itoa
    mov r9, rax

    ;Get tics (string) length
    mov rax, Stdin
    mov rdi, r9
    call strlen
    mov r12, rax

    ;Output tics (string)
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, r9
    mov rdx, r12
    syscall

    ;Get tics length
    mov rax, Stdin
    mov rdi, tics
    call strlen
    mov r12, rax

    ;Output tics - " tics."
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, tics
    mov rdx, r12
    syscall

angle:
    ;Get angle_prompt length
    mov rax, Stdin
    mov rdi, angle_prompt
    call strlen
    mov r12, rax

    ;Output angle_prompt - "Please enter an angle in degrees and press enter: "
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, angle_prompt
    mov rdx, r12
    syscall

;User input degrees
    mov rbx, degree_string
    mov r13, 0
    push qword 0
begin_loop:
    mov rax, system_read
    mov rdi, Stdin
    mov rsi, rsp
    mov rdx, 1
    syscall

    mov al, byte[rsp]

    cmp al, Line_feed
    je exit_loop

    inc r13
    cmp r13, Numeric_string_array_size
    jge end_if_else
    mov byte [rbx], al
    inc rbx
    end_if_else:
    jmp begin_loop

exit_loop:
    mov byte [rbx], Null
    pop rax

    ;Get angle_result length
    mov rax, Stdin
    mov rdi, angle_result
    call strlen
    mov r12, rax

    ;Output angle_result - "You entered "
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, angle_result
    mov rdx, r12
    syscall

    ;Get degrees (string) length
    mov rax, Stdin
    mov rdi, degree_string
    call strlen
    mov r12, rax

    ;Output degrees (string)
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, degree_string
    mov rdx, r12
    syscall

    ;Convert degrees to float
    mov rax, Stdin
    mov rdi, degree_string
    call atof
    movsd xmm8, xmm0

    ;Convert degree to radians
    mov rax, Stdin
    movsd xmm0, xmm8
    call degtorad
    movsd xmm9, xmm0

    ;Convert radians to string
    mov rax, Stdin
    movsd xmm0, xmm9
    mov rdi, radians_string
    call ftoa

    ;Get radians_result length
    mov rax, Stdin
    mov rdi, radians_result
    call strlen
    mov r12, rax

    ;Output radians_result - "The equivalent radians is "
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, radians_result
    mov rdx, r12
    syscall

    ;Get radians (string) length
    mov rax, Stdin
    mov rdi, radians_string
    call strlen
    mov r12, rax

    ;Output radians (string)
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, radians_string
    mov rdx, r12
    syscall

    ;Get cosine_result length
    mov rax, Stdin
    mov rdi, cosine_result
    call strlen
    mov r12, rax

    ;Output cosine_result - "The cosine of those degrees is "
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, cosine_result
    mov rdx, r12
    syscall

    ;Call cosine
    mov rax, Stdin
    movsd xmm0, xmm9
    call cosine
    movsd xmm12, xmm0

    ;Convert cosine to string
    mov rax, Stdin
    movsd xmm0, xmm12
    mov rdi, cosine_string
    call ftoa

    ;Get cosine (string) length
    mov rax, Stdin
    mov rdi, cosine_string
    call strlen
    mov r12, rax

    ;Output cosine (string)
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, cosine_string
    mov rdx, r12
    syscall

time2:
    ;Get time_result2 length
    mov rax, Stdin
    mov rdi, time_result2
    call strlen
    mov r12, rax

    ;Output time_result2 - "The time is now "
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, time_result2
    mov rdx, r12
    syscall

    ;Pauses all other proceses
    cpuid
    ;Get clock from cpu returned into rdx and rax
    rdtsc
    ;Shift bits by 32 bits and combine registers into r8 
    shl rdx, 32
    or rdx, rax
    mov r8, rdx
    ;Convert tics to string
    mov rax, 0
    mov rdi, r8
    call itoa
    mov r9, rax

    ;Get tics (string) length
    mov rax, Stdin
    mov rdi, r9
    call strlen
    mov r12, rax

    ;Output tics (string)
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, r9
    mov rdx, r12
    syscall

    ;Get tics length
    mov rax, Stdin
    mov rdi, tics
    call strlen
    mov r12, rax

    ;Out tics - " tics."
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, tics
    mov rdx, r12
    syscall

goodbye:
    ;Get bye length
    mov rax, Stdin
    mov rdi, bye
    call strlen
    mov r12, rax

    ;Output bye - "Have a nice day. Bye."
    mov rax, system_write
    mov rdi, Stdout
    mov rsi, bye
    mov rdx, r12
    syscall

exit:
    mov rax, system_terminate
    mov rdi, Exit_with_success
    syscall
    
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