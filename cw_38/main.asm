; cw_38.asm

ldi R30, low(Table<<1)
ldi R31, high(Table<<1)

Table: .db 0x0,0x3F,0x1,0x06,0x2,0x5B,0x3,0x4F,0x4,0x66,0x5,0x6D,0x6,0x7D,0x7,0x07,0x8,0x7F,0x9,0x67
ldi R17,0x0;twoja liczba do zamieniena na 7SegmentsDigitCode

DigitTo7segCode:
    lpm R16, Z
    adiw R30:R31,1
    adiw R30:R31,1
    cp R17,R16
    brne DigitTo7segCode
    sbiw R30:R31,1
    lpm R17, Z
ret