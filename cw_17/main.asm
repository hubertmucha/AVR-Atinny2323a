; 20 012,88 [us] 

ldi R19, 16 ; counter C
ldi R20, 12 ; counter A
ldi R21, 10 ; counter B
ldi R22, 10; input dealay * 1ms

LoopD:
    ldi R19, 16
    LoopC:
        ldi R21, 9
        LoopB:
            ldi R20, 13
            LoopA:
                dec R20
                nop
                brbc 1, LoopA
                dec R21
            brbc 1, LoopB
            dec R19
            nop
            nop
        brbc 1, LoopC
        dec R22
        nop
        nop

     brbc 1,LoopD
nop