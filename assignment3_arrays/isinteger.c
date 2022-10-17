//***************************************************************************************************************************
//Program name: "Validate String Integer".  This program demonstrates how to determine if data stored in an array of char   *
//form in fact a valid integer or not.  Copyright (C) 2020 Floyd Holliday                                                   *
//                                                                                                                          *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU Library General Public *
//License (LGPL) version 3 as published by the Free Software Foundation.                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                           *
//***************************************************************************************************************************




//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu
//
//Program information
//  Program name: Validate String Integer
//  Programming languages: C
//  Date program began: 2021-Sep-2
//  Date of last update: 2021-Sep-2
//  Comments reorganized: 2021-Sep-3
//  Files in the program: validate-integers.c, isinteger.c, r.sh
//
//Purpose
//  Show a technique for detecting if data in an array of chars constitute a valid integer.
//
//This file
//  File name: isinteger.c
//  Function name: integer
//  Language: C
//  Max page width: 125 columnsr
//  Compile: gcc -c -m64 -Wall -fno-pie -no-pie -o integ.o isinteger.c -std=c17



#include "ctype.h"
//Prototype of function used in this software:  
//      int isdigit(int);

int isinteger(char w[]);   //<== Prototype

int isinteger(char w[])    //Begin function body
{int result = 1; //1 represents 'true'. 
 //Assume this function will return 1 (true) until proven otherwise.
 int index = 0;
 if (w[0] == '-' || w[0] == '+') index = 1;
 while( !(w[index]=='\0') && result )
     {result = result && isdigit(w[index]);
      index++;
     }
 return result;
}//End of isinteger

//Notice that isinteger is independant of any specific integer size.  The function isinteger
//is not concerned with the conversion of the input string to any specific size of integer
//variable.


