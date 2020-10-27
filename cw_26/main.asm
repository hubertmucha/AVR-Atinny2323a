; cw_26.asm

MainLoop:
    rcall DelayInMs
    nop
rjmp MainLoop

DelayInMs:
    ldi R24, 4 ;ms fo delay
    sts 0x60, R24 
    DelayLoopInMs:
        rcall DelayOneMs
        lds R24, 0x60
        dec R24
        sts 0x60, R24
    brbc 1,DelayLoopInMs
ret 

DelayOneMs:
    ldi R25, $7  ; stary 
    ldi R24, $D0 ; nowy
    sts 0x61, R25
    DelayLoop:
        sbiw R25:R24,1 
    brbc 1, DelayLoop
    lds R25, 0x61
ret
