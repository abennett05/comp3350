TITLE XOR Encryption/Decryption (xor_cipher.asm)

; This program demonstrates a simple XOR cipher.
; It takes a plaintext string, encrypts it using a key,
; prints the resulting ciphertext, and then decrypts it
; back to the original plaintext to show the process works.
; This version uses inlined logic for simplification.

INCLUDE Irvine32.inc

.data
plainText   BYTE "Bennett", 0
encryptKey  BYTE 194 ; Using my last 3 digits of my Student ID number as the key (194)

origMsg     BYTE "Original Plaintext:  ", 0
cipherMsg   BYTE "Ciphertext (Encrypted): ", 0
decryptMsg  BYTE "Decrypted Plaintext: ", 0

.code
main PROC
    ; 1. Print the original plaintext string.
    mov  edx, OFFSET origMsg
    call WriteString
    mov  edx, OFFSET plainText
    call WriteString
    call Crlf

    ; 2. Encrypt the string using inlined logic.
    mov  esi, OFFSET plainText  ; ESI will be our pointer to the string
encrypt_loop:
    mov  al, [esi]              ; Get a character from the string
    cmp  al, 0                  ; Check for the null terminator
    je   encryption_done        ; If null, we're finished with this loop
    xor  al, encryptKey         ; The core cipher: XOR the character with the key
    mov  [esi], al              ; Store the transformed character back
    inc  esi                    ; Move the pointer to the next character
    jmp  encrypt_loop           ; Repeat the loop
encryption_done:
    
    ; 3. Print the resulting ciphertext.
    mov  edx, OFFSET cipherMsg
    call WriteString
    mov  edx, OFFSET plainText  ; The string in memory is now encrypted
    call WriteString
    call Crlf

    ; 4. Decrypt the string by running the EXACT same process.
    ; XORing a second time with the same key reverses the encryption.
    mov  esi, OFFSET plainText  ; Reset the pointer to the start of the string
decrypt_loop:
    mov  al, [esi]              ; Get a character from the string
    cmp  al, 0                  ; Check for the null terminator
    je   decryption_done        ; If null, we're finished with this loop
    xor  al, encryptKey         ; XOR with the same key to decrypt
    mov  [esi], al              ; Store the original character back
    inc  esi                    ; Move the pointer to the next character
    jmp  decrypt_loop           ; Repeat the loop
decryption_done:

    ; 5. Print the decrypted plaintext to prove it worked.
    mov  edx, OFFSET decryptMsg
    call WriteString
    mov  edx, OFFSET plainText ; The string is now back to the original
    call WriteString
    call Crlf

    ; --- Exit ---
    call Crlf
    call WaitMsg
    exit
main ENDP
END main
