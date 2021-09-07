; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    
    msg1 db "Select 1 or 2 : $"
    msg2 db "1. Hex To Oct   $"
    msg3 db "2. Oct To Hex   $"
    
    
    msg4 db "Enter a Hex Number (2digit)  : $"
    msg5 db "Enter a Oct Number (3digit)  : $" 
    msg6 db "Check another number ? ('y' or 'n')  : $" 
    
    msg7 db "Hex number is   : $"
    msg8 db "Octal number is  :  $"
    
    num db ?
    var db ?
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

    ; add your code here    
    
    
    anotherNumber:
    call printLine
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
    
    
    hexToOctal:
    call printLine
    call printLine
    
    lea dx, msg4
    mov ah, 09h  
    int 21h
    
    firstDigit:
    mov ah, 01h
    int 21h
    
    cmp al, 41h
    jge letter
     
    digit:
    sub al, 48
    jmp mul10
    
    letter:
    sub al, 37h
    
    mul10:
    mov bl, 16d
    
    mul bl
    
    mov num, al
    
    secondDigit:
    mov ah, 01h
    int 21h
    
    cmp al, 41h
    jge letter2
    
    digit2:
    sub al, 48
    jmp makeDecimal
    
    letter2:
    sub al, 37h
    
    makeDecimal:
    add num, al
    
    mov bl, num
    
    
    convertOct:  
    call printLine
    lea dx, msg8
    mov ah, 09h
    int 21h
    
    mov bh, 0h
    mov bl, num
    
    mov ax, bx
    mov cx, ax
    
    ;call printLine
    
    mov ax, cx
    
    mov dl, 8d
    mov i, 0d
    
    Loop1:
    div dl
    
    mov bh, 0h
    mov bl, al
    
    mov ch, 0h
    mov cl, ah
    
    push cx
    inc i
    
    cmp al, 0h
    je print
    
    mov ax, bx
    mov dl, 8d
    
    jmp Loop1
    
    print:
    cmp i, 0d
    je anotherInp
    pop cx
    
    mov dl, cl
    add dl, 48d
    mov ah, 2
    int 21h
    dec i
    jmp print 
    
    
    
    octToHex:
    call printLine 
    call printLine
    
    lea dx, msg5
    mov ah, 09h
    int 21h
    
    
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
    call printLine  
    call printLine
    lea dx, msg7
    mov ah, 09h
    int 21h
    
    mov bh, 0h
    mov bl, num
    
    mov ax, bx
    mov cx, ax
    
    ;call printLine
    
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
    je anotherInp
    
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
    
    anotherInp:
    call printLine
    call printLine
    
    lea dx, msg6
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, 'y'
    call printLine
    je anotherNumber
    
    je exit
    
   
            
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
