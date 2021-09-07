; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    msg1 db "Enter a hex number  : $" 
    
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
    
    lea dx, msg1
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
    mov bh, 0h
    mov bl, num
    
    mov ax, bx
    mov cx, ax
    
    call printLine
    
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
    je exit
    pop cx
    
    mov dl, cl
    add dl, 48d
    mov ah, 2
    int 21h
    dec i
    jmp print
    
    
    printLine:
    mov dl, 10
    mov ah, 02h
    int 21h
    
    mov dl, 13
    mov ah, 02h
    int 21h
    ret
            
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
