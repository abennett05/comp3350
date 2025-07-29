TITLE "Characters in String"

INCLUDE Irvine32.inc

.data
	str1 BYTE "War Eagle!", 0
	str2 BYTE "COMP-3350 HW", 0
	str3 BYTE "Wasgud", 0
	str4 BYTE 0
	msgCount BYTE "Number of characters: ", 0

.code
main PROC
	; Display the strings and count their characters
	mov edx, offset str1
	call WriteString
	call Crlf
	mov edx, offset str1
	call CountChars
	call Crlf

	mov edx, offset str2
	call WriteString
	call Crlf
	mov edx, offset str2
	call CountChars
	call Crlf

	mov edx, offset str3
	call WriteString
	call Crlf
	mov edx, offset str3
	call CountChars
	call Crlf

	mov edx, offset str4
	call WriteString
	call Crlf
	mov edx, offset str4
	call CountChars

	call WaitMsg ; Wait for user input before exiting
	exit
main ENDP

CountChars PROC
	; Count the number of characters in the string pointed to by EDX
	; and display the count.
	
	push ebx
	mov ebx, edx          ; Save the address of the string in EBX
	xor ecx, ecx          ; Clear ECX to use it as a counter
	CountLoop:
		mov al, [ebx]        ; Load the next character
		test al, al          ; Check if it is the null terminator
		jz DoneCounting       ; If it is, we are done
		inc ecx              ; Increment the character count
		inc ebx              ; Move to the next character
		jmp CountLoop
	DoneCounting:
		mov eax, ecx         ; Move the count into EAX for display
		push eax             ; Save the count on the stack
		mov edx, offset msgCount
		call WriteString     ; Display the string (placeholder)
		pop eax              ; Restore the count
		call WriteDec        ; Display the count of characters
		call Crlf           ; Print a new line
		pop ebx              ; Restore EBX
		ret                  ; Return from the procedure
CountChars ENDP

END main
