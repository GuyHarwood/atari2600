  processor 6502

  include "vcs.h"
  include "macro.h"

  seg code
  org $F000               ; defines origin of the ROM at $F000

START:
  ;CLEAN_START             ; macro to safely clear the memory

; Set background  https://en.wikipedia.org/wiki/List_of_video_game_console_palettes#Atari_2600
  lda #$9C                ; light blue PAL (9,12) = 9C
  sta COLUBK              ; store A to bg color address ($09)

  jmp START               ; repeat from start

; fill ROM size to 4KB
  org $FFFC               ; defines origin to $FFFC
  .word START             ; reset vector at $FFFC
  .word START             ; interrupt vector at $FFFE (unused in vcs)
