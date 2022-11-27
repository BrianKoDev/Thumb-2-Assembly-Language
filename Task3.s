  ; Task 3 - Remove vowel from strings
  ; This program reads from the memory a string, remove vowels in it then writes
  ; the results in a memory location.
  ; The length of input string must be within memory limits.
  ; This program is capable to remove vowels both in capitals and lowercase.
  
  ; Set up the exception addresses
  THUMB
  AREA RESET, CODE, READONLY
  EXPORT  __Vectors
  EXPORT Reset_Handler
__Vectors 
  DCD 0x20001000     ; Top of the stack 
  DCD Reset_Handler  ; Reset vector - where the program starts

  AREA Task3Code, CODE, READONLY ; Task 3 - Remove vowel from strings
  ENTRY
Reset_Handler

  LDR r1,=input_string  ; Load input string address
  LDR r5,=output_string ; Load output string address

  ;Subroutine to search through a string for non-vowels and store result in memory location
  ;Register Used: r1,r2,r3,r5,LR
  ;Reguster Modified: r1,r2,r5,LR
  ;Memory Locations accessed: input_string
  ;Memory Locations modified: output_string
stringvowel
  LDRB r2,[r1],#1   ; Load one character from string
  BL charvowel		; Call subroutine to check if character is a vowel
  CMP r3,#0 		; Check if the character is a vowel
  IT EQ
  STREQ r2,[r5],#1  ; Write to memory if character is non vowel
  CMP r2,#0 		; Check if end of data set is reached
  BNE stringvowel	; Check next character in string
  
terminate
  B terminate	; Terminate by an endless loop

  ;Subroutine to check if a character is a vowel
  ;Register Used: r2,r3,LR
  ;Reguster Modified: r3,LR
  ;Memory Locations accessed: N/A
  ;Memory Locations modified: N/A
charvowel
  MOV r3,#1		; Reset vowel flag
  CMP r2, #0x41 ; Check if character is A
  BXEQ LR       ; Branch if vowel is found
  CMP r2, #0x45 ; Check if character is E
  BXEQ LR		; Branch if vowel is found
  CMP r2, #0x49 ; Check if character is I
  BXEQ LR		; Branch if vowel is found
  CMP r2, #0x4f ; Check if character is O
  BXEQ LR		; Branch if vowel is found
  CMP r2, #0x55 ; Check if character is U
  BXEQ LR		; Branch if vowel is found
  CMP r2, #0x61 ; Check if character is a
  BXEQ LR		; Branch if vowel is found
  CMP r2, #0x65 ; Check if character is e
  BXEQ LR		; Branch if vowel is found
  CMP r2, #0x69 ; Check if character is i
  BXEQ LR		; Branch if vowel is found
  CMP r2, #0x6f ; Check if character is o
  BXEQ LR		; Branch if vowel is found
  CMP r2, #0x75 ; Check if character is u
  BXEQ LR		; Branch if vowel is found
  MOV r3,#0		; Set vowel flag to 0 if not found
  BX LR			; Jump back to subroutine stringvowel
  
  ; Data area that cannot be modified (it is in the readonly section)
  AREA Task3DataRO, DATA, READONLY;
input_string
  DCB "Input String",0; String to processed
  
  ; Data area that can be modified (it is in the read/write section)  
  AREA Task3DataRW, DATA, READWRITE
output_string
  DCB "",0; Store Result (String with vowels removed)
  END