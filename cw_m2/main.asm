; cw_m2.asm

.macro LOAD_CONST
    ldi @0, high(2000)
    ldi @1, low(2000)
.endmacro

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
    LOAD_CONST R25,R24
    push R25
    DelayLoop:
        sbiw R25:R24,1 
    brbc 1, DelayLoop
    pop R26
ret
