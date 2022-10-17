/*Author: Justin Nguyen
Email: justindnguyen03@csu.fullerton.edu
Date: October 12, 2022
Section ID: Section 1 MW 12:00PM-01:50PM*/

#include <iostream>

extern "C" char * manager();

int main()
{
    printf("Welcome to Maximum authored by Justin Nguyen.\n");
    char * output = manager();
    printf("Thank you for using this software, %s.\n", output);
    printf("Bye.\n");
    printf("A zero was returned to the operating system.\n");
	return 0;
}