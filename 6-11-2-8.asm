; Phillip Benoit
; CIS250
; Assignment 4 - Ex8 from pg240
; 6-11-2-8.asm - encrypts and decrypts a message based on a key phrase
; part of: Benoit - CIS250 - Assignment 4.zip

INCLUDE Irvine32.inc
BUFMAX = 128     	; maximum buffer size

.data
KEY      BYTE  "ABXmv#7"        ;encrypt/decrypt key
buffer   BYTE   BUFMAX+1 DUP(0) ;buffer for input
bufSize  DWORD  ?               ;length of input buffer
keySize  DWORD  LENGTHOF KEY    ;length of the key

;messages
sPrompt  BYTE  "Enter the plain text: ",0
sEncrypt BYTE  "Cipher text:          ",0
sDecrypt BYTE  "Decrypted:            ",0


.code
main PROC
	call	InputTheString		; input the plain text
	call	TranslateBuffer	; encrypt the buffer
	mov	edx,OFFSET sEncrypt	; display encrypted message
	call	DisplayMessage
	call	TranslateBuffer  	; decrypt the buffer
	mov	edx,OFFSET sDecrypt	; display decrypted message
	call	DisplayMessage

	exit
main ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	edx,OFFSET sPrompt	; display a prompt
	call	WriteString
	mov	ecx,BUFMAX		; maximum character count
	mov	edx,OFFSET buffer   ; point to the buffer
	call	ReadString         	; input the string
	mov	bufSize,eax        	; save the length
	call	Crlf
	popad
	ret
InputTheString ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
	pushad
	call	WriteString
	mov	edx,OFFSET buffer	; display the buffer
	call	WriteString
	call	Crlf
	call	Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	ecx,bufSize		; loop counter
	mov	esi,0			; index 0 in buffer
	mov edi,0           ; index for key
L1:
	mov al,KEY[edi]     ; move a single byte from the ky in to al
	xor	buffer[esi],al	; translate a byte
	inc	esi				; point to next buffer byte
	inc edi             ; point to next key byte 
	cmp edi,keySize     ; compare edi to keySize
	jl  resume          ; jump to resume if less than
	mov edi,0           ; reset index for key
resume:	loop L1

	popad
	ret
TranslateBuffer ENDP
END main