#!/bin/bash
#Name: Justin Nguyen
#Program Name: Pure Assembly with Cosine
#Purpose: A script file to show system memory location after compiling and assembling and to run the files together.

#Clears any previous compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Assembling ASM Files."
nasm -f elf64 -l manager.lis -o manager.o manager.asm
nasm -f elf64 -l strlen.lis -o strlen.o strlen.asm
nasm -f elf64 -l itoa.lis -o itoa.o itoa.asm
nasm -f elf64 -l atof.lis -o atof.o atof.asm
nasm -f elf64 -l cosine.lis -o cosine.o cosine.asm
nasm -f elf64 -l ftoa.lis -o ftoa.o ftoa.asm
nasm -f elf64 -l degtorad.lis -o degtorad.o degtorad.asm

echo "Linking the object files."
ld -o main.out manager.o strlen.o itoa.o atof.o cosine.o ftoa.o degtorad.o

echo "Running executable."
./main.out

echo "Bash script will terminate."
rm *.o
rm *.lis
rm *.out