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
;Purpose of this File: Assembly file that defines the sum function used in the manager manager.asm. This file takes an array and its
;number of elements to loop and add the integers together. The total is returned to the caller in manager.asm.
;
;File name: sum.asm
;Language: X86 with Intel syntax.
;Assemble: nasm -f elf64 -l sum.lis -o sum.o sum.asm
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

global sum

segment .data
    ;defining variables

segment .bss
    ;reserved for uninitialized data

segment .text
    ;reserved for executing instructions

sum:
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

;create space for sum
    mov rdx, 0
    mov r8, rdx

;start loop
    mov r13, 0
beginOfLoop:
    cmp r13, r14
    je outOfLoop
    add r8, [r15 + 8*r13]
    inc r13
    jmp beginOfLoop

outOfLoop:
    pop rax
    mov rax, r8
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