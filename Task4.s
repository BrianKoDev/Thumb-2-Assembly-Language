  ; Task 4 - Floating point multiplication
  ; This program performs the multiplication of a 4x2 matrix with a 2x4 matrix using VFP.
  ; The matrix being calculated is stored in the data area and so is the result.
  ; The program requires input data to be signed integer.
  ; The progam outputs data as a float using IEEE 754 format
  
  ; Set up the exception addresses
  THUMB
  AREA RESET, CODE, READONLY
  EXPORT  __Vectors
  EXPORT Reset_Handler
__Vectors 
  DCD 0x20001000     ; Top of the stack 
  DCD Reset_Handler  ; Reset vector - where the program starts

  AREA Task4Code, CODE, READONLY ; Task 4 - Floating point multiplication
  ENTRY
Reset_Handler

copro_setup
  LDR.W r0, = 0xE000ED88 	; Address of co-processor register
  LDR r1, [r0]  		 	; Read CPACR - the co-processor register
  ORR r1, r1, #(0xF << 20)  ; Bits 20-23 to enable CP10 and CP11 coprocessors
  STR r1, [r0]  			; Write back updated value to CPACR
  DSB   					; Wait for transfer to complete

  ;Subroutine to load data in memory location to VFP registers
  ;Register Used: r2,r3,r4,s0-s15
  ;Reguster Modified: r2,r3,r4,s0-s15
  ;Memory Locations accessed: matrix1, matrix2, matrix3
  ;Memory Locations modified: N/A  
load
  LDR r2,=matrix1   ; Get the location of the start the first matrix
  LDR r3,=matrix2   ; Get the location of the start of the second matrix
  LDR r4,=matrix3   ; Get the location of the start of the results matrix
  VLDMFD.F r2!,{s0-s7}  ; Load data of first matrix
  VLDMFD.F r3!,{s8-s15} ; Load data of second matrix
  
  ;Subroutine to convert all integers to IEEE 754 format
  ;Register Used: s1-s15
  ;Reguster Modified: s0-s15
  ;Memory Locations accessed: N/A
  ;Memory Locations modified: N/A  
convert
  VCVT.F32.S32 s0,s0	;Convert signed integer to float
  VCVT.F32.S32 s1,s1	;Convert signed integer to float
  VCVT.F32.S32 s2,s2	;Convert signed integer to float
  VCVT.F32.S32 s3,s3	;Convert signed integer to float
  VCVT.F32.S32 s4,s4	;Convert signed integer to float
  VCVT.F32.S32 s5,s5	;Convert signed integer to float
  VCVT.F32.S32 s6,s6	;Convert signed integer to float
  VCVT.F32.S32 s7,s7	;Convert signed integer to float
  VCVT.F32.S32 s8,s8	;Convert signed integer to float
  VCVT.F32.S32 s9,s9	;Convert signed integer to float
  VCVT.F32.S32 s10,s10	;Convert signed integer to float
  VCVT.F32.S32 s11,s11	;Convert signed integer to float
  VCVT.F32.S32 s12,s12	;Convert signed integer to float
  VCVT.F32.S32 s13,s13 	;Convert signed integer to float
  VCVT.F32.S32 s14,s14	;Convert signed integer to float
  VCVT.F32.S32 s15,s15	;Convert signed integer to float
  
  ;Subroutine to peform matrix multiplication
  ;Register Used: s16-s31
  ;Reguster Modified: s16-s31
  ;Memory Locations accessed: N/A
  ;Memory Locations modified: N/A  
mutiply_add  
  VMUL.F s16,s0,s8	; Mutiply matrix1 element 1,1 with matrix2 element 1,1
  VMLA.F s16,s1,s12 ; Mutiply matrix1 element 1,2 with matrix2 element 2,1 and add previous value
  
  VMUL.F s17,s0,s9  ; Mutiply matrix1 element 1,1 with matrix2 element 1,2
  VMLA.F s17,s1,s13 ; Mutiply matrix1 element 1,2 with matrix2 element 2,2 and add previous value
  
  VMUL.F s18,s0,s10 ; Mutiply matrix1 element 1,1 with matrix2 element 1,3
  VMLA.F s18,s1,s14 ; Mutiply matrix1 element 1,2 with matrix2 element 2,3 and add previous value
  
  VMUL.F s19,s0,s11 ; Mutiply matrix1 element 1,1 with matrix2 element 1,4
  VMLA.F s19,s1,s15 ; Mutiply matrix1 element 1,2 with matrix2 element 2,4 and add previous value
  
  VMUL.F s20,s2,s8  ; Mutiply matrix1 element 2,1 with matrix2 element 1,1
  VMLA.F s20,s3,s12 ; Mutiply matrix1 element 2,2 with matrix2 element 2,1 and add previous value
  
  VMUL.F s21,s2,s9  ; Mutiply matrix1 element 2,1 with matrix2 element 1,2
  VMLA.F s21,s3,s13 ; Mutiply matrix1 element 2,2 with matrix2 element 2,2 and add previous value
  
  VMUL.F s22,s2,s10 ; Mutiply matrix1 element 2,1 with matrix2 element 1,3 
  VMLA.F s22,s3,s14 ; Mutiply matrix1 element 2,2 with matrix2 element 2,3 and add previous value
  
  VMUL.F s23,s2,s11 ; Mutiply matrix1 element 2,1 with matrix2 element 1,4 
  VMLA.F s23,s3,s15 ; Mutiply matrix1 element 2,2 with matrix2 element 2,4 and add previous value
  
  VMUL.F s24,s4,s8  ; Mutiply matrix1 element 3,1 with matrix2 element 1,1
  VMLA.F s24,s5,s12 ; Mutiply matrix1 element 3,2 with matrix2 element 2,1 and add previous value
  
  VMUL.F s25,s4,s9  ; Mutiply matrix1 element 3,1 with matrix2 element 1,2
  VMLA.F s25,s5,s13 ; Mutiply matrix1 element 3,2 with matrix2 element 2,2 and add previous value
  
  VMUL.F s26,s4,s10 ; Mutiply matrix1 element 3,1 with matrix2 element 1,3
  VMLA.F s26,s5,s14 ; Mutiply matrix1 element 3,2 with matrix2 element 2,3 and add previous value
  
  VMUL.F s27,s4,s11 ; Mutiply matrix1 element 3,1 with matrix2 element 1,4
  VMLA.F s27,s5,s15 ; Mutiply matrix1 element 3,2 with matrix2 element 2,4 and add previous value
  
  VMUL.F s28,s6,s8  ; Mutiply matrix1 element 1,1 with matrix2 element 1,1
  VMLA.F s28,s7,s12 ; Mutiply matrix1 element 4,2 with matrix2 element 2,1 and add previous value
  
  VMUL.F s29,s6,s9  ; Mutiply matrix1 element 1,1 with matrix2 element 1,2
  VMLA.F s29,s7,s13 ; Mutiply matrix1 element 4,2 with matrix2 element 2,2 and add previous value
  
  VMUL.F s30,s6,s10 ; Mutiply matrix1 element 1,1 with matrix2 element 1,3
  VMLA.F s30,s7,s14 ; Mutiply matrix1 element 4,2 with matrix2 element 2,3 and add previous value
  
  VMUL.F s31,s6,s11 ; Mutiply matrix1 element 1,1 with matrix2 element 1,4
  VMLA.F s31,s7,s15 ; Mutiply matrix1 element 4,2 with matrix2 element 2,4 and add previous value
  
  ;Subroutine to save result in IEEE 754 format to memory
  ;Register Used: s16-s31,r4
  ;Reguster Modified: N/A
  ;Memory Locations accessed: matrix3
  ;Memory Locations modified: matrix3   
saveresult
  VSTM.F r4!,{s16-s31}

terminate
  B terminate	; Terminate by an endless loop

  ; Data area that cannot be modified (it is in the readonly section)
  ALIGN
  AREA Task4DataRO, DATA, READONLY ; Matrix data
matrix1
  DCD 3,4,5,4,3,2,5,6 ; 4x2 Matrix to be multiplied
matrix2
  DCD 3,4,5,6,7,8,9,1 ; 2x4 Matrix to be multiplied
	  
  ; Data area that can be modified (it is in the read/write section)  	  
  AREA Task4DataRW, DATA, READWRITE ; Results data
matrix3
  SPACE 16*4 ; Stores result
  END