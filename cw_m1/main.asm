; cw_m1.asm

.macro LOAD_CONST
    ldi @0, high(300)
    ldi @1, low(300)
.endmacro

LOAD_CONST R26,R27
nop
