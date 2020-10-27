ldi R16,$E0 ; stary 
ldi R17,$BF ; nowy 

ldi R18, $1 

LoopB:
    LoopA:
        add R17,R18
        nop
        brbc 0,LoopA
        ldi R17,0
        adc R16,R17
brbc 0,LoopB
nop
