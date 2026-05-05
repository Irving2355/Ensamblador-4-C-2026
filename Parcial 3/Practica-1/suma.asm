bits 64
default rel 

section .text
global suma

suma:
    xor eax, eax
    xor r8d, r8d 

    .bucle:
    cmp r8d, edx
    jge .fin

    add eax, dword [rcx + r8*4]

    inc r8d
    jmp .bucle

    .fin:
    ret 