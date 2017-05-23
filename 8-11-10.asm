; Phillip Benoit
; CIS250
; Assignment 6 - Ex10 from pg350
; 8-11-10.asm - Show the parameters of a method that called it
; part of: Benoit - CIS250 - Assignment 6.zip

INCLUDE Irvine32.inc

MySample proto, first:dword, second:dword, third:dword
ShowParams proto, paramCount:dword

;strings to make output menu
.data
sTitle     byte  "Stack Parameters",0
sSeparator byte  "---------------------------",0
sAddress   byte  "Address ",0
sEquals    byte  " = ",0

.code
main proc
	;call from book as per assignment
	invoke MySample, 1234h, 5000h, 6543h

	call WaitMsg
	exit
main endp

MySample proc, first:dword, second:dword, third:dword
	;call from book as per assignment
	invoke ShowParams, 3
	ret
MySample endp

ShowParams proc, paramCount:dword
	;loads count in to ecx for looping
	mov ecx,paramCount
	
	;Title line
	mov	edx,OFFSET sTitle
	call WriteString
	call Crlf

	;Top separator line
	mov	edx,OFFSET sSeparator
	call WriteString
	call Crlf

	;moves stack pointer to esi
	mov esi,esp 

	;adds 20 to start at first paramater
	add esi,20  

AddressLoop:
	;loads paramater address in to eax
	mov eax,esi
	
	;loads value of address in to ebx
	mov ebx,[esi]
	
	;calls method to print the line of data
	call DisplayLine
	
	;increases esi to next paramater
	add esi,4
	loop AddressLoop

	;bottom separator line
	mov	edx,OFFSET sSeparator
	call WriteString
	call Crlf

	ret
ShowParams endp

DisplayLine proc
	;Address string to start the line
	mov	edx,OFFSET sAddress
	call WriteString
	
	;address of value
	call WriteHex
	
	;Equals string separator
	mov	edx,OFFSET sEquals
	call WriteString
	
	;value at address
	mov eax,ebx
	call WriteHex
	
	;end of line
	call Crlf
	
	ret
DisplayLine endp

end main