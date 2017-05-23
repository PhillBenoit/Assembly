; Phillip Benoit
; CIS250
; Extra Credit 1 - DAA
; DAA.asm - Manually computes the DAA function
; part of: Benoit - CIS250 - Extra Credit 1.zip

INCLUDE Irvine32.inc

.data
;messages for output
sBegin  BYTE  "The added numbers are in ECX and EDX.  The hex total is in EBX.  The post DAA total is in EAX.",0
sMethod BYTE  "Method results:",0
sDAA    BYTE  "DAA results:",0

.code
main PROC
	;start message
	mov	edx,OFFSET sBegin
	call	WriteString
	call    Crlf
	call    Crlf

	mov ecx,35h
	mov edx,48h
	call runTest

	mov ecx,35h
	mov edx,65h
	call runTest
	
	mov ecx,69h
	mov edx,29h
	call runTest

	mov ecx,10h
	mov edx,5h
	call runTest

	mov ecx,99h
	mov edx,99h
	call runTest

	call WaitMsg
	exit
main ENDP

;-----------------------------------------------------
runTest PROC
; Runs DAA method and processor calls
;-----------------------------------------------------
	;clears flags
	push 0
	popfd

	;initial addition
	mov eax,ecx
	add al,dl

	;store hex result to ebx
	mov ebx,eax

	;pushes flags and registers on to stack
	pushfd
	pushad

	;call method
	call DAAmethod

	;print results of DAAmethod
	pushfd
	push edx
	mov	edx,OFFSET sMethod
	call	WriteString
	call    Crlf
	pop edx
	popfd
	call    DumpRegs
	call    Crlf
	
	;pops flags and registers to restore conditions after add instuction
	popad
	popfd

	;preform daa
	daa

	;print results of daa
	pushfd
	push edx
	mov	edx,OFFSET sDAA
	call	WriteString
	call    Crlf
	pop edx
	popfd
	call    DumpRegs
	call    Crlf

	ret
runTest ENDP

;-----------------------------------------------------
DAAmethod PROC
; Simulates DAA
;-----------------------------------------------------
	;stores ebx / ecx so they can be used as temporary variables
	push ebx
	push ecx
	
	;pushes flags on to stack, pops them to ebx, coppies to ecx for setting the flags
	pushfd
	pop ebx
	mov ecx,ebx
	
	;tests for aux carry flag
	and ebx,010h
	jnz auxTrue

	;moves eax in to ebx and isolates the last digit
	mov ebx,eax
	and ebx,0fh

	;tests for a digit 9 or less to skip changing the number
	cmp ebx,9
	jbe secondDigit

	;sets aux carry flag
	or ecx,010h

auxTrue:
	add al,6
	
secondDigit:
	;moves in flags for testing
	push ecx
	popfd
	
	;tests for carry flag
	jc carryTrue
	
	;tests for a digit 9 or less to skip changing the number
	cmp eax,9fh
	jbe return

	;sets carry flag
	or ecx,01h

carryTrue:
	add al,60h

return:
	;stores ecx to flags
	push ecx
	popfd
	
	;restores registers before returning
	pop ecx
	pop ebx
	ret
DAAmethod ENDP
END main