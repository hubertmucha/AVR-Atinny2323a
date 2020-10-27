; cw_27.asm

; push - na stos
; pop - ze stosu

MainLoop:
    rcall DelayInMs
    nop
rjmp MainLoop

DelayInMs:
    ldi R24, 4 ;ms fo delay
    push R24
    DelayLoopInMs:
        rcall DelayOneMs
        pop R24
        dec R24
        push R24
    brbc 1,DelayLoopInMs
ret 

DelayOneMs:
    ldi R25, $7  ; stary 
    ldi R24, $D0 ; nowy
    push R25
    DelayLoop:
        sbiw R25:R24,1 
    brbc 1, DelayLoop
    pop R26
ret
