;cw_43

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

NumberToDigits:
    Divide:
       ldi QCtrL,1
       ldi QCtrH,0
       ldi  XH,HIGH(1666)
       ldi  XL,LOW(1666)
       ldi  YL,LOW(1000)
       ldi  YH,HIGH(1000)
       clr RL
       clr RH
       clr QL
       clr QH
        sub XL,YL
        sbc XH,YH
        brbs 1,Divide+20        // zwieksza  quotient i konczy dzia³anie
        add QL,QCtrL
        adc QH,QCtrH
        cp XL,YL
        cpc XH,YH
        brlo Divide+21    // konczy dzia³anie
        rjmp Divide+10
        add QL,QCtrL
        adc QH,QCtrH
        mov RL,XL
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
        sub XL,YL
        sbc XH,YH
        brbs 1,Divide1+20        // zwieksza  quotient i konczy dzia³anie
        add QL,QCtrL
        adc QH,QCtrH
        cp XL,YL
        cpc XH,YH
        brlo Divide1+21       // konczy dzia³anie
        rjmp Divide1+10
        add QL,QCtrL
        adc QH,QCtrH
        mov RL,XL
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
        sub XL,YL
        sbc XH,YH
        brbs 1,Divide2+20        // zwieksza  quotient i konczy dzia³anie
        add QL,QCtrL
        adc QH,QCtrH
        cp XL,YL
        cpc XH,YH
        brlo Divide2+21         // konczy dzia³anie
        rjmp Divide2+10
        add QL,QCtrL
        adc QH,QCtrH
        mov RL,XL
        mov RH,XH   
    push QL
    push RL

    .def Dig0=R22 ; Digits temps
    .def Dig1=R23 ;
    .def Dig2=R24 ;
    .def Dig3=R25 ;

    pop Dig0
    pop Dig1
    pop Dig2
    pop Dig3
    nop