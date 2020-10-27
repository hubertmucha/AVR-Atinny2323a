MainLoop:
    ldi R25, $7; stary 
    ldi R24, $D0; nowy
    rcall DelayInMs ;
rjmp MainLoop

DelayInMs:
    DelayLoop:
        sbiw R25:R24,1 
    brbc 1, DelayLoop
ret 

