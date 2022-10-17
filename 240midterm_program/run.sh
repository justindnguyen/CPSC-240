#!/bin/bash

#Author: Justin Nguyen
#Email: justindnguyen03@csu.fullerton.edu
#Date: October 12, 2022
#Section ID: Section 1 MW 12:00PM-01:50PM

rm *.o
rm *.lis
rm *.out

echo "Compiling C++ File."
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o driver.o driver.cpp
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o show_data.o show_data.cpp

echo "Assembling ASM Files."
nasm -f elf64 -l manager.lis -o manager.o manager.asm
nasm -f elf64 -l get_data.lis -o get_data.o get_data.asm
nasm -f elf64 -l max.lis -o max.o max.asm
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Linking the object files."
g++ -m64 -no-pie -o main.out driver.o show_data.o manager.o get_data.o max.o isfloat.o -std=c++17 

echo "Running executable."
./main.out

echo "Bash script will terminate."
rm *.o
rm *.lis
rm *.out