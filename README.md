# Project Description
Thumb-2 assembly language programs for a range of applications. Compiled using uVision.

## Task 1
This program calculates the number of occurrences of a specified character in a given string and store the result in register r5. The string is stored from memory location input_string onwards and the character to be found is given in location character_to_find. Program can work for a string of any length and it allows users to change only the values in the data areas and the program will continue to work correctly.

## Task 2
The program includes a memory area containing a number of integer data values. It finds the mode (the most frequently occurring) of the data items and save the result in memory. It can work any number of data items (within memory limits) and user can change the values in the read only data area and the program will continue to work correctly.

## Task 3
This program removes vowels from strings. The subroutine charvowel that accepts a character in register r2 and sets r3 to 1 if the character is a vowel and r3 to 0 otherwise. The subroutine stringvowel that accepts the address of a string in register r1 and modifies that string to remove the vowels. The stringvowel subroutine uses the charvowel subroutine to identify the vowels. 

## Task 4
This program multiplies 4x2 matrix with a 2x4 matrix, resulting in a 4x4 matrix. The program uses single-precision floating point operations throughout and store the resulting matrix in the memory area starting at the label matrix3 in the Task4DataRW area.