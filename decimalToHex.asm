; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    i db ?  
    b dw ?
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
             
    mov b, 0d        
     
    decToHex:          
    ;mov ax, 15d
    mov ax, b
    mov dl, 16d
    mov i, 0d
    
    L1:
    div dl
    ;cmp ah, 0h
    ;je print
    
    mov bh, 0h
    mov bl, al
    
    
    mov ch, 0h
    mov cl, ah
    push cx
    inc i
    
    cmp al, 0h
    je print
    
    
    mov ax, bx
    mov dl, 16d
    
    jmp L1
    
    
    print:
    cmp i, 0d
    je takeAnotherInp
    
    pop cx
    
    mov dl, cl  
    cmp dl, 0Ah
    jge printHexDigit  
    add dl, 48d
    ;int 21h  
    again:
    mov ah, 2
    int 21h
    
    
    
    dec i
    jmp print
    
    printHexDigit:
    add dl, 55d
    jmp again  
    
    
    takeAnotherInp:
    call printSpace
    a:
    cmp b, 256d
    je exit
    inc b
    jmp decToHex   
    
    printSpace:
    mov dl, ' '
    mov ah, 02h
    int 21h
    jmp a
            
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
