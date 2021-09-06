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
    
    
    
    
    
    hexToOctal:
    call printLine   
    call printLine
    
    lea dx, msg4
    mov ah, 09h
    int 21h
    
    ;call printLine
    
    
    mov ah, 01h
    int 21h
    
    FirstDigit:
    cmp al, '1'  
    je D11      
    
    cmp al, '2'
    je D22          
    
    
    cmp al, '3' 
    je D33           
    
    cmp al, '4'
    je D44
    
    cmp al, '5'
    je D55           
    
    cmp al, '6'
    je D66
    
    cmp al, '7'
    je D77         
    
    cmp al, '8'
    je D88
    
    cmp al, '9'
    je D99        
    
    cmp al, '0'
    je D00
    
    cmp al, 'F'
    je F1
    
    cmp al, 'A'
    je A1 
    
    cmp al, 'B' 
    je B1 
    
    cmp al, 'C'
    je C1      
    
    
    cmp al, 'D'
    je D1
    
    cmp al, 'E'
    je E1
    
    
    SecondDigit:
    mov ah, 01h
    int 21h
    
    cmp al, '1'  
    je D112      
    
    cmp al, '2'
    je D222          
    
    
    cmp al, '3' 
    je D332           
    
    cmp al, '4'
    je D442
    
    cmp al, '5'
    je D552           
    
    cmp al, '6'
    je D662
    
    cmp al, '7'
    je D772         
    
    cmp al, '8'
    je D882
    
    cmp al, '9'
    je D992        
    
    cmp al, '0'
    je D002
    
    cmp al, 'F'
    je F2
    
    cmp al, 'A'
    je A2 
    
    cmp al, 'B' 
    je B2 
    
    cmp al, 'C'
    je C2      
    
    
    cmp al, 'D'
    je D2
    
    cmp al, 'E'
    je E2
    
    D11:
    mov al, 16d
    mov bl, 1d
    mul bl
    mov cl, al
    jmp SecondDigit
    
    D22:  
    mov al, 16d
    mov bl, 2d
    mul bl
    mov cl, al
    jmp SecondDigit    
    
    D33:
    mov al, 16d
    mov bl, 3d
    mul bl
    mov cl, al
    jmp SecondDigit
    
    D44:            
    mov al, 16d
    mov bl, 4d
    mul bl
    mov cl, al
    jmp SecondDigit
    
    D55: 
    mov al, 16d
    mov bl, 5d
    mul bl
    mov cl, al
    jmp SecondDigit
    
    D66: 
    mov al, 16d
    mov bl, 6d
    mul bl
    mov cl, al
    jmp SecondDigit
    
    D77:
    mov al, 16d
    mov bl, 7d
    mul bl
    mov cl, al
    jmp SecondDigit
    
    D88:
    mov al, 16d
    mov bl, 8d
    mul bl
    mov cl, al
    jmp SecondDigit 
    
    D99:            
    mov al, 16d
    mov bl, 9d
    mul bl
    mov cl, al
    jmp SecondDigit
    
    D00:            
    mov al, 16d
    mov bl, 0d
    mul bl
    mov cl, al
    jmp SecondDigit   
    
    F1:
    mov al, 16d 
    mov bl, 15d    
    mul bl
    mov cl, al  
    jmp SecondDigit
    
    A1:
    mov al, 16d    
    mov bl, 10d    
    mul bl 
    mov cl, al   
    jmp SecondDigit
    
    B1: 
    mov al, 16d    
    mov bl, 11d    
    mul bl  
    mov cl, al   
    jmp SecondDigit
    
    C1:
    mov al, 16d    
    mov bl, 12d    
    mul bl  
    mov cl, al   
    jmp SecondDigit
    
    D1:
    mov al, 16d    
    mov bl, 13d    
    mul bl   
    mov cl, al 
    jmp SecondDigit
    
    E1:
    mov al, 16d    
    mov bl, 14d    
    mul bl  
    mov cl, al    
    jmp SecondDigit  
    
    D112:
    mov al, 1d     
    add al, cl    
    mov num, al 
    jmp convertOct
    
    D222:  
    mov al, 2d     
    add al, cl    
    mov num, al 
    jmp convertOct   
    
    D332:
    mov al, 3d     
    add al, cl    
    mov num, al 
    jmp convertOct  
    
    D442:            
    mov al, 4d     
    add al, cl    
    mov num, al 
    jmp convertOct  
    
    D552: 
    mov al, 5d     
    add al, cl    
    mov num, al 
    jmp convertOct  
    
    D662: 
    mov al, 6d     
    add al, cl    
    mov num, al 
    jmp convertOct  
    
    D772:
    mov al, 7d     
    add al, cl    
    mov num, al 
    jmp convertOct  
    
    D882:
    mov al, 8d     
    add al, cl    
    mov num, al 
    jmp convertOct  
    
    D992:            
    mov al, 9d     
    add al, cl    
    mov num, al 
    jmp convertOct  
    
    D002:            
    mov al, 0d     
    add al, cl    
    mov num, al 
    jmp convertOct    
    
    F2:
    mov al, 15d 
    add al, cl
    mov num, al
    jmp convertOct  
    
    A2:
    mov al, 10d     
    add al, cl    
    mov num, al 
    jmp convertOct
    
    B2: 
    mov al, 11d    
    add al, cl  
    mov num, al  
    jmp convertOct
    
    C2:
    mov al, 12d    
    add al, cl 
    mov num, al 
    jmp convertOct
    
    D2:
    mov al, 13d      
    add al, cl 
    mov num, al   
    jmp convertOct
    
    E2:
    mov al, 14d 
    add al, cl 
    mov num, al   
    jmp convertOct
    
    
    
    convertOct:
    
    mov bh, 0h
    mov bl, al
    
    mov ax, bx
    mov cx, ax 
    
    call printLine   
    call printLine
    
    mov ax, cx
    
    
    
    mov dl, 8d  
    mov i, 0d  
    L1:
    div dl              ;ah = 7, al = 1
    ;cmp ah, 0h          ;cmp al, 0h
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
    
    
    
    octToHex:
    call printLine
    
    lea dx, msg5
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    FirstDigitoh:
    
    cmp al, '0'
    je D00oh
    
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
            
    cmp al, '0'
    je D002oh
            
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
    
    cmp al, '0'
    je D003oh
    
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
    
    D00oh:
    mov dl, 64d
    mov bl, 0d
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
    
    D002oh:
    mov al, 8d
    mov dl, 0d
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
    
    D003oh:
    mov al, 0d
    add al, cl
    mov num, al
    jmp convertHexoh  
    
    
    convertHexoh:
    
    mov bh, 0h
    mov bl, al
    
    mov ax, bx
    mov cx, ax
    
    call printLine
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
    
            
 
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
