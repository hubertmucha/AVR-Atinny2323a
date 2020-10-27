; cw_33.asm
ldi R20,$3F
mov R2,R20 ;0

ldi R20,$6
mov R3,R20 ;1

ldi R20,$5B
mov R4,R20 ;2

ldi R20,$4F
mov R5,R20 ;3

.DEF Digit_0 = R2
.DEF Digit_1 = R3
.DEF Digit_2 = R4
.DEF Digit_3 = R5


MainLoop:
    rcall PortsSet

    ldi R17, $2
    ldi R16,20
    rcall DelayInMs
    rcall Display0

PortsSet:
    ser R18
    out DDRD, R18
    out DDRB, R18
    clr R18

Display0:

    out Digits_P, R17 ;na którym wyœwietalczu
    out Segments_P, Digit_3 ;jaka liczba 
    ret

DelayInMs:
    push R24                
    push R25
    DelayInMsLoop:
        rcall DelayOneMs
        dec R16 
        brbc 1,DelayInMsLoop
    pop R25                  
    pop R24
    ret            

DelayOneMs:
    ldi R25, $FA
    ldi R24, $CC
    CounterLoop : 
        adiw R25:R24, 1
        nop
        nop
        brcc CounterLoop
    ret