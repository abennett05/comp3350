TITLE Digits (ebx_mul_15_and_extract.asm)

INCLUDE Irvine32.inc

.data
; --- Part A Data ---
promptMsg   BYTE    "Enter a value for EBX: ", 0
resultMsg1  BYTE    "EBX * 15 = ", 0
resultMsg2  BYTE    " (in hex) -> ", 0
testValue   DWORD   ?

; --- Part B Data --- 
valMsg      BYTE    "--- Part B ---", 0
initialHexMsg BYTE  "Value being analyzed: ", 0
value       DWORD   0A73CD3E9h ; 32-bit hexadecimal value
dhMsg       BYTE    "DH Value (first two digits): ", 0
dlMsg       BYTE    "DL Value (last two digits): ", 0
dxMsg       BYTE    "DX Value (combined): ", 0

.code
main PROC
    ; --- PART A: Multiply by 15 ---
    mov  edx, OFFSET promptMsg
    call WriteString
    call ReadDec          ; Read decimal integer into EAX
    mov  ebx, eax         ; Move the input value to EBX

    ; Calculation: EAX = EBX*1 + EBX*2 + EBX*4 + EBX*8

    mov  eax, ebx

    mov  edx, ebx
    shl  edx, 1
    add  eax, edx         

    mov  edx, ebx
    shl  edx, 2
    add  eax, edx         

    mov  edx, ebx
    shl  edx, 3
    add  eax, edx         

    ; --- Display the result of Part A ---
    mov  edx, OFFSET resultMsg1
    call WriteString
    call WriteDec
    mov  edx, OFFSET resultMsg2
    call WriteString
    call WriteHex
    call Crlf

    call WaitMsg
    call Crlf

    ; --- PART B: Extract Digits ---
    mov edx, OFFSET valMsg
    call WriteString
    call Crlf

    mov eax, value
    
    mov edx, OFFSET initialHexMsg
    call WriteString
    call WriteHex
    call Crlf
    call Crlf
    
    mov  ebx, eax
    shr  ebx, 24
    and  bl, 0Fh
    shl  bl, 4
    mov  dh, bl

    mov  ebx, eax
    shr  ebx, 20
    and  bl, 0Fh
    or   dh, bl

    mov  ebx, eax
    shr  ebx, 8
    and  bl, 0Fh
    shl  bl, 4
    mov  dl, bl

    mov  ebx, eax
    and  bl, 0Fh
    or   dl, bl

    mov  edx, OFFSET dhMsg
    call WriteString
    movzx eax, dh
    call WriteHex
    call Crlf

    mov  edx, OFFSET dlMsg
    call WriteString
    movzx eax, dl
    call WriteHex
    call Crlf

    mov  edx, OFFSET dxMsg
    call WriteString
    movzx eax, dx
    call WriteHex
    call Crlf

    call WaitMsg
    exit
main ENDP

END main
