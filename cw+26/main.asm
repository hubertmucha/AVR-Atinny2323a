MainLoop:
     rcall PortsSet
    rcall DisplayC
    ldi R16,20
    rcall DelayInMs
    rcall DisplayH
    ldi R16,20
    rcall DelayInMs
    rcall DisplayU
    ldi R16,20
    rcall DelayInMs
    rcall DisplayJ
    ldi R16,20
    rcall DelayInMs
    rjmp MainLoop

PortsSet:
    ser R18
    out DDRD, R18
    out DDRB, R18
    ldi R18, $2
    out PORTB, R18
    clr R18

DisplayC:
    ldi R17, $39
    out PORTD, R17
    ret

DisplayH:
    ldi R17, $76
    out PORTD, R17
    ret

DisplayU:
    ldi R17, $3E
    out PORTD, R17
    ret

DisplayJ:
    ldi R17, $1E
    out PORTD, R17
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