; Program: Subtraction_with_Packed_BCD (Chapter 7)
; Description: Subtracts two Packed BCDs in 32 bit
; Student:     Gabriel Warkentin
; Date:        03/26/2020
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
msg1 BYTE "Packed BCD Subtraction of Unsigned Integers",0dh, 0ah
	 BYTE "Enter the Minuend (up to 8 digits): ",0
msg2 BYTE "Enter Subtrahend  (up to 8 digits): ",0
msg3 BYTE "1:",0
msg4 BYTE " - ",0
msg5 BYTE " = ",0

.code
main11 PROC
	mov edx, OFFSET msg1
	call WriteString
	call ReadHex
	mov ecx, eax

	mov edx, OFFSET msg2
	call WriteString
	call ReadHex
	mov ebx, eax				; I think this is faster than xchg
	mov eax, ecx				; since we have spare registers

	call PackedBcdSub

	mov ecx, edx				; save edx first, easier to write strings than several WriteChar
	jnc L1
	mov edx, OFFSET msg3
	call WriteString
L1:
	call WriteHex				; eax has minuend already

	mov edx, OFFSET msg4
	call WriteString

	mov eax, ebx
	call WriteHex

	mov edx, OFFSET msg5
	call WriteString

	mov eax, ecx				; retrieve result
	call WriteHex

	call CrLf
	exit
main11 ENDP

;-----------------------------------------------------------------
PackedBcdSub PROC uses EAX EBX
;
; Performs operation EAX-EBX Packed BCD to return the difference
; Receives: EAX, First number, Minuend, to be subtracted from
;           EBX, Second number, Subtrahend, to be subtracted
; Returns:  EDX, Result, the difference
;           CF=1, if need a borrow, else CF=0
;----------------------------------------------------------------
	;mov edx, 0					; just so you can see it fill edx clearly

	mov ecx, 32 / 8				; not certain why I didn't just use 4
	clc
L1:
	sbb al, bl
	das							; das considers carry so this has to happen first
	rcr bl, 1					; save carry in highest bit in last byte
	mov dl, al
	ror edx, 8
	shr eax, 8
	shr ebx, 8					; retrieve carry and move to next byte

	dec ecx						; faster than loop
	jnz L1

	ret
PackedBcdSub ENDP

END ;main11