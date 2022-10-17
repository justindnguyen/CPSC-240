#!/bin/bash

#Name: Justin Nguyen
#Program Name: Right Triangles
#Purpose: A script file to show system memory location after compiling and assembling and to run the files together.

#Clears any previous compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Compiling C File."
gcc -c -m64 -Wall -no-pie -o pythagoras.o pythagoras.c -std=c17 

echo "Assembling ASM Files."
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Linking the object files."
gcc -m64 -no-pie -o main.out pythagoras.o triangle.o isfloat.o -std=c17 

echo "Running executable."
./main.out

echo "Bash script will terminate."
rm *.o
rm *.lis
rm *.out