; cale wykonanie zajmuje jedna milisekunde 

ldi R20, 12 ; licznik A
ldi R21, 10 ; licznik B
ldi R22, 16 ; licznik C
LoopC:
    ldi R21, 10
    LoopB:
        ldi R20, 12
        LoopA:
            dec R20
            nop
            brbc 1, LoopA
            dec R21
        brbc 1, LoopB
        dec R22
    brbc 1, LoopC
    nop