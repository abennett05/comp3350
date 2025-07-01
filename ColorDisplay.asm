TITLE Color Display

INCLUDE Irvine32.inc

.data
    prompt_msg BYTE "Enter 0 for Blue, 1 for Orange, and 2 for Red: ", 0
    output_msg BYTE "War Eagle!", 0

.code
main PROC
	; --- Main PROC ---

	call InputIntColor

	call DisplayMsg

	call Crlf
	call Crlf

    mov eax, 5000
    call Sleep
	
	exit
main ENDP

InputIntColor PROC
	; --- InputInt Color PROC ---

	push edx                ; Save EDX because WriteString uses it.

    ; Prompt the user for input
    mov  edx, OFFSET prompt_msg
    call WriteString

    ; Read the integer from the keyboard
    call ReadInt            ; The integer is returned in the EAX register.

    ; Move the user's input into the BL register
    mov  bl, al             ; We only need the lowest 8 bits (AL) for a small number.

    pop  edx                ; Restore EDX to its original value.

    ret
InputIntColor ENDP

DisplayMsg PROC

    ; Preserve registers this procedure modifies (except for EAX/EDX which are
    ; standard for I/O procedures).
    push eax
    push ebx
    push edx

    ; Check the value in BL and jump to the corresponding code block.
    cmp  bl, 0
    je   _SetBlue           ; If BL == 0, jump to _SetBlue.

    cmp  bl, 1
    je   _SetOrange         ; If BL == 1, jump to _SetOrange.

    cmp  bl, 2
    je   _SetRed            ; If BL == 2, jump to _SetRed.

    jmp  _EndDisplay        ; If input is invalid, skip color change.

_SetBlue:
    mov  eax, blue          ; Set color to blue
    call SetTextColor
    jmp  _DisplayTheString  ; Jump to the display logic.

_SetOrange:
    mov  eax, yellow        ; Use yellow for orange
    call SetTextColor
    jmp  _DisplayTheString  ; Jump to the display logic.

_SetRed:
    mov  eax, red           ; Set color to red
    call SetTextColor

_DisplayTheString:
    mov  edx, OFFSET output_msg
    call WriteString

    ; Good practice: Restore the default text color after you're done.
    mov  eax, lightGray
    call SetTextColor

_EndDisplay:
    ; Restore the registers in the reverse order they were pushed.
    pop  edx
    pop  ebx
    pop  eax

    ret
DisplayMsg ENDP

END main
