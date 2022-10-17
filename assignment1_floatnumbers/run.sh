#!/bin/bash

#Name: Justin Nguyen
#Program Name: Float Comparison
#Purpose: A script file to show system memory location after compiling and assembling and to run the files together.

#Clears any previous compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Compiling CPP File"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o main.o main.cpp

echo "Assembling ASM Files"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm
nasm -f elf64 -l float_checker.lis -o float_checker.o float_checker.asm

echo "Linking the object files"
g++ -m64 -std=c++17 -fno-pie -no-pie -o main.out main.o isfloat.o float_checker.o

echo "Running executable"
./main.out

echo "Bash script will terminate"
rm *.o
rm *.lis
rm *.out