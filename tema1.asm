%include "io.inc"

%define MAX_INPUT_SIZE 4096

section .data
        operand db "+-/* ", 0

section .bss
	expr: resb MAX_INPUT_SIZE

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
	
    GET_STRING expr, MAX_INPUT_SIZE

    ;initializare registri cu 0 
    xor ebx, ebx; registru folosit pentru parsarea sirului
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
              
parsing: 
    mov cl, [expr + ebx]; cl contine, pe rand, fiecare caracter al sirului
    inc ebx
        
    cmp cl, 0; verific daca am ajuns la finalul sirului
    jz end
    
    cmp cl, '0'; verific daca am ajuns la un operand (compar codurile ASCII)
    jae number
    
    ;verific care este operatorul
    cmp cl, '-'
    jz choice
    
    cmp cl, '+'
    jz sum
    
    cmp cl, '/'
    jz division
    
    cmp cl, '*'
    jz multiplication
    
    cmp cl, ' '
    cmp edx, 0; verific prin registrul edx daca numarul e negativ sau pozitiv
    jnz negative
    push eax; adaug nr(pozitiv) pe stiva
    xor eax, eax
    jmp parsing

negative:
    imul eax, edx; edx contine valoarea -1
    push eax; adaug nr(negativ) pe stiva
    xor eax, eax
    xor edx, edx
    jmp parsing
    
division:
    xor ecx, ecx
    xor edx, edx
    xor eax, eax
    
    ;scot din stiva si adaug inapoi rezultatul impartirii
    pop ecx
    pop eax
    CDQ
    idiv ecx
    push eax
    inc ebx; deplasez contorul
    xor eax, eax
    xor edx, edx
    xor ecx, ecx
    jmp parsing; continui parsarea sirului
    
multiplication:
    xor ecx, ecx
    xor edx, edx
    xor eax, eax
    
    ;scot din stiva si adaug inapoi rezultatul inmultirii
    pop edx
    pop eax
    imul eax, edx
    push eax
    inc ebx
    xor eax, eax
    xor edx, edx
    jmp parsing

sum:
    xor ecx, ecx
    xor edx, edx
    xor eax, eax
    
    pop edx
    pop eax
    add eax, edx
    push eax
    inc ebx
    xor eax, eax
    xor edx, edx
    jmp parsing
    
difference:
    xor ecx, ecx
    xor edx, edx
    xor eax, eax
    
    pop edx
    pop eax
    sub eax, edx
    push eax
    inc ebx
    xor eax, eax
    xor edx, edx
    jmp parsing
    
; conversia sir de caractere - numar
number:
    sub ecx, '0'; salvez cifra in registrul ecx si formez numarul
    imul eax, 10
    add eax, ecx
    jmp parsing
 
; la aparitia semnului '-' verific daca este operator sau daca trebuie sa formez un numar negativ
choice:
    mov dl, [expr + ebx]; caracterul imediat urmator dupa semnul '-'
    cmp edx, '0'; verific daca este cifra sau spatiu
    jb difference
   
    mov ecx, edx
    mov edx, -1
    inc ebx
    jmp number
 
end:
    pop eax; eax memoreaza rezultatul final
    PRINT_DEC 4, eax
    xor eax, eax
    mov esp, ebp
    ret
