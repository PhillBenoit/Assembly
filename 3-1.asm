; Phillip Benoit
; CIS250
; Assignment 1 - Ex1 from pg94
; 3-1.asm - program to prefom the algorithm: A = (A+B) - (C-D)
; part of: Benoit - CIS250 - Assignment 1.zip

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main proc
	mov	eax,5
	mov ebx,4
	mov ecx,3
	mov edx,2
	add eax,ebx
	add ecx,edx
	sub eax,ecx
	
	invoke ExitProcess,0
main endp
end main