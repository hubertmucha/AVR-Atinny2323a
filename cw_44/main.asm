; cw_44.asm

.def XL=R16 ; divident
.def XH=R17
.def YL=R18 ; divisor
.def YH=R19
; outputs
.def RL=R20 ; remainder
.def RH=R21
.def QL=R22 ; quotient
.def QH=R23
; internal
.def QCtrL=R24
.def QCtrH=R25

.def PulseEdgeCtrL=R0
.def PulseEdgeCtrH=R1

Main:
    Counter:
        push R28
        push R29
        mov R28, R0
        mov R29, R1
        adiw R29:R28,0x1
        mov R0, R28
        mov R1, R29
        pop R29
        pop R28

    NumberToDigits:
        Divide:
           ldi QCtrL,1
           ldi QCtrH,0
           ldi  XH,HIGH(10)
           ldi  XL,LOW(10)
           ldi  YL,LOW(1000)
           ldi  YH,HIGH(1000)
           clr RL
           clr RH
           clr QL
           clr QH
           push R29
           ldi R29, 0x0
           cp R29,XL
           pop R29
           brlo DivZero
DivSub:     sub XL,YL
            sbc XH,YH
            brbs 1,Divide+20        // zwieksza  quotient i konczy dzia³anie
            add QL,QCtrL
            adc QH,QCtrH
            cp XL,YL
            cpc XH,YH
            brlo DivEnd   // konczy dzia³anie
            rjmp DivSub
DivZero:    add QL,QCtrL
            adc QH,QCtrH
DivEnd:     mov RL,XL
            mov RH,XH
        push QL
        nop
        Divide1:
           ldi QCtrL,1
           ldi QCtrH,0
           mov  XH,RH
           mov  XL,RL
           ldi  YL,LOW(100)
           ldi  YH,HIGH(100)
           clr RL
           clr RH
           clr QL
           clr QH

           push R29
           ldi R29, 0x0
           cp R29,XL
           pop R29
           brlo DivZero1

DivSub1:    sub XL,YL
            sbc XH,YH
            brbs 1,Divide1+20        // zwieksza  quotient i konczy dzia³anie
            add QL,QCtrL
            adc QH,QCtrH
            cp XL,YL
            cpc XH,YH
            brlo DivEnd1       // konczy dzia³anie
            rjmp DivSub1
DivZero1:    add QL,QCtrL
            adc QH,QCtrH
DivEnd1:    mov RL,XL
            mov RH,XH   
        push QL
        nop
        Divide2:
           ldi QCtrL,1
           ldi QCtrH,0
           mov  XH,RH
           mov  XL,RL
           ldi  YL,LOW(10)
           ldi  YH,HIGH(10)
           clr RL
           clr RH
           clr QL
           clr QH

           push R29
           ldi R29, 0x0
           cp R29,XL
           pop R29
           brlo DivZero2

DivSub2:    sub XL,YL
   sbc XH,YH
            brbs 1,Divide2+20        // zwieksza  quotient i konczy dzia³anie
            add QL,QCtrL
            adc QH,QCtrH
            cp XL,YL
            cpc XH,YH
            brlo DivEnd2        // konczy dzia³anie
            rjmp DivSub2
DivZero2 :           add QL,QCtrL
            adc QH,QCtrH
DivEnd2:    mov RL,XL
            mov RH,XH   
        push QL
        push RL
;end od divi
        .def Dig0=R22 ; Digits temps
        .def Dig1=R23 ;
        .def Dig2=R24 ;
        .def Dig3=R25 ;

        pop Dig0
        pop Dig1
        pop Dig2
        pop Dig3
        nop