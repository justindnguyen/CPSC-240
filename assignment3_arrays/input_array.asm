;/*=====================================================================================================================================
;Author: Justin Nguyen
;Email: justindnguyen03@csu.fullerton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-01-02, MW 1200PM-0150PM, CS104
;Start Date: 19 September, 2022
;
;Program Name: Integer Array
;Programming Languages: C, C++, X86
;Date of Last Update: 31 October, 2022
;Date of Reorganization of Comments: 31 October, 2022
;Files in this Program: main.c, manager.asm, input_array.asm, sum.asm, atol.asm, display_array.cpp, isinteger.cpp, run.sh
;Status: Finished. The program was tested with no errors on WSL Ubuntu 20.04.4 LTS. 
;
;Program Description: This program will allow a user to input integers in an array of size 6. The program will input and validate
;integers into the array. It will also display the contents, add the integers together, and display the result.
;
;Purpose of this File: Assembly file that defines the input_array function used in the manager manager.asm. This file inputs and 
;validates integers into the array. Returns the number of elements back to the caller in manager.asm. 
;
;File name: input_array.asm
;Language: X86 with Intel syntax.
;Assemble: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
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
extern scanf
extern atolong
extern isinteger

global input_array

segment .data
    ;defining variables
    string_format db "%s", 0

segment .bss
    ;reserved for uninitialized data

segment .text
    ;reserved for executing instructions

input_array:
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
    call isinteger
    cmp rax, 0
    je error_long

    mov rax, 0
    mov rdi, rsp
    call atolong
    mov r11, rax

    mov [r15 + 8 * r13], r11
    inc r13

    cmp r13, r14
    je outOfLoop

    jmp beginOfLoop

error_long:
    jmp beginOfLoop

outOfLoop:
    pop rax
    mov rax, r13
    jmp restore_gpr_reg

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