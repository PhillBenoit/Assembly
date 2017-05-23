; Phillip Benoit
; CIS250
; Assignment 5 - Ex6 from pg285
; 7-10-6.asm - Demonstrates calling a method that calculates the
;              greatest common denominator of two integers
; part of: Benoit - CIS250 - Assignment 5.zip

INCLUDE Irvine32.inc

.data
;messages for output
sBegin  BYTE  "The greatest common denominator of ",0
sAnd    BYTE  " and ",0
sIs     BYTE  " is ",0


.code
main PROC
	;test values

	;test value with mutiple possible results (10,5,2)
	mov  eax,20
	mov  ebx,10
	call gcd
	call result
	
	;test for order of values
	mov  eax,10
	mov  ebx,20
	call gcd
	call result

	;test for negative
	mov  eax,-20
	mov  ebx,10
	call gcd
	call result

	;test for one possible result (2)
	mov  eax,22
	mov  ebx,20
	call gcd
	call result

	;test for no gcd (1)
	mov  eax,5
	mov  ebx,7
	call gcd
	call result

	;test limits of absoute value
	mov  eax,80000000h
	mov  ebx,80000001h
	call gcd
	call result

	;test 0 and greatest positive value
	mov  eax,7fffffffh
	mov  ebx,0
	call gcd
	call result

	call WaitMsg
	exit
main ENDP

;-----------------------------------------------------
result PROC
; Displays the results of a gcd calculation
;-----------------------------------------------------
	push eax ;maintains storage
	push edx ;maintains storage

	mov	edx,OFFSET sBegin
	call	WriteString
	call    WriteInt
	mov	edx,OFFSET sAnd
	mov eax,ebx
	call	WriteString
	call    WriteInt
	mov	edx,OFFSET sIs
	mov eax,ecx
	call	WriteString
	call    WriteInt
	call    Crlf

	pop edx ;maintains storage
	pop eax ;maintains storage
	ret
result ENDP

;-----------------------------------------------------
gcd PROC
; finds the greatest common denominator of eax and ebx
;-----------------------------------------------------
	push eax ;store starting value
	push ebx ;store starting value
	push edx ;maintains storage

	neg eax     ;inverts eax
	jz zero     ;prevents dividing by 0
	jns ebxtest ;skip ahead if eax is now positive
	neg eax     ;inverts eax back in to a postive
ebxtest:
	neg ebx     ;inverts ebx
	jz zero     ;prevents dividing by 0
	jns gcdloop ;skip ahead if ebx is now positive
	neg ebx     ;inverts ebx back in to a postive
gcdloop:
	mov edx,0   ;clear remainder register
	div ebx     ;checks eax / ebx
	mov eax,ebx ;moves second number in to first
	mov ebx,edx ;moves remainder in to second number
	cmp ebx,0   ;compare remainder to 0
	ja gcdloop  ;continue loop if the remainder isn't 0

	mov ecx,eax ;store found result to ecx
default:
	pop edx ;maintains storage
	pop ebx ;restore original value
	pop eax ;restore original value
	ret
zero:
	mov ecx, 0 ;gcd is 0 if either value is 0
	jz default
gcd ENDP
END main