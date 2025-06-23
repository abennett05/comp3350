TITLE Indirect Addressing	(main.asm)

INCLUDE Irvine32.inc

.data
	CloudArray SDWORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 0Ah, 0Bh, 0Ch
	MistArray SDWORD 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0Ah, 0Bh
	FogArray SDWORD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	mistHeader BYTE "MistArray:", 0
	header BYTE "FogArray:", 0
	newLine BYTE 0Dh, 0Ah, 0
	indexLabel BYTE "Index ", 0
	colon BYTE ": ", 0

.code
main PROC
	; Intializing the offset and loop counter
	mov esi, 0          ; ESI will be used as an index for the arrays
	mov ecx, 12         ; Number of elements in the arrays

L1:
	mov eax, MistArray[esi]
	add eax, CloudArray[esi]
	mov FogArray[esi], eax
	mov eax, FogArray[esi]

	add esi, 4
	loop L1

	mov esi, 0 			; Reset ESI to 0 for the next loop
	mov ecx, 12         ; Reset loop counter for the next loop

	mov edx, offset mistHeader
	call WriteString
	mov edx, offset newLine
	call WriteString

; Displaying the contents of MistArray
L2:
	mov edx, offset indexLabel
	call WriteString

	mov eax, esi         ; ESI is used as the index
	call WriteDec
	mov edx, offset colon
	call WriteString

	mov eax, MistArray[esi*4]
	call WriteDec

	mov edx, offset newLine
	call WriteString

	inc esi
	loop L2

	mov edx, offset newLine
	call WriteString
	
	mov esi, 0 			; Reset ESI to 0 for the next loop
	mov ecx, 12         ; Reset loop counter for the next loop

	mov edx, offset header
	call WriteString
	mov edx, offset newLine
	call WriteString

; Displaying the contents of FogArray
L3:
	mov edx, offset indexLabel
	call WriteString

	mov eax, esi         ; ESI is used as the index
	call WriteDec
	mov edx, offset colon
	call WriteString

	mov eax, FogArray[esi*4]
	call WriteDec

	mov edx, offset newLine
	call WriteString

	inc esi
	loop L3

	mov eax, 5000
	call Sleep
exit
main ENDP
END main
