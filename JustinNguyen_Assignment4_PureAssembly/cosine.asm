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
;Purpose of this File: Assembly file that defines the cosine function used in manager.asm. This program takes in the the radians
;calculated in the manager file to calculate the the cosine of the inputted degree. Returns the cosine (double) to the caller in
;manager.asm.
;
;File name: cosine.asm
;Language: X86-64 with Intel syntax.
;Assemble: nasm -f elf64 -l cosine.lis -o cosine.o cosine.asm
;Link: ld -o main.out manager.o strlen.o itoa.o atof.o cosine.o ftoa.o degtorad.o
;Run: sh run.sh
;
;Function Prototype: double cosine(double)
;
;Copyright (C) 2022 Justin Nguyen
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
;======================================================================================================================================*/

global cosine

segment .data

segment .bss

segment .text

cosine:
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

;Set values
;double cosine(double)
;User inputed X in the summation
    movsd xmm15, xmm0         

;Current (first) term in the maclaurin series 1.0
    mov rax, 1
    cvtsi2sd xmm14, rax

;fixed -1, 1, 2
    mov rax, -1
    cvtsi2sd xmm13, rax
    mov rax, 1
    cvtsi2sd xmm12, rax
    mov rax, 2
    cvtsi2sd xmm11, rax

;n = 0 iterate to 10 million
    mov r15, 0
    cvtsi2sd xmm10, r15
    mov r14, 10000000

;total sum
    xorpd xmm9, xmm9

beginloop:
    ;compare counter to 10,000,000
    cmp r15, r14
    je done

    ;add current term of the sequence to total
    addsd xmm9, xmm14

    ;2n+1: xmm11(xmm10)+xmm12
    movsd xmm8, xmm11
    mulsd xmm8, xmm10
    addsd xmm8, xmm12

    ;2n+2: xmm11(xmm10)+xmm11
    movsd xmm7, xmm11
    mulsd xmm7, xmm10
    addsd xmm7, xmm11

    ;(2n+1)(2n+2)
    mulsd xmm7, xmm8

    ;X^2
    movsd xmm6, xmm15
    mulsd xmm6, xmm6

    ;(X^2)/((2n+1)(2n+2))
    divsd xmm6, xmm7
    
    ;multiply -1
    mulsd xmm6, xmm13

    ;multiply recurrance relation against current term and set current term to result
    mulsd xmm14, xmm6
    inc r15
    cvtsi2sd xmm10, r15
    jmp beginloop

done:
    ;return result to caller
    movsd xmm0, xmm9

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