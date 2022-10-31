/*=====================================================================================================================================
Author: Justin Nguyen
Email: justindnguyen03@csu.fullerton.edu
Institution: California State University, Fullerton
Course: CPSC 240-01-02, MW 1200PM-0150PM, CS104
Start Date: 19 September, 2022

Program Name: Integer Array
Programming Languages: C, C++, X86
Date of Last Update: 26 September, 2022
Date of Reorganization of Comments: 26 September, 2022
Files in this Program: main.c, manager.asm, input_array.asm, sum.asm, display_array.cpp, run.sh
Status: Finished. The program was tested with no errors on WSL Ubuntu 20.04.4 LTS.

Program Description: This program will allow a user to input integers in an array of size 6. The program will input and validate
integers into the array. It will also display the contents, add the integers together, and display the result.

Purpose of this File: Control file that defines the display_array function used in manager.asm. This file takes the user defined
array and its number of elements to loop and print out the contents to the terminal.  

File name: display_array.cpp
Language: C++
Compile: g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o display_array.o display_array.cpp
Link: gcc -m64 -no-pie -o array.out main.o display_array.o manager.o input_array.o sum.o -std=c17 
Run: sh run.sh

Copyright (C) 2022 Justin Nguyen
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
version 3 as published by the Free Software Foundation.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
======================================================================================================================================*/

#include <iostream>

extern "C" void display_array(long arr[], long arr_size);

//Prints the contents of the array, up to arr_size, determined by the fill asm module
void display_array(long arr[], long arr_size) {
  for (int i = 0; i < arr_size; i++)
  {
    printf("%ld\t", arr[i]);
  }
}