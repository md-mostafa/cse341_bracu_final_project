; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"  
    array db 10 dup (?)
    i db ?
    
    b dw ?
ends

stack segment
    dw   128  dup(0)  
    ;db   128 dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    
    ;mov ax, 0Fh
    ;mov dl, 8d
    
    ;div dl  
    
    ;mov bh, 0h
    ;mov bl, ah
    
    ;mov ax, bx
    ;div dl
    
    ;mov al, ah
    ;div bl 
    
    mov b, 00H    
    
    
    hexToOctal:
    cmp b, 0FFH
    je exit
    
    mov ax, b 
    mov dl, 8d  
    mov i, 0d  
    L1:
    div dl              ;ah = 7, al = 1
    ;cmp al, 0h          ;cmp al, 0h
    ;je print
    
    mov bh, 0h
    mov bl, al 
    
    mov ch, 0h
    mov cl, ah
    push cx
    inc i 
    
    cmp al, 0h
    je print
    
    
    ;mov dl, al
    ;add dl, 48d
    ;mov ah, 2
    ;int 21h
    mov ax, bx 
    mov dl, 8d
     
    jmp L1  
    
    
    
    print:
    cmp i, 0d
    je again
    pop cx
    mov dl, cl
    add dl, 48d
    mov ah, 2
    int 21h
    dec i
    jmp print 
    
    
    
    printSpace:
    mov dl, ' '
    mov ah, 02h
    int 21h
    ;mov dl, 13
    ;mov ah, 02h
    ;int 21h
    jmp a
     
     
    again:
    inc b
    jmp printSpace
    a:
    jmp hexToOctal
    
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
