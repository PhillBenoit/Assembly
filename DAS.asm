; Phillip Benoit
; CIS250
; Extra Credit 2 - DAS
; DAS.asm - Manually computes the DAS function
; part of: Benoit - CIS250 - Extra Credit 2.zip

INCLUDE Irvine32.inc

.data
;messages for output
sBegin  BYTE  "EDX is subtracted from ECX.  The hex total is in EBX.  The post DAA total is in EAX.",0
sMethod BYTE  "Method results:",0
sDAA    BYTE  "DAA results:",0

.code
main PROC
	;start message
	mov	edx,OFFSET sBegin
	call	WriteString
	call    Crlf
	call    Crlf

	mov ecx,48h
	mov edx,35h
	call runTest

	mov ecx,62h
	mov edx,35h
	call runTest
	
	mov ecx,32h
	mov edx,29h
	call runTest

	mov ecx,1h
	mov edx,5h
	call runTest

	mov ecx,1h
	mov edx,99h
	call runTest

	call WaitMsg
	exit
main ENDP

;-----------------------------------------------------
runTest PROC
; Runs DAS method and processor calls
;-----------------------------------------------------
	;clears flags
	push 0
	popfd

	;initial subtraction
	mov eax,ecx
	sub al,dl

	;store hex result to ebx
	mov ebx,eax

	;pushes flags and registers on to stack
	pushfd
	pushad

	;call method
	call DASmethod

	;print results of DASmethod
	pushfd
	push edx
	mov	edx,OFFSET sMethod
	call	WriteString
	call    Crlf
	pop edx
	popfd
	call    DumpRegs
	call    Crlf
	
	;pops flags and registers to restore conditions after sub instuction
	popad
	popfd

	;preform das
	das

	;print results of das
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
DASmethod PROC
; Simulates DAS
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
	sub al,6
	
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
	sub al,60h

return:
	;stores ecx to flags
	push ecx
	popfd
	
	;restores registers before returning
	pop ecx
	pop ebx
	ret
DASmethod ENDP
END main