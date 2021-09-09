; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"  
    arr db ?  
    num db ?    
    i db ?
    j db ?
    ml db ?      
    sum db ?
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
    
    mov cx, 0d
    takeInput:
        mov ah, 1
        int 21h
        inc cx
        
        cmp al, 'H'
        je hexToOctal
        
        cmp al, 'O'
        je octToHex
        
        cmp al, 41h
        jge letter
        
        digit:
        sub al, 48
        mov ah, 0
        push ax 
        
        jmp takeInput
        
        
        letter:
        sub al, 37H
        mov ah, 0
        push ax
        
        jmp takeInput
        
        
        
    hexToOctal:
    dec cx 
    mov ml, 1d 
    mov sum, 0d    
    
    makeDecimal: 
        cmp cx, 0d
        je convertOct:
        mov bl, ml
        pop ax
    
        mul bl
        add sum, al
        
        mov al, ml
        mov bl, 16d
        mul bl
        mov ml, al
        
        dec cx
        jmp makeDecimal
    
    convertOct:
        mov bl, sum   
        call printLine
        call printLine
   
        mov bh, 0h
        mov bl, sum
    
        mov ax, bx
        mov cx, ax
    
    
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
            je takeAnotherInput
            pop cx
    
            mov dl, cl
            add dl, 48d
            mov ah, 2
            int 21h
            dec i
            jmp print  
    
    octToHex:
        dec cx 
        mov ml, 1d 
        mov sum, 0d    
    
    makeOctToDecimal: 
        cmp cx, 0d
        je convertOctToHex
        mov bl, ml
        pop ax
    
        mul bl
        add sum, al
        
        mov al, ml
        mov bl, 8d
        mul bl
        mov ml, al
        
        dec cx
        jmp makeOctToDecimal    
        
    convertOctToHex: 
        call printLine  
        call printLine
        ;lea dx, msg7
        ;mov ah, 09h
        ;int 21h
    
        mov bh, 0h
        mov bl, sum
    
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
            je takeAnotherInput
    
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
    
    takeAnotherInput: 
        call printLine 
        call printLine
        
        mov ah, 1
        int 21h
        
        cmp al, 13
        je takeInput
        
        
           
     
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
