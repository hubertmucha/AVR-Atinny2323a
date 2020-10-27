; cw_45.asm tak napawde

.cseg
.org 0 rjmp MainLoop
.org OC1Aaddr rjmp _timer_isr
_timer_isr:
    inc R0 
    reti 



.def XL=R16
.def XH=R17
.def YL=R18
.def YH=R19

.def RL=R20
.def RH=R21
.def QL=R22
.def QH=R23

.def QCtrL=R24
.def QCtrH=R25

.def PulseEdgeCtrL=R0
.def PulseEdgeCtrH=R1

.MACRO DELAY
    push r16             
    push R17                    
    ldi R16,LOW(@0)      
    ldi R17,HIGH(@0)     
    push R17                 
    push R16
    rcall DelayInMs
    pop R17                 
    pop R16
    pop r17              
    pop R16                  
.ENDMACRO

.MACRO SET_DIGIT
    push R16
    push R17
    push R18
    push R30
    ldi R17,@0
    sts 0x60,R17 
    rcall SET_DIGIT_SUBROUTINE 
    out Digits_P,R17
    out Segments_P,R16
    pop R16
    pop R17
    pop R18
    pop R30
    pop R31
.ENDMACRO

.EQU Time=1
.DEF Digit_0 = R2
.DEF Digit_1 = R3
.DEF Digit_2 = R4
.DEF Digit_3 = R5
.DEF PulseEdgeCtrL=R0
.DEF PulseEdgeCtrH=R1
    
ldi R16,0
mov Digit_0,R16
ldi R16,0
mov  Digit_1,R16
ldi R16,0
mov Digit_2,R16
ldi R16,0
mov Digit_3,R16
ldi R16,0x7F             
ldi R17,2
out DDRD,R16
out Segments_P,R16
out DDRB,R17
out Digits_P,R20
ldi R16,10
ldi QCtrL,255
ldi QCtrH,0
ldi  XH,HIGH(0000)
ldi  XL,LOW(0000)
mov PulseEdgeCtrH,XH
mov PulseEdgeCtrL,XL

MainLoop:
  Main: 
    ldi QCtrL,LOW(9999)
    ldi QCtrH,HIGH(9999)
    inc PulseEdgeCtrL
    cp PulseEdgeCtrL,QCtrL
    cpc PulseEdgeCtrH,QCtrH
    breq CLEAR
    mov XH,PulseEdgeCtrH
    mov XL,PulseEdgeCtrL
  
    rcall NumberToDigits
    rcall SetDigit
        DELAY 10
    ldi QCtrL,255
    cpse PulseEdgeCtrL,QCtrL
    rjmp Main
    INC PulseEdgeCtrH
    rjmp Main

CLEAR:
    clr PulseEdgeCtrL
    clr PulseEdgeCtrH
    rjmp Main

NumberToDigits:
    ldi  YH,HIGH(1000)
    ldi  YL,LOW(1000)
    rcall Divide
    mov  Digit_0,Ql
    mov  XH,RH
    mov  XL,RL
    ldi  YL,LOW(100)
    ldi  YH,HIGH(100)
    rcall Divide
    mov  Digit_1,QL
    mov  XH,RH
    mov  XL,RL
    ldi  YL,LOW(10)
    ldi  YH,HIGH(10)
    rcall Divide
    mov  Digit_2,QL
    mov  XH,RH
    mov  XL,RL
    ldi  YL,LOW(1)
    ldi  YH,HIGH(1)
    rcall Divide
    mov  Digit_3,Ql
ret

Divide:
    ldi QCtrL,1
    ldi QCtrH,0  
    clr RL
    clr RH
    clr QL
    clr QH
    cp XL,YL
    cpc XH,YH
    brlo DivEnd
    DivLoop:nop
        sub XL,YL
        sbc XH,YH
        brbs 1,DivEnd-2
        add QL,QCtrL
        adc QH,QCtrH
        cp XL,YL
        cpc XH,YH
        brlo DivEnd
        rjmp DivLoop
        add QL,QCtrL
        adc QH,QCtrH
        DivEnd: nop
            MOV RL,XL
            mov RH,XH
        DivRet:nop
            ret

SetDigit: nop
    SET_DIGIT 3
    SET_DIGIT 2
    SET_DIGIT 1             
    SET_DIGIT 0
ret

TurnOnDigit0:
    mov R16,Digit_0
    sts 0x61,R16
    rjmp DigitLoop

TurnOnDigit1:
    mov R16,Digit_1
    sts 0x61,R16
    rjmp DigitLoop

TurnOnDigit2:
    mov R16,Digit_2
    sts 0x61,R16
    rjmp DigitLoop

TurnOnDigit3:
    mov R16,Digit_3
    sts 0x61,R16
    rjmp DigitLoop

SET_DIGIT_SUBROUTINE:
    ldi R18,0
    lds R17,0x60
    cp R17,R18
    breq TurnOnDigit0
    inc R18
    cp R17,R18
    breq TurnOnDigit1
    inc R18
    cp R17,R18
    breq TurnOnDigit2
    inc R18
    cp R17,R18
    breq TurnOnDigit3
    DigitLoop: nop
        rcall DigitTo7segCode 
        ldi R30, low(DIGITNUMBER<<1) 
        ldi R31, high(DIGITNUMBER<<1)
        lds R17,0x60
        add R30,R17              
        lpm R17, Z                
    DIGITNUMBER: .db 2,4,8,16  
ret        

DigitTo7segCode:
    ldi R30, low(SegCodeTable<<1)
    ldi R31, high(SegCodeTable<<1)
    LDS R16,0x61
    ADD R30,R16
    lpm R16, Z  
    SegCodeTable: .db 0x3F, 0x06, 0x5B,0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
ret

DelayInMs: 
    push R17                     
    push R16  
    rcall DelayOneMs
    pop R16         
    pop R17            
    dec R16
    brbc 1,DelayInMs
    inc R17    
    dec R17
    brbs 1,Return  
    ldi R16,255
    dec R17
    rjmp DelayInMs
Return:ret  

DelayOneMs:         
    ldi R17,4
    push R17
    ldi R16,118
    push R16   
    DelayLoop:nop
        pop R16
        dec R16
        push R16
        brbc 1,DelayLoop   
        pop R16
        pop R17
        dec R17  
        push R17
        push R16
        brbc 1,DelayLoop         
        pop R16
        pop R17
    ret             

