TITLE SwitchCase (SwitchCase.asm)

INCLUDE Irvine32.inc

.data
     CaseTable BYTE 'A'       ;lookup value
     DWORD Process_A  ;address of procedure
     EntrySize = ($ - CaseTable)
             BYTE 'B'
             DWORD Process_B
             BYTE 'C'
             DWORD Process_C
             BYTE 'D'
             DWORD Process_D
             BYTE 'E'
             DWORD Process_E
    NumberOfEntries = ($ - CaseTable) / EntrySize
    msgA BYTE "Process_A", 0
    msgB BYTE "Process_B", 0
    msgC BYTE "Process_C", 0
    msgD BYTE "Process_D", 0
    msgE BYTE "Process_E", 0
    prompt BYTE "Press A, B, C, D or E:", 0
.code

Main Proc
    Mov edx, offset prompt
    Call writestring
    Call readchar
    mov ebx,OFFSET CaseTable
    mov ecx, NumberofEntries
    call Crlf
L1:      
    cmp al,[ebx]
    jne L2
    call NEAR PTR [Ebx + 1]
    call WriteString
    call Crlf
    jmp L3    
L2:      
    add ebx, EntrySize
    loop L1
L3:
    call WaitMsg
    exit
main EndP

Process_A Proc
         Mov edx, offset msgA
         Ret
Process_A EndP

Process_B Proc
         Mov edx, offset msgB
         Ret
Process_B EndP

Process_C Proc
        Mov edx, offset msgC
        Ret
Process_C EndP 
 
Process_D Proc
        Mov edx, offset msgD
        Ret
Process_D EndP

Process_E Proc
        Mov edx, offset msgE
        Ret
Process_E EndP
END main
