TITLE "Point 3D Structure Example"

INCLUDE Irvine32.inc

.data
    ; Define the structure for a 3-dimensional point.
    ; Each coordinate is a word (2 bytes).
    Point3D STRUC
        x   DWORD  ?   ; X-coordinate at offset 0 from the start of the structure
        y   DWORD  ?   ; Y-coordinate at offset 4
        z   DWORD  ?   ; Z-coordinate at offset 8
    Point3D ENDS

    points  Point3D <10, 20, 30>     ; Point 1
            Point3D <-5, 15, 100>    ; Point 2
            Point3D <0, 0, -50>      ; Point 3
            Point3D <123, 456, 789>  ; Point 4
            Point3D <5, -10, 15>     ; Point 5

    NUM_POINTS EQU ($-points) / SIZEOF Point3D

    ; Strings for display
    msg_z BYTE  "Z-coordinate: ", 0

.code
main PROC

    mov eax, offset points           ; Load the address of the points array into EAX
    mov ecx, NUM_POINTS              ; Load the number of points into ECX
    mov ebx, 0                     ; Initialize index to 0
    MainLoop:
        ; Print the z-value
        mov edx, OFFSET msg_z        ; Load the address of the message string into EDX
        call WriteString             ; Display the message
        push eax 		   ; Save the base address of points
        mov eax, [eax+ebx+8]   ; Move to the Z-coordinate (offset 8 bytes)
        call WriteInt                ; Display the Z-coordinate
        call Crlf                    ; New line
        pop eax                     ; Restore the base address of points
        add ebx, 12
    loop MainLoop
    Call WaitMsg
    exit

main ENDP

END main
