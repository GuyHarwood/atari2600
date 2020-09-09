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

memloop:
  sta $0,X          ; store A register at address $0 + X
  dex               ; X--
  bne memloop       ; loop until X==0 (z-flag set)
  