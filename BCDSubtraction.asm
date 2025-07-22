TITLE BCD Subtraction

INCLUDE Irvine32.inc

.data
    ; Three examples
    A1    DWORD 12345678h
    B1    DWORD 11111111h
    A2    DWORD 87654321h
    B2    DWORD 12345678h
    A3    DWORD 99999999h
    B3    DWORD 88888888h

    result DWORD ?

    msgA  BYTE "A = ", 0
    msgB  BYTE "B = ", 0
    msgR  BYTE "A - B = ", 0

.code
main PROC
    ; --- First pair ---
    mov edx, offset msgA
    call WriteString
    mov eax, A1
    call DisplayBCD
    call Crlf

    mov edx, offset msgB
    call WriteString
    mov eax, B1
    call DisplayBCD
    call Crlf

    ; Perform BCD subtraction
    mov esi, offset A1
    mov edi, offset B1
    call SubBCD
    call DisplayResult

    call Crlf
    call Crlf

    ; --- Second pair ---
    mov edx, offset msgA
    call WriteString
    mov eax, A2
    call DisplayBCD
    call Crlf

    mov edx, offset msgB
    call WriteString
    mov eax, B2
    call DisplayBCD
    call Crlf

    ; Perform BCD subtraction
    mov esi, offset A2
    mov edi, offset B2
    call SubBCD
    call DisplayResult

    call Crlf
    call Crlf

    ; --- Third pair ---
    mov edx, offset msgA
    call WriteString
    mov eax, A3
    call DisplayBCD
    call Crlf

    mov edx, offset msgB
    call WriteString
    mov eax, B3
    call DisplayBCD
    call Crlf

    ; Perform BCD subtraction
    mov esi, offset A3
    mov edi, offset B3
    call SubBCD
    call DisplayResult

    call Crlf
    call Crlf

    call WaitMsg
    exit
main ENDP

SubBCD PROC
    pushad              ; Save all general purpose registers
    
    mov ebx, offset result
    mov ecx, 4          ; 4 bytes to process
    clc                 ; Clear carry flag before first SBB

SubLoop:
    mov al, [esi]       ; Get a byte from A
    sbb al, [edi]       ; Subtract byte from B with borrow
    das                 ; Decimal Adjust for Subtraction
    mov [ebx], al       ; Store the corrected byte in the result
    inc esi
    inc edi
    inc ebx
    loop SubLoop

    popad               ; Restore all registers
    ret
SubBCD ENDP

DisplayBCD PROC
    push eax
    push ecx
    push ebx

    mov ecx, 8          ; 8 nibbles (digits) to print
    mov ebx, eax

print_loop:
    rol ebx, 4          ; Rotate highest nibble into the lowest position
    mov al, bl
    and al, 0Fh         ; Isolate the nibble
    add al, '0'         ; Convert to ASCII character
    call WriteChar
    loop print_loop

    pop ebx
    pop ecx
    pop eax
    ret
DisplayBCD ENDP

DisplayResult PROC
    push eax
    push edx

    mov edx, offset msgR
    call WriteString
    mov eax, result     ; Load the calculated result
    call DisplayBCD

    pop edx
    pop eax
    ret
DisplayResult ENDP

END main
