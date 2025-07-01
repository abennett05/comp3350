TITLE Search & Compare

INCLUDE Irvine32.inc

.data
    prompt_msg      BYTE "Enter a numbers: ", 0
    found_msg       BYTE "Found -1 at index: ", 0
    not_found_msg   BYTE "Number -1 not found in the stack.", 0
    DEBUG BYTE "Debugging output enabled.", 0

.code
main PROC
    call InputNumbers
    call Crlf
    mov eax, 5000  ; Sleep for 5 seconds to allow user to see the input
    call Sleep
    exit
main ENDP

InputNumbers PROC
    ; --- InputNumbers PROC ---
    mov ecx, 6        ; input 6 numbers
input_loop:
    mov edx, OFFSET prompt_msg
    call WriteString
    call ReadInt
    ; Store the input number on the stack
    ; The number is in EAX after ReadInt
    ; Push the number onto the stack
    push eax
    loop input_loop
    ; After input, we will search for -1 in the stack
    call Search
    ret
InputNumbers ENDP

Search PROC
    mov ecx, 6        ; search 6 numbers
    mov ebx, 6        ; start index from top of stack (index 5)

search_loop:
    pop eax
    cmp eax, -1
    je found

    dec ebx
    loop search_loop

    ; Not found
    mov edx, OFFSET not_found_msg
    call WriteString
    call Crlf

found:
    mov edx, OFFSET found_msg
    call WriteString
    mov eax, ebx
    call WriteInt
    call Crlf
Search ENDP

END main
