; cw_25.asm
; lsd - load data from Data Space
; sts - store direct to Data Space

MainLoop:
    rcall DelayInMs
    nop
rjmp MainLoop

DelayInMs:
    ldi R24, 5 ;ms fo delay
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
    DelayLoop:
        sbiw R25:R24,1 
    brbc 1, DelayLoop
ret
