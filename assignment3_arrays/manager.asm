;/*=====================================================================================================================================
;Author: Justin Nguyen
;Email: justindnguyen03@csu.fullerton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-01-02, MW 1200PM-0150PM, CS104
;Start Date: 19 September, 2022
;
;Program Name: Integer Array
;Programming Languages: C, C++, X86
;Date of Last Update: 26 September, 2022
;Date of Reorganization of Comments: 26 September, 2022
;Files in this Program: main.c, manager.asm, input_array.asm, sum.asm, display_array.cpp, run.sh
;Status: Finished. The program was tested with no errors on WSL Ubuntu 20.04.4 LTS. 
;
;Program Description: This program will allow a user to input integers in an array of size 6. The program will input and validate
;integers into the array. It will also display the contents, add the integers together, and display the result.
;
;Purpose of this File: Assembly file that defines the manager function used in the driver main.c. It is the central module that
;contains calls to multiple child functions. Returns the name to the caller in main.c.
;
;File name: manager.asm
;Language: X86 with Intel syntax.
;Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
;Link: gcc -m64 -no-pie -o array.out main.o display_array.o manager.o input_array.o sum.o -std=c17  
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
extern fgets
extern stdin
extern strlen
extern display_array
extern sum
extern input_array

global manager

array_size equ 6

segment .data
    ;defining variables
    input_name_prompt db 10, "Please enter your name: ", 0
    instruction_prompt db 10, "This program will sum your array of integers.", 10, 0
    output_array db 10, "These numbers were received and placed into the array:", 10, 0
    output_sum db 10, 10, "The sum of the %ld numbers in this array is %ld.", 10, 0
    return_prompt db 10, "This program will return execution to the main function.", 10, 10, 0
    prompt1 db "Enter a sequence of long integers separated by white space.", 10, 0
    prompt2 db "After the last input, press enter followed by Control+D: ", 10, 0
    string_format db "%s", 0
    double_float_format db "%lf%lf", 0
    double_string_format db "%s%s", 0
    one_float_format db "%lf", 0

segment .bss
    ;reserved for uninitialized data
    name: resb 256
    buffer: resb 256
    int_array: resq array_size

segment .text
    ;reserved for executing instructions

manager:
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

;enter name prompt - "Please enter your name: "
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, input_name_prompt
    call printf
    pop rax

;input name
    push qword 0
    mov rax, 0
    mov rdi, name
    mov rsi, buffer
    mov rdx, [stdin]
    call fgets

;remove newline char
    mov rax, 0
    mov rdi, name
    call strlen
    mov byte [name + rax - 1], 0
    pop rax

;print instruction prompt - "This program will sum your array of integers."
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, instruction_prompt
    call printf
    pop rax

;print prompt1
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, prompt1
    call printf
    pop rax

;print prompt2
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, prompt2    
    call printf
    pop rax

;call input_array
    mov rax, 0
    mov rdi, int_array
    mov rsi, array_size
    call input_array
    mov r15, rax
    pop rax

;print array values - "These numbers were received and placed into the array:"
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, output_array
    call printf
    pop rax

;call display_array
    mov rax, 0
    mov rdi, int_array
    mov rsi, r15
    call display_array
    pop rax

;call sum
    push qword 0
    mov rax, 0
    mov rdi, int_array
    mov rsi, r15
    call sum
    mov r8, rax
    ;movsd xmm15, xmm0
    pop rax

;print sum - "The sum of the %ld numbers in this array is %lf"
    push qword 0
    mov rax, 2
    mov rdi, output_sum
    mov rsi, r15
    mov rdx, r8
    ;movsd xmm0, xmm15
    call printf
    pop rax

;print return to main - "This program will return execution to the main function."
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, return_prompt
    call printf

;return name
    mov rax, name

restore_gpr_reg:
    ;restores original values to gpr registers
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