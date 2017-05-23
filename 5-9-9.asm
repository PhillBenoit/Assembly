; Phillip Benoit
; CIS250
; Assignment 3 - Ex9 from pg188
; 5-9-9.asm - program to deomstrate limited recursion
; part of: Benoit - CIS250 - Assignment 3.zip

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
WriteDec proto
WaitMsg proto
WriteString proto
Crlf proto

.data
;messages used in the program
recursiveMsg byte "   Recursive call count: ",0
totalMsg     byte "Total times through recursive loop: ",0

;number of recursive calls to make
recuesiveCalls dword 3

.code
main proc
	mov  ecx,recuesiveCalls ;move number of calls to the looping register
	mov  eax,0 ;counter for the recursive loop
	call recursion ;calls the function
	
	mov  edx,OFFSET totalMsg ;moves the start of the message string to edx
	call WriteLine ;prints total message
	call WaitMsg ;pauses the program
	invoke ExitProcess,0
main endp

recursion proc
    inc eax ;increment counter each time
	mov  edx,OFFSET recursiveMsg ;moves the start of the message string to edx
	call WriteLine ;prints a message each time through the loop
	loop l1 ;calls ahead to the label below and decrements ecx
    ret
l1:	call recursion ;calls itself to start the process over
	ret
recursion endp

WriteLine proc
	call WriteString ;writes characters starting with edx to the screen (stops with \0)
	call WriteDec ;writes eax to the screen
	call Crlf ;writes a carrage return and line feed to the screen
	ret
WriteLine endp

end main