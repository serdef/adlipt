; arguments given by macros ARG1, ARG2
; ARG2 can't be al, cx, dx
; modifies ax, cx, dx

; 31 bytes with ARG1=al and ARG2=ah
; 35 bytes with ARG1=[bp+4] and ARG2=[bp+6]

        %if __BITS__ != 16
        %error This file is intended for 16-bit code
        %endif

        stc
        %ifnidni ARG1, al
        mov al, ARG1
        %endif
L1:
        mov dx, PORT
        out dx, al
        mov al, 13
        mov cx, 6
        jc L9           ; carry=1 iff first iteration
        dec ax
        mov cl, 35
L9:     inc dx
        inc dx
        out dx, al
        sub al, 4
        out dx, al
        add al, 4       ; clears carry. odd parity iff first iteration
        out dx, al
L2:     in al, dx
        loop L2
        mov al, ARG2
        jpo L1
