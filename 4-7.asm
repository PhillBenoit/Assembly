; Phillip Benoit
; CIS250
; Assignment 2 - Ex7 from pg138
; 4-7.asm - Reverse a string 
; part of: Benoit - CIS250 - Assignment 2.zip

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
WriteChar proto
SetTextColor proto

;data defined by the book
.data
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')


.code
main proc
	mov ecx,LENGTHOF source ;ecx counter gets the length of the source string
	mov esi,0               ;esi starts at 0
	mov edi,ecx
	dec edi					;edi starts at ecx-1 so it can index the last letter of the string
	mov eax, 24h
	call SetTextColor
	
l1:	mov al,source[edi]      ;copies from the end of the source
	call WriteChar			;Uses Irvine libraries to write the character to be coppied to the screen
	mov target[esi],al		;moves to target
	inc esi					;steps up target pointer
	dec edi					;steps down source pointer
	loop l1
	
	mov eax, 0fh
	call SetTextColor
		
	invoke ExitProcess,0
main endp
end main