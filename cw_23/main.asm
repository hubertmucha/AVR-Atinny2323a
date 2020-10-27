; cw_23.asm

MainLoop:
    rcall DelayInMs
    nop
rjmp MainLoop

DelayInMs:
    ldi R26, 12 ;ms fo delay
    DelayLoopInMs:
        rcall DelayOneMs
        dec R26

    brbc 1,DelayLoopInMs
ret 

DelayOneMs:
    ldi R25, $7  ; stary 
    ldi R24, $D0 ; nowy
    DelayLoop:
        sbiw R25:R24,1 
    brbc 1, DelayLoop
ret
