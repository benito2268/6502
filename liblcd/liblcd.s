; liblcd.s
; lcd library for Ben Eater's 6502 computer
; much code taken from https://eater.net/6502
; Ben Staehle
; 2/1/2024

.setcpu "65C02"

PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

lcd_wait:
  pha
  lda #%00000000  ; Port B is input
  sta DDRB
lcdbusy:
  lda #RW
  sta PORTA
  lda #(RW | E)
  sta PORTA
  lda PORTB
  and #%10000000
  bne lcdbusy

  lda #RW
  sta PORTA
  lda #%11111111  ; Port B is output
  sta DDRB
  pla
  rts

lcd_instruction:
  jsr lcd_wait
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set E bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  rts

lcd_putchar:
  jsr lcd_wait
  sta PORTB
  lda #RS         ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction
  sta PORTA
  lda #RS         ; Clear E bits
  sta PORTA
  rts

lcd_init:
  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction
  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction
  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_instruction
  lda #$00000001 ; Clear display
  jsr lcd_instruction
  rts

lcd_clear:
  lda #%00000001
  jsr lcd_instruction
  rts

; TODO doesn't work :(
; assumes a pointer to a null-terminated
; string has been passed in the X register
lcd_putstr:
  pha
putstr_loop:
  txa
  beq putstr_ret
  jsr lcd_putchar
  inx
  jmp putstr_loop
putstr_ret:
  pla
  rts

.export lcd_wait
.export lcd_instruction
.export lcd_putchar
.export lcd_init
.export lcd_clear
.export lcd_putstr