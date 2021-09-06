; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    msg1 db "Select 1 or 2 : $"
    msg2 db "1.  Hex To Oct   $"
    msg3 db "2.  Oct To Hex   $"  
    
    msg4 db "Enter a Hex Number : $" 
    msg5 db "Enter a Oct Number : $"
    
    
    var1 db 100 dup('$')     
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
    
    
    
    
    
    
    
    
    
    
    
    printLine:
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
    ret        
    
    
    
    octToHex:
    call printLine
    
    lea dx, msg5
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    FirstDigit:
    cmp al, '1'
    je D11oh
    
    cmp al, '2'
    je D22oh
    
    cmp al, '3'
    je D33oh
    
    cmp al, '4'
    je D44oh
    
    cmp al, '5'
    je D55oh
    
    
    cmp al, '6'
    je D66oh
    
    cmp al, '7'
    je D77oh
    
    
    SecondDigitoh:
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je D112oh
    
    
    cmp al, '2'
    je D222oh
    
    
    cmp al, '3'
    je D332oh
    
    
    cmp al, '4'
    je D442oh
    
    cmp al, '5'
    je D552oh
    
    
    cmp al, '6'
    je D662oh
    
    
    cmp al, '7'
    je D772oh      
    
    ThirdDigitoh:
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je D113oh
    
    
    cmp al, '2'
    je D223oh
    
    
    cmp al, '3'
    je D333oh
    
    
    cmp al, '4'
    je D443oh
    
    cmp al, '5'
    je D553oh
    
    
    cmp al, '6'
    je D663oh
    
    
    cmp al, '7'
    je D773oh
    
    
    D11oh:
    mov al, 64d
    mov bl, 1d
    mul bl
    mov cl, al
    jmp SecondDigitoh
    
    
    D22oh:
    mov al, 64d
    mov bl, 2d
    mul bl
    mov cl, al
    jmp SecondDigitoh    
    
    D33oh:
    mov al, 64d
    mov bl, 3d
    mul bl
    mov cl, al
    jmp SecondDigitoh
    
    D44oh:            
    mov al, 64d
    mov bl, 4d
    mul bl
    mov cl, al
    jmp SecondDigitoh
    
    D55oh: 
    mov al, 64d
    mov bl, 5d
    mul bl
    mov cl, al
    jmp SecondDigitoh
    
    D66oh: 
    mov al, 64d
    mov bl, 6d
    mul bl
    mov cl, al
    jmp SecondDigitoh
    
    D77oh:
    mov al, 64d
    mov bl, 7d
    mul bl
    mov cl, al
    jmp SecondDigitoh
    
    
    
    D112oh:
    mov al, 8d
    mov bl, 1d
    mul bl
    add cl, al
    jmp ThirdDigitoh
    
    D222oh:  
    mov al, 8d
    mov bl, 2d
    mul bl
    add cl, al
    jmp ThirdDigitoh    
    
    D332oh:
    mov al, 8d
    mov bl, 3d
    mul bl
    add cl, al
    jmp ThirdDigitoh 
    
    D442oh:            
    mov al, 8d
    mov bl, 4d
    mul bl
    add cl, al
    jmp ThirdDigitoh
    
    D552oh: 
    mov al, 8d
    mov bl, 5d
    mul bl
    add cl, al
    jmp ThirdDigitoh 
    
    D662oh: 
    mov al, 8d
    mov bl, 6d
    mul bl
    add cl, al
    jmp ThirdDigitoh 
    
    D772oh:
    mov al, 8d
    mov bl, 7d
    mul bl
    add cl, al
    jmp ThirdDigitoh  
    
    D113oh:
    mov al, 1d
    add al, cl
    mov num, al
    jmp convertHexoh
    
    D223oh:  
    mov al, 2d
    add al, cl
    mov num, al
    jmp convertHexoh    
    
    D333oh:
    mov al, 3d
    add al, cl
    mov num, al
    jmp convertHexoh
    
    D443oh:            
    mov al, 4d
    add al, cl
    mov num, al
    jmp convertHexoh
    
    D553oh: 
    mov al, 5d
    add al, cl
    mov num, al
    jmp convertHexoh 
    
    D663oh: 
    mov al, 6d
    add al, cl
    mov num, al
    jmp convertHexoh 
    
    D773oh:
    mov al, 7d
    add al, cl
    mov num, al
    jmp convertHexoh   
    
    
    convertHexoh:
    
    mov bh, 0h
    mov bl, al
    
    mov ax, bx
    mov cx, ax
    
    call printLine 
    
    mov dl, 16d
    mov i, 0d
    mov ax, cx  
    
    L1oh:
   
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
    
    jmp L1oh
    
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
    add  dl, 55d
    jmp againoh 
    
    
    hexToOctal:
    
 
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
