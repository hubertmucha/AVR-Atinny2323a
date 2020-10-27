    ldi R20, 0x5
Main:
    nop
    Loop: dec R20
        nop
        BRBC  1, Loop
     
    rjmp Main
    nop