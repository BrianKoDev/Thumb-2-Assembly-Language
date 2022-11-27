  ; Task 1 - Counting Characters
  ; This program calculates the number of occurences of a
  ; single character in a given string and stores results in register r5
  ; String is stored in memory location input_string
  ; Character to be found is given in location character_to_find
  ; Input string must be within memory limits.

  ; Set up the exception addresses
  THUMB
  AREA RESET, CODE, READONLY
  EXPORT  __Vectors
  EXPORT Reset_Handler
__Vectors 
  DCD 0x20001000     ; Top of the stack 
  DCD Reset_Handler  ; Reset vector - where the program starts

  AREA Task1_Code, CODE, READONLY ; Task 1 - Counting Characters
  ENTRY
Reset_Handler	
  MOV r5, #0				; Initialize registor to store result
  LDR r3,=character_to_find ; Load address of character to register
  LDRB r1,[r3] 				; Load ASCII character to register
  LDR r4,=input_string  	; Load address of the input string

  ; Subroutine to search through the string and record number of occurences
  ; Register Used: r1,r2,r4,r5
  ; Reguster Modified: r2,r4,r5
  ; Memory Locations accessed: input_string

loop
  LDRB r2,[r4],#1  ; Load the first character of string to register and increment registor to the address of next character
  CMP r2,r1		   ; Check if the characters match
  IT EQ
  ADDEQ r5,r5,#1   ; Increment result counter if chracters match
  CMP r2,#0		   ; Check if it is the end of string
  BNE loop		   ; Terminate program if it is the end of string

terminate
  B terminate	   ; Terminate by an endless loop
 
input_string
  DCB "she sells sea shells",0 ; String to be searched

character_to_find
  DCB "s" ; Find the number of occurrences of this character  
  END
	  
