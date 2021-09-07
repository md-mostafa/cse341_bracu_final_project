; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    
    msg1 db "Select 1 or 2  : $"
    msg2 db "1.  Hex To Oct   $"
    msg3 db "2.  Oct To Hex   $"
    
    msg4 db "Enter a Hex Number : $"
    msg5 db "Enter a Oct Number : $"
    
    
    num db ?
    i db ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    lea dx, msg2
    mov ah, 09h
    int 21h
    
    call printLine
    
    lea dx, msg3
    mov ah, 09h
    int 21h
    
    call printLine
    call printLine
    
    lea dx, msg1
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je hexToOctal
    
    cmp al, '2'   
    je octToHex
     
    jmp exit
    
    octToHex:
    call printLine
    
    lea dx, msg5
    mov ah, 09h
    int 21h
    
    ;mov ah, 01h
    ;nt 21h
    
    
    firstDigitoh:
    mov ah, 01h
    int 21h
    
    cmp al, 41h
    jge letteroh1
    
    digitoh1:
    sub al, 48
    jmp mul64
    
    letteroh1:
    sub al, 37h
    
    mul64:
    mov bl, 64d
    mul bl
    mov num, al
    
    
    secondDigitoh:
    mov ah, 01h
    int 21h
    
    
    cmp al, 41h
    jge letteroh2
    
    digitoh2:
    sub al, 48
    jmp mul8
    
    letteroh2:
    sub al, 37h
    
    mul8:
    mov bl, 8d
    mul bl
    add num, al
    mov cl, num
    
    thirdDigitoh:
    mov ah, 01h
    int 21h
    
    cmp al, 41h
    jge letteroh3
    
    digitoh3:
    sub al, 48
    jmp mul1
    
    letteroh3:
    sub al, 37h
    
    mul1:
    add num, al 
    mov cl, num
    
    convertOctToHex:
    
    mov bh, 0h
    mov bl, num
    
    mov ax, bx
    mov cx, ax
    
    call printLine
    
    mov dl, 16d
    mov i, 0d
    mov ax, cx
    
    Loop2:
    div dl
    
    mov bh, 0h
    mov bl, al
    
    mov ch, 0h
    mov cl, ah
    
    push cx
    inc i
    
    cmp al, 0h
    je printoh
    
    mov ax, bx
    mov dl, 16d
    
    jmp Loop2
    
    printoh:
    cmp i, 0d
    je exit
    
    pop cx
    
    mov dl, cl
    cmp dl, 0AH
    
    jge printHexDigitoh
    add dl, 48d
    
    againoh:
    mov ah, 2
    int 21h
    
    dec i
    jmp printoh
    
    printHexDigitoh:
    add dl, 55d
    jmp againoh
    
    
    
    
    printLine:
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
    ret        
  
    hexToOctal:
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
