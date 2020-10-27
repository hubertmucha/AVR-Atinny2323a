;cw_41.asm

Table: .db 0x0,0x3F,0x1,0x06,0x2,0x5B,0x3,0x4F,0x4,0x66,0x5,0x6D,0x6,0x7D,0x7,0x07,0x8,0x7F,0x9,0x67

.macro LOAD_TABLE
    ldi R30, low(Table<<1)
    ldi R31, high(Table<<1)
.endmacro

.macro LOAD_CONST
ldi @0, low(@2)
ldi @1, high(@2)
.endmacro

.macro SET_DIGIT
    sbi Digits_P, PINB@0+1
    out Segments_P, Digit_@0
    LOAD_CONST R24, R25, 5
  ;  rcall DelayInMS
    cbi Digits_P, PINB@0+1
.endmacro

.def Digit_0 = R2
.def Digit_1 = R3
.def Digit_2 = R4
.def Digit_3 = R5

ldi R16, 9
ldi R17, 8
ldi R18, 7
ldi R19, 6

mov Digit_0, R16
mov Digit_1, R17
mov Digit_2, R18
mov Digit_3, R19

;ustawienie portu na wyjscie
ser R18
out DDRD, R18

ldi R20, 0x0 ;licznik 
ldi R21, 0x9
ldi R22, 0X10
rcall DigitTo7segCode
nop
Main:
    cp R20,R21
    brne Counter
    add R20, R22
    ldi R22, 0x9
    sub R20, R22
    ldi R22, 0x10
    add R21, R22
    nop
Counter:
    inc R20
    SET_DIGIT 0
    SET_DIGIT 1
    SET_DIGIT 2
    SET_DIGIT 3
    rjmp Main



DelayInMS: 
    Main_loop:
        push R24
        push R25
        rcall DelayOneMs
        pop R25
        pop R24
        SBIW R24:R25, 1
        brbc 1, Main_loop
        ret
DelayOneMs:
    push R24
    push R25
    ldi R24, low($7C9)
    ldi R25, high($7C9)
    LoopMs:
        sbiw R24:R25, 1
        brbc 1, LoopMs
    pop R25
    pop R24
    ret

DigitTo7segCode:
    DigitOne:lpm R16, Z
            adiw R30:R31,1
            adiw R30:R31,1
            cp Digit_0,R16
        brne DigitOne
        sbiw R30:R31,1
        lpm Digit_0, Z
        LOAD_TABLE
    DigitTwo:lpm R16, Z
            adiw R30:R31,1
            adiw R30:R31,1
            cp Digit_1,R16
        brne DigitTwo
        sbiw R30:R31,1
        lpm Digit_1, Z
        LOAD_TABLE
    DigitThree:lpm R16, Z
            adiw R30:R31,1
            adiw R30:R31,1
            cp Digit_2,R16
        brne DigitThree
        sbiw R30:R31,1
        lpm Digit_2, Z
        LOAD_TABLE
    DigitFour:lpm R16, Z
            adiw R30:R31,1
            adiw R30:R31,1
            cp Digit_3,R16
        brne DigitFour
        sbiw R30:R31,1
        lpm Digit_3, Z
ret

