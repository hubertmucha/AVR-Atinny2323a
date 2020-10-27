; cw_42.asm
; inputs
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
Divide :
   ldi QCtrL,1
   ldi QCtrH,0
   ldi  XH,HIGH(20)
   ldi  XL,LOW(20)
   ldi  YL,LOW(10)
   ldi  YH,HIGH(10)
   clr RL
   clr RH
   clr QL
   clr QH
DivSub:sub XL,YL
    sbc XH,YH
    brbs 1,DivEnd        // zwieksza  quotient i konczy dzia³anie
    add QL,QCtrL
    adc QH,QCtrH
    cp XL,YL
    cpc XH,YH
    brlo Divide+22         // konczy dzia³anie
    rjmp DivSub
    add QL,QCtrL
DivEnd:adc QH,QCtrH
    mov RL,XL
    mov RH,XH
   ret
cp  XH,YH
brne Divide

nop
