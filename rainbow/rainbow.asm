  processor 6502

  include "vcs.h"
  include "macro.h"

  seg code
  org $F000

Start:
  CLEAN_START

;;; Format: NTSC
;;; Start new frame by turning on VBLANK & VSYNC
NextFrame:
  lda #2        
  sta VBLANK    ; turn on VBLANK
  sta VSYNC     ; turn on VSYNC

;;; Gen 3 lines of VSYNC
  sta WSYNC
  sta WSYNC
  sta WSYNC

  lda #0
  sta VSYNC     ; turn off VSYNC

;;; Let the TIA output 37 scanlines of VBLANK
  ldx #37
LoopVBlank:
  sta WSYNC
  dex
  bne LoopVBlank

  lda #0
  sta VBLANK    ; turn off VBLANK

;;; Draw 192 visible scanlines (kernel)
  ldx #192
LoopVisible:
  stx COLUBK    ;set bg color
  sta WSYNC
  dex
  bne LoopVisible

;;; output 30 more VBLANK lines (overscan) to complete frame
  lda #2
  sta VBLANK

  ldx #30
LoopOverscan:
  sta WSYNC
  dex
  bne LoopOverscan

  jmp NextFrame

;;; Complete ROM size to 4KB
  org $FFFC
  .word Start
  .word Start
