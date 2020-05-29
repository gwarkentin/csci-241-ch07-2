# csci-241-ch07-2
Subtraction_with_Packed_BCD

Write a procedure named PackedBcdSub that performs an operation of subtraction with two Packed_BCD's in 32-bit, like EAX-EBX and returns its Packed BCD difference. The specification is
;-----------------------------------------------------------------
PackedBcdSub PROC uses EAX EBX
;
; Performs operation EAX-EBX Packed BCD to return the difference
; Receives: EAX, First number, Minuend, to be subtracted from
;           EBX, Second number, Subtrahend, to be subtracted
; Returns:  EDX, Result, the difference
;           CF=1, if need a borrow, else CF=0
;----------------------------------------------------------------
Where you can set a loop to do subtraction in AL BYTE by BYTE. In PackedBcdSub, about 10 instructions should be enough. Mainly in the loop body:
Use either SBB or SUB just once with DAS
Rotate or shift a byte in registers
May PUSHFD/POPFD for CF, but not very necessary
To understand DAS and SBB is necessary with CF working together. You can refer to the textbook samples, AddPacked and Extended_Add to get some idea. The caller in main should perform input and output in such a way:
main07PackedBcdSub PROC
; Show program title
	...

; Input the Minuend by reading hexadecimal 
	...

; Input the Subtrahend by reading hexadecimal 
	...

; Call PackedBcdSub for EAX-EBX with result in EDX
	...

; Check CF to show a borrow if necessary
	...

; Output by writing hexadecimal    
	...
main07PackedBcdSub ENDP
You can implement all logic with registers only without memory and PUSH/POP. Now when run ch07_PackedBcdSub.exe, the result can be like this
Packed BCD Subtraction of Unsigned Integers
Enter your Minuend (up to 8 digits): 55553333
And the Subtrahend (up to 8 digits): 12345678

55553333 - 12345678 = 43207655
But if a borrow needed, the output should be like this
Packed BCD Subtraction of Unsigned Integers
Enter your Minuend (up to 8 digits): 100
And the Subtrahend (up to 8 digits): 5000

1:00000100 - 00005000 = 99995100
Advanced discussion (not required): Since purpose of this is to practice Packed BCD instructions, you can simply make use of ReadHex where we suppose that only 8 digits entered by testing without error checking of any non-decimal-digit. For a real world application, you do need to check the user input, where creating a PROC IsPackedBCD is quite necessary.
