/*=====================================================================================================================================
Author: Justin Nguyen
Email: justindnguyen03@csu.fullerton.edu
Institution: California State University, Fullerton
Course: CPSC 240-01-02, MW 1200PM-0150PM, CS104
Start Date: 4 September, 2022

Program Name: Right Triangles
Programming Languages: C and X86
Date of Last Update: 17 September, 2022
Date of Reorganization of Comments: 17 September, 2022
Files in this Program: pythagoras.c, triangle.asm, isfloat.asm, run.sh, gdb.sh
Status: Finished. The program was tested with no errors on WSL Ubuntu 20.04.4 LTS.

Program Description: This program asks the user to input the lengths of two sides of a right triangle and will compute the hypotenuse and area.
The program will also validate inputs to exclude zeroes and negative numbers. 

Purpose of this File: Driver file that calls the right_triangle function and prints the received output. 

File name: pythagoras.c
Language: C
Compile: gcc -c -m64 -Wall -no-pie -o pythagoras.o pythagoras.c -std=c17 
Link: gcc -m64 -no-pie -o main.out pythagoras.o triangle.o isfloat.o -std=c17
Run: sh run.sh

Copyright (C) 2022 Justin Nguyen
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
version 3 as published by the Free Software Foundation.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
======================================================================================================================================*/

#include <stdio.h>

extern double right_triangle();

int main()
{
	double hypotenuse = 0.0;
	printf("Welcome to the Right Triangles program maintained by Justin Nguyen.\n");
	printf("If errors are discovered, please report them to Justin Nguyen at justindnguyen03@csu.fullerton.edu for a quick fix. At CSUF, the customer comes first.\n");
	hypotenuse = right_triangle();
	printf("The main function received the number %lf and plans to keep it.\n", hypotenuse);
	printf("An integer zero will be returned to the operating system. Bye.\n");
	return 0;
}