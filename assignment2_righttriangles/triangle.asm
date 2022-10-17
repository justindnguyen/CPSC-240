;/*=====================================================================================================================================
;Author: Justin Nguyen
;Email: justindnguyen03@csu.fullerton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-01-02, MW 1200PM-0150PM, CS104
;Start Date: 4 September, 2022
;
;Program Name: Right Triangles
;Programming Languages: C and X86
;Date of Last Update: 17 September, 2022
;Date of Reorganization of Comments: 17 September, 2022
;Files in this Program: pythagoras.c, triangle.asm, isfloat.asm, run.sh, gdb.sh
;Status: Finished. The program was tested with no errors on WSL Ubuntu 20.04.4 LTS. 
;
;Program Description: This program asks the user to input the lengths of two sides of a right triangle and will compute the hypotenuse and area.
;The program will also validate inputs to exclude zeroes and negative numbers. 
;
;Purpose of this File: Assembly file that defines the right_triangle function used in the driver pythagoras.c.
;
;File name: triangle.asm
;Language: X86 with Intel syntax.
;Assemble: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
;Link: gcc -m64 -no-pie -o main.out pythagoras.o triangle.o isfloat.o -std=c17 
;Run: sh run.sh
;
;Copyright (C) 2022 Justin Nguyen
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
;======================================================================================================================================*/

;Begin code area
extern printf
extern scanf
extern atof
extern fgets
extern stdin
extern strlen
extern isfloat

global right_triangle

segment .data
    ;defining variables
    input_name_prompt db "Please enter your last name: ", 0
    input_title_prompt db "Please enter your title (Mr, Ms, Nurse, Engineer, etc): ", 0
    input_triangle_sides db "Please enter the sides of your triangle separated by ws: ", 10, 0
    output_hypotenuse db "The length of the hypotenuse is %lf units.", 10, 0
    output_area db "The area of the triangle is %lf units squared.", 10, 10, 0
    output_goodbye db "Please enjoy your triangles %s %s.", 10, 0
    error_message1 db "Please type a float.", 10, 0
    error_message2 db "Please type a number greater than 0.", 10, 0
    squaring db 10, "Squaring...", 10, "%lf", 10, "%lf", 10, 10, 0
    adding db "Adding...", 10, "%lf", 10, 10, 0
    squarerooting db "Square rooting...", 10, "%lf", 10, 10, 0
    string_format db "%s", 0
    double_float_format db "%lf%lf", 0
    double_string_format db "%s%s", 0
    one_float_format db "%lf", 0
    zero dq 0

segment .bss
    ;reserved for uninitialized data
    lastname: resb 256
    title: resb 256
    buffer: resb 256

segment .text
    ;reserved for executing instructions

right_triangle:
    ;back up gpr registers
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

;prompt user input for last name
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, input_name_prompt
    call printf
    pop rax

;input last name
    push qword 0
    mov rax, 0
    mov rdi, lastname
    mov rsi, buffer
    mov rdx, [stdin]
    call fgets
    
;remove newline char
    mov rax, 0
    mov rdi, lastname
    call strlen
    mov byte [lastname + rax - 1], 0
    pop rax

;prompt user input for title
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, input_title_prompt
    call printf
    pop rax

;input title
    push qword 0
    mov rax, 0
    mov rdi, title
    mov rsi, buffer
    mov rdx, [stdin]
    call fgets

;remove newline char
    mov rax, 0
    mov rdi, title
    call strlen
    mov byte [title + rax - 1], 0
    pop rax

;prompt user input for 2 sides
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, input_triangle_sides
    call printf
    pop rax

;input two sides
input:
    push qword 0
    sub rsp, 2048
    mov rax, 0
    mov rdi, double_string_format
    mov rsi, rsp
    mov rdx, rsp
    add rdx, 1024
    call scanf

    ;check if inputs are floats
    mov rax, 0
    mov rdi, rsp
    call isfloat
    cmp rax, 0
    je error_string

    mov rax, 0
    mov rdi, rsp
    add rdi, 1024
    call isfloat
    cmp rax, 0
    je error_string

    ;convert inputs to floats and store them in xmm registers
    mov rdi, rsp
    call atof
    movsd xmm15, xmm0

    mov rdi, rsp
    add rdi, 1024
    call atof
    movsd xmm14, xmm0
    
    ;compares if inputs are greater than zero
    movsd xmm9, [zero]
    ucomisd xmm15, xmm9
    jbe error_number
    ucomisd xmm14, xmm9
    jbe error_number

    pop rax
    jmp calculate

;Calculate hypotenuse
calculate:
    movsd xmm12, xmm15
    movsd xmm13, xmm14

    ;square inputs
    mulsd xmm12, xmm12
    mulsd xmm13, xmm13

    push qword 0
    mov rax, 2
    mov rdi, squaring
    movsd xmm0, xmm12
    movsd xmm1, xmm13
    call printf
    pop rax

    ;add inputs together
    addsd xmm11, xmm12
    addsd xmm11, xmm13

    push qword 0
    mov rax, 1
    mov rdi, adding
    movsd xmm0, xmm11
    call printf
    pop rax

    ;square root total
    sqrtsd xmm10, xmm11

    push qword 0
    mov rax, 1
    mov rdi, squarerooting
    movsd xmm0, xmm10
    call printf
    pop rax

;print length of hypotenuse
    push qword 0
    mov rax, 1
    mov rdi, output_hypotenuse
    movsd xmm0, xmm10
    call printf
    pop rax

;calculate area
    mov rbx, 0
    cvtsi2sd xmm7, rbx
    addsd xmm7, xmm15
    mulsd xmm7, xmm14
    mov rcx, 2
    cvtsi2sd xmm8, rcx
    divsd xmm7, xmm8

;print area
    push qword 0
    mov rax, 1
    mov rdi, output_area
    movsd xmm0, xmm7
    call printf
    pop rax

;return numbers and end program
    push qword 0
    mov rax, 0
    mov rdi, output_goodbye
    mov rsi, title
    mov rdx, lastname
    call printf
    pop rax
    
    movsd xmm0, xmm10
    pop rax
    jmp restore_gpr_reg

;if any inputs are strings, re-enter values
error_string:
    mov rax, 0
    mov rdi, string_format
    mov rsi, error_message1
    call printf
    pop rax

    add rsp, 2048
    jmp input

;if any inputs are less than or equal to 0, re-enter values
error_number:
    mov rax, 0
    mov rdi, string_format
    mov rsi, error_message2
    call printf
    pop rax

    add rsp, 2048
    jmp input

;restores original values to gpr registers
restore_gpr_reg:
    add rsp, 2048

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