#!/bin/bash
#Name: Justin Nguyen
#Program Name: Integer Array
#Purpose: A script file to show system memory location after compiling and assembling and to run the files together.

#Clears any previous compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Compiling C File."
gcc -c -m64 -Wall -no-pie -o main.o main.c -std=c17
gcc -c -m64 -Wall -no-pie -o isinteger.o isinteger.c -std=c17 

echo "Compiling C++ File."
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o display_array.o display_array.cpp
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o array_count.o array_count.cpp

echo "Assembling ASM Files."
nasm -f elf64 -l manager.lis -o manager.o manager.asm
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
nasm -f elf64 -l sum.lis -o sum.o sum.asm
nasm -f elf64 -l atol.lis -o atol.o atol.asm

echo "Linking the object files."
g++ -m64 -no-pie -o array.out main.o display_array.o manager.o input_array.o sum.o atol.o isinteger.o array_count.o -std=c++17 

echo "Running executable."
./array.out

echo "Bash script will terminate."
rm *.o
rm *.lis
rm *.out