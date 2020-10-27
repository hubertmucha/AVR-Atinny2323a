; cw_37.asm

// Program odczytuje 4 bajty z tablicy sta³ych zdefiniowanej w pamiêci kodu do rejestrów R20..R23

ldi R30, low(Table<<1)
ldi R31, high(Table<<1)



Table: .db 0x0,0x0,0x1,0x1,0x2,0x4,0x3,0x9,0x4,0x16,0x5,0x25,0x6,0x36,0x7,0x49,0x8,0x64,0x9,0x81 
ldi R17,0x9;twoja liczba do podniesienia do kwadratu

rjmp Jump
Square:
    lpm R16, Z
    adiw R30:R31,1
    adiw R30:R31,1
Jump:    cp R17,R16
brne Square
sbiw R30:R31,1
lpm R17, Z
nop
ret