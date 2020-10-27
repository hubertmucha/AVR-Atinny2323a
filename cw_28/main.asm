; cw_28.asm

; push - na stos
; pop - ze stosu

MainLoop:
    rcall DelayInMs
    nop
rjmp MainLoop

DelayInMs:
    ldi R16, 4 ;ms fo delay
    push R16
    DelayLoopInMs:
        rcall DelayOneMs
        pop R16
        dec R16
        push R16
    brbc 1,DelayLoopInMs
ret 

DelayOneMs:
    ldi R17, $7  ; stary 
    ldi R16, $D0 ; nowy
    push R16
    DelayLoop:
        sbiw R17:R16,1 
    brbc 1, DelayLoop
    pop R16
ret
