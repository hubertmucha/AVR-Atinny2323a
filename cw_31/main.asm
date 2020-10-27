; cw_31.asm

MainLoop:
    rcall PortsSet

    ldi R17, $2
    ldi R16,20
    rcall DelayInMs
    rcall Display0

    ldi R17, $4
    ldi R16,20
    rcall DelayInMs
    rcall Display0

    ldi R17, $8
    ldi R16,20
    rcall DelayInMs
    rcall Display0

    ldi R17, $10
    ldi R16,20
    rcall DelayInMs
    rcall Display0


PortsSet:
    ser R18
    out DDRD, R18
    out DDRB, R18
    clr R18

Display0:

    ldi R19, $3F
    out Digits_P, R17
    out Segments_P, R19
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