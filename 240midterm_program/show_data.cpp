/*Author: Justin Nguyen
Email: justindnguyen03@csu.fullerton.edu
Date: October 12, 2022
Section ID: Section 1 MW 12:00PM-01:50PM*/

#include <iostream>

extern "C" void show_data(double arr[], long arr_size);

void show_data(double arr[], long arr_size) {
    for (int i = 0; i < arr_size; i++)
    {
        printf("%lf\n", arr[i]);
    }
    printf("\n");
}