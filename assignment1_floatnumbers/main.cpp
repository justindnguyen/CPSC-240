/*=====================================================================================================================================
Author: Justin Nguyen
Email: justindnguyen03@csu.fullerton.edu
Institution: California State University, Fullerton
Course: CPSC 240-01-02, MW 1200PM-0150PM, CS104
Start Date: 22 August, 2022

Program Name: Float Comparison
Programming Languages: C++ and X86
Date of Last Update: 31 August, 2022
Date of Reorganization of Comments: 31 August, 2022
Files in this Program: main.cpp, float_checker.asm, isfloat.asm, run.sh
Status: Finished. The program was tested with no errors on WSL Ubuntu 20.04.4 LTS.

Program Description: This program asks the user to input two float numbers and validates if both numbers are real float numbers.
The program will print an error if either number is not a float. Otherwise, the program prints the two numbers and then the prints 
the larger number. After, the program returns the smaller number and ends the program. 

Purpose of this File: Driver file that calls the float_checker function and prints the received output. 

File name: main.cpp
Language: C++
Assemble: g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o main.o main.cpp
Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o main.out main.o isfloat.o float_checker.o

Copyright (C) 2022 Justin Nguyen
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
version 3 as published by the Free Software Foundation.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
======================================================================================================================================*/

#include <iostream>
#include <stdio.h>

using namespace std;

extern "C" double float_check();

int main()
{
	double returned_float = 0.0;
	printf("Welcome to Floating Points Numbers programmed by Justin Nguyen.\n");
	printf("Justin Nguyen has been working for the Longstreet Software Company for the last two years.\n");
	returned_float = float_check();
	printf("The driver module received this float number %lf and will keep it.\n", returned_float);
	printf("The driver module will return integer 0 to the operating system.\nHave a nice day. Good-bye.\n");
	return 0;
}