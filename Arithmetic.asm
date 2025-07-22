TITLE Arithmetic Expression Evaluation

INCLUDE Irvine32.inc

.data
    valA DWORD 10
    valB DWORD 5
    valC DWORD 3
    final DWORD ?
    resultX DWORD ?  ; memory to store result

.code
main PROC
    push valC
    push valB
    push valA
    call ArithmeticExpression

    ; eax has the return value
    mov final, eax

    mov eax, resultX       ; EAX holds the value to print
    call WriteInt
    call Crlf

    call WaitMsg
    exit
main ENDP

ArithmeticExpression PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]    ; A
    sub eax, [ebp + 12]   ; A - B
    add eax, [ebp + 16]   ; (A - B) + C

    mov resultX, eax       ; store result
    lea edi, resultX       ; EDI = address of result

    pop ebp
    ret 12
ArithmeticExpression ENDP

END main
