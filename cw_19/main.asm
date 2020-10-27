ldi R25, $7; stary 
ldi R24, $D0; nowy

LoopA:
    sbiw R25:R24,1 ; odejmuje od rejestru z pary jedynke i ello
brbc 1, LoopA
nop
