  processor 6502    ;declare instruction set used
  
  seg code
  org $F000         ;defines code origin at $F000

start:
  sei               ; disable interrupts
  cld               ; disable BCD decimal math mode
  ldx #$FF          ; loads X register with #$FF
  txs               ; transfer X register to S(tack) register

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the zero page region ($00 to $FF)
; Meaning the entire TIA register space and also RAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  lda #0            ; A = 0
  ldx #$FF          ; X = #$FF
  sta $FF           ; make sure $FF is zeroed before loop start

memloop:
  dex               ; X--
  sta $0,X          ; store A register at address $0 + X
  bne memloop       ; loop until X==0 (z-flag set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  org $FFFC
  .word start       ; reset vector at $FFFC (where program starts)
  .word start       ; interrupt vector at $FFFE (unused in VCS)
