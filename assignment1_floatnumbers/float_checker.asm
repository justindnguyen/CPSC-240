;/*=====================================================================================================================================
;Author: Justin Nguyen
;Email: justindnguyen03@csu.fullerton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-01-02, MW 1200PM-0150PM, CS104
;Start Date: 22 August, 2022
;
;Program Name: Float Comparison
;Programming Languages: C++ and X86
;Date of Last Update: 31 August, 2022
;Date of Reorganization of Comments:  31 August, 2022
;Files in this Program: main.cpp, float_checker.asm, isfloat.asm, run.sh
;Status: Finished. The program was tested with no errors on WSL Ubuntu 20.04.4 LTS. 
;
;Program Description: This program asks the user to input two float numbers and validates if both numbers are real float numbers.
;The program will print an error if either number is not a float. Otherwise, the program prints the two numbers and 
;then the prints the larger number. After, the program returns the smaller number and ends the program.
;
;Purpose of this File: Assembly file that defines the float_checker function used in the driver main.cpp.
;
;File name: float_checker.asm
;Language: X86 with Intel syntax.
;Assemble: nasm -f elf64 -l float_checker.lis -o float_checker.o float_checker.asm
;Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o main.out main.o isfloat.o float_checker.o
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
extern isfloat
extern atof

global float_check

segment .data
    ;defining variables
    input_message db 0ah, "Please enter two float numbers separated by white space. Press enter after the second input.", 0ah, 0ah, 0
    output_message1 db 0ah, "These numbers were entered:", 0ah, 0ah, 0
    invalid_input db 0ah, "An invalid input was detected. You may run this program again.", 0ah, 0ah, 0
    output_message2 db 0ah, 0ah, "The larger number is %1.15lf.", 0ah, 0
    goodbye_message1 db 0ah, "The assembly module will now return execution to the driver module.", 0ah, 0
    goodbye_message2 db "The smaller number will be returned to the driver.", 0ah, 0ah, 0
    string_format db "%s", 0
    float_format db "%1.15lf", 0ah, "%1.15lf", 0
    double_string_format db "%s%s", 0

    one dq 1.0

segment .bss
    ;reserved for uninitialized data

segment .text
    ;reserved for executing instructions

float_check:
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

;prompt user for input
    push qword 0
    mov rax, 0
    ;moves register to string format (%s)
    mov rdi, string_format
    mov rsi, input_message
    call printf
    pop rax

;input 2 floats from user
    push qword 0
    sub rsp, 2048
    mov rax, 0
    ;move double string format into first parameter register (%s%s)
    mov rdi, double_string_format
    ;second arg register points to top of stack (first float)
    mov rsi, rsp    
    mov rdx, rsp
    ;rdx points to second qword (second float)
    add rdx, 1024
    ;scanf("%s%s", rsp, rsp + 1024)
    call scanf

;call isfloat to check if inputs are floats
    mov rax, 0
    ;rdi points to first qword (first float)
    mov rdi, rsp
    call isfloat
    ;result is in rax and compare rax to 0 (false)
    cmp rax, 0 
    ;if false, jump to error 
    je error
;call isfloat for second input
    mov rax, 0
    mov rdi, rsp
    ;rdi points to second qword (second float) 
    add rdi, 1024
    call isfloat
    cmp rax, 0
    ;if false, jump to error
    je error

;convert inputs into real floats and store them in xmm registers
    mov rdi, rsp
    ;converts first input into float
    call atof
    ;save inputted number in xmm registers
    movsd xmm14, xmm0  
;converts second input into float
    mov rdi, rsp
    add rdi, 1024
    call atof
    movsd xmm15, xmm0
    pop rax
    
;output user information
    push qword 0
    mov rax, 0
    ;moves register to string format (%s)
    mov rdi, string_format
    mov rsi, output_message1
    call printf
    pop rax

    push qword 0
    ;makes space to input floats into float format (%lf 0ah %lf)
    mov rax, 2
    mov rdi, float_format
    ;move first float into the first position and second float into second position
    movsd xmm0, xmm14
    movsd xmm1, xmm15
    call printf
    pop rax
    
;compare two inputs and print larger number
    mov rax, 0
    ;moves first input to xmm0
    movsd xmm0, xmm14
    ;compares first input to second input
    ucomisd xmm0, xmm15
    ;jump to endprogram1 if first input is larger
    ja endprogram1
    ;else jump to endprogram 2
    jmp endprogram2

error:
    ;output error message
    pop rdi
    mov rax, 0
    ;moves register to string format (%s)
    mov rdi, string_format
    mov rsi, invalid_input
    call printf
    pop rax

    ;return -1.0000000
    push qword 0
    ;move stack pointer to xmm0 (0.0)
    movsd xmm0, [rsp]
    ;subtract 1.0 from xmm0
    subsd xmm0, [one]
    pop rax

    ;restore original values to integer registers
    jmp restore_gpr_reg

;returns the second inputted number (smaller)
endprogram1:
    ;prints larger number (1st input)
    push qword 0
    ;makes space to input float into float format ("The larger number is %lf.")
    mov rax, 1
    mov rdi, output_message2
    movsd xmm0, xmm14
    call printf
    pop rax

    ;print statements that assembly file is ending and returning to driver file
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, goodbye_message1
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, goodbye_message2
    call printf
    pop rax

    ;moves xmm15 (smaller number) to be returned
    movsd xmm0, xmm15
    pop rax

    ;restore original values to integer registers
    jmp restore_gpr_reg

;returns the first inputted number (smaller)
endprogram2:
    ;prints larger number(2nd input)
    push qword 0
    ;makes space to input float into float format ("The larger number is %lf.")
    mov rax, 1
    mov rdi, output_message2
    movsd xmm0, xmm15
    call printf
    pop rax
    
    ;print statements that assembly file is ending and returning to driver file
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, goodbye_message1
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, goodbye_message2
    call printf
    pop rax

    ;moves xmm14 (smaller number) to be returned
    movsd xmm0, xmm14
    pop rax

    ;restore original values to integer registers
    jmp restore_gpr_reg

;restores original values to gpr registers
restore_gpr_reg:
    ;counter the space made at the beginning of the program for 2 strings
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