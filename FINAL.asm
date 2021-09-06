; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    
    msg1 db "Enter a hex number or octal number : $"  
    
    numOfDigit db ?    
    
    dM db ?
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
                    
    lea dx, msg1
    mov ah, 09h
    int 21h   
    
    ;mov al, 1d  
    
    ;mov al, 0Ah
    
    mov numOfDigit, 0d 
    mov dM, 01d
    
    takeNumberInput:
    mov ah, 01h
    int 21h
    
    cmp al, 'O'
    je convertToHex
    
    cmp al, 'H'
    je convertToOct
    
    mov ch, 0H
    mov cl, al
    push cx
    inc numOfDigit
    
    jmp takeNumberInput
    
    
    
    convertToHex:
    
    ;makeDigit:
    ;pop cx
    
    mov sum, 0d
    convertToOct:
    ;mov sum, 0d
    makeDigit:
    pop cx
    dec numOfDigit
    mov ah, 0d
    mov al, cl
    
    cmp al, 'A'
    jge alpha
    
    sub al, 48d
    back:
    mov ah, 0d
    mov cl, al
    mov bl, dM
    mul bl
    add sum, al
    
    mov al,dM
    mov bl, 10h
    mul bl
    
    mov dM, al
    
    ;add dM, 10d
    ;add sum, al
    
    cmp numOfDigit, 0d
    je convertOct
    jmp convertToOct
    
    alpha:
    sub al, 49d
    jmp back
    
    
    convertOct:
    mov al, sum
    
      
    
    
            
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
