TITLE Integer Stack Program

; Author: Adrian Bennett

INCLUDE Irvine32.inc

.data
PromptUser  BYTE    "Please enter an integer value: ", 0
ResultMsg   BYTE    "The values popped from the stack are:", 0

.code
main PROC
    ; --- Input Phase ---
    ; Loop 5 times to get user input and push to stack.
    mov  ecx, 5                     ; Set loop counter to 5
L1:
    ; Prompt the user for input
    mov  edx, OFFSET PromptUser     ; Load address of the prompt message
    call WriteString                ; Display the prompt
    
    ; Read the integer from the user
    call ReadInt                    ; Input is stored in eax
    
    ; Push the integer onto the stack
    push eax                        ; Store the value from eax on the stack
    
    loop L1                         ; Repeat the loop

    ; --- Output Phase ---
    ; Add a newline for better formatting before showing results.
    call Crlf
    
    ; Display the result message
    mov  edx, OFFSET ResultMsg
    call WriteString
    call Crlf
    
    ; Loop 5 times to pop from stack and display.
    mov  ecx, 5                     ; Reset loop counter to 5
L2:
    ; Pop the top value from the stack into eax
    pop  eax                        ; Retrieve a value from the stack
    
    ; Display the integer
    call WriteInt                   ; Display the value in eax
    call Crlf                       ; Move to the next line for the next number
    
    loop L2                         ; Repeat the loop


    mov eax, 5000
    call Sleep
    exit                            ; Exit the program

main ENDP

END main
