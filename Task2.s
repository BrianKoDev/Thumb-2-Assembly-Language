  ; Task 2 - Find the mode
  ; This program finds the mode of data items and saves the result in memory.
  ; Any number of data items could be used within memory limits.
  ; If there is more than one mode, only 2 will be recorded into the memory location. 
  ; Set up the exception addresses
  THUMB
  AREA RESET, CODE, READONLY
  EXPORT  __Vectors
  EXPORT Reset_Handler
__Vectors 
  DCD 0x20001000     ; top of the stack 
  DCD Reset_Handler  ; reset vector - where the program starts
	  
  AREA Task2_Code, CODE, READONLY  ; Task 2 - Find the mode
  ENTRY
Reset_Handler	
  LDR r1,=data_values_start ; Load the starting memory location of data values
  LDR r2,=data_values_end	; Load the ending memory location of data values
  LDR r3,=result ;          ; Load the memory location of the result
  MOV r4,#0 				; Initialize maximum occurance count of a number
  MOV r9,#0 				; Initialize registor to store mode 1
  MOV r10,#0 				; Initialize registor to store mode 2 (if applicable)
  ;Subroutine to search through each of the data values
  ;Register Used: r1,r5,r6,r8
  ;Reguster Modified: r1,r5,r6,r8
  ;Memory Locations accessed: data_values_start
outer_loop
  LDR r5,=data_values_start ; Reset to beginning of data set after seaching through the data set
  MOV r8,#0					; Reset current count after seaching through the data set
  LDR r6,[r1],#4			; Load number to be compared in the inner loop, then increment address to next number
  
  ;Subroutine to count number of occurances of a data value and store result in memory location
  ;Register Used: r1,r2,r3,r4,r5,r6,r7,r8,r9,r10
  ;Reguster Modified: r4,r5,r7,r8,r9,r10
  ;Memory Locations accessed: data_values_start
  ;Memory Locations modified: result
inner_loop
  LDR r7,[r5],#4			; Load other number to be compared, then increment address to next number
  CMP r7,r6					; Compare Numbers
  IT EQ
  ADDEQ r8,r8,#1 			; Increment current counter if equal
  CMP r5,r2					; Check if we have reached the end of the data set
  BNE inner_loop			; Jump to inner loop if not at the end of data set
  CMP r8,r4					; Check if current count is higher than or equal to maximum occurance
  IT EQ
  MOVEQ r10,r6 				; Update second mode
  ITT GT
  MOVGT r4,r8 				; Update highest count
  MOVGT r9,r6 				; Update highest number
  MOVGT r10,#0 				; Reset second mode num
  CMP r1,r2					; Check if searched through all data items
  BNE outer_loop			; Exit loop if all data items has been searched
  CMP r9,r10				; Check if mode is same
  IT NE
  STRNE r10,[r3],#4			; Store result in memory location
  STR r9,[r3],#4			; Store result in memory location
  
  
terminate
  B terminate	; Terminate by an endless loop
  
  ALIGN
  ; data area that cannot be modified (it is in the readonly section)
  AREA Task2DataRO, DATA, READONLY 
data_values_start
  DCD 45,-18,64,-23,-3,0,12,45,64,-3,64 ; Data Values to be read
data_values_end	  

  ; data area that can be modified (it is in the read/write section)
  AREA Task2DataRW, DATA, READWRITE
result
  DCD 0 ; Store result (mode)
  END