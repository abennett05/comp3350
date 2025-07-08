TITLE Character Search Program (char_search.asm)

INCLUDE Irvine32.inc

.data
MyString BYTE "Summer is pleasant in Auburn", 0
charToFind BYTE 'u'
; --- Output Messages ---
foundMsg    BYTE "Character found: ", 0
notFoundMsg BYTE "Character not found.", 0
indexMsg    BYTE ", Index: ", 0

.code
main PROC
    ; Load the character we want to find into the AL register.
    mov al, charToFind

    ; Point ESI to the beginning of the string. ESI will be our pointer.
    mov esi, OFFSET MyString

    ; Initialize EBX to 0. We will use EBX as our index counter.
    mov ebx, 0

searchLoop:
    ; Get the character from the string that ESI is currently pointing to.
    ; We use CH to avoid interfering with AL, which holds our search character.
    mov ch, [esi]

    ; Check if we've reached the end of the string (the null terminator).
    cmp ch, 0
    je characterNotFound ; If it's the null terminator, the character wasn't found.

    ; Compare the character from the string (CH) with our search character (AL).
    cmp al, ch
    je characterFound ; If they are equal, we found it!

    ; If the characters did not match, move to the next one.
    inc esi     ; Point to the next character in the string.
    inc ebx     ; Increment our index counter.
    jmp searchLoop ; Repeat the loop.

characterFound:
    mov edx, OFFSET foundMsg
    call WriteString

    call WriteChar

    mov edx, OFFSET indexMsg
    call WriteString

    mov eax, ebx
    call WriteDec

    call Crlf
    jmp exitProgram ; The search is over, so we exit.

characterNotFound:
    ; Print the "not found" message.
    mov edx, OFFSET notFoundMsg
    call Crlf

exitProgram:
    call WaitMsg
    exit
main ENDP
END main
