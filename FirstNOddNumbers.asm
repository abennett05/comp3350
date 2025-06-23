TITLE Print n Odd Numbers from FogArray	(main.asm)

INCLUDE Irvine32.inc

.data
    FogArray SWORD -1, 87, 0CFh, 1234, -9, -256, 23, 4, 5, -111
    prompt   BYTE  "Enter number of odd elements to print: ", 0
    newline  BYTE  13, 10, 0
    header   BYTE  "First n odd numbers from FogArray:", 0

.code
main PROC
    ; Prompt user for n
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt               ; EAX <= user input n
    mov ebx, eax               ; EBX = remaining odd count to print

    ; Print header
    mov edx, OFFSET newline
    call WriteString
    mov edx, OFFSET header
    call WriteString
    call Crlf

    ; Setup loop
    mov esi, 0                ; index in elements (not bytes)
    mov ecx, LENGTHOF FogArray

L1:
    movsx eax, FogArray[esi] ; sign-extend SWORD => EAX
    test  eax, 1              ; check if odd
    jz skip                   ; skip if even

    call WriteInt
    call Crlf

    dec ebx                   ; one fewer odd to print
    cmp ebx, 0
    je Done                   ; if we've printed n, we're done

skip:
    inc esi
    loop L1

Done:
    call WaitMsg
    exit
main ENDP
END main
