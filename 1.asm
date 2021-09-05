; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    msg1 db "Enter a hex digit : $"       
    
    var1 db 100 dup('$')
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
    
    
    lea dx, msg1
    mov ah, 09h
    int 21h
    
    
    mov ah, 01h
    int 21h
    
    FirstDigit:
    cmp al, 'F'
    je F
    
    cmp al, 'A'
    je A 
    
    cmp al, 'B' 
    je B 
    
    cmp al, 'C'
    je C      
    
    
    cmp al, 'D'
    je D
    
    cmp al, 'E'
    je E
    
    
    mov bl, 10h    
    F:
    mov al, 0Fh
    mul bl
    
    A:
    mov al, 0AH
    mul bl 
    
    B: 
    mov al, 0BH  
    mul bl  
    
    C:
    mov al, 0CH
    mul bl
    
    D:
    mov al, 0DH
    mul bl
    
    E:
    mov al, 0EH
    mul bl
    
    
   
            
 
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
