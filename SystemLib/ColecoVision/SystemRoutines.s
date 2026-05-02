include "../../System/GameDefines.inc"
include "../../System/SystemDefines.inc"
include "../../System/VRAMDefines.inc"

ext	nmiCount
ext	lastNMICount
ext	frameCount
ext	writeVDPReg
ext	spriteMagnificationEnabled
ext	nmiHandler

setMode2:	public setMode2
	ld		b, $02						; Disable external VDP interrupt, set M2 for Graphics mode 2
	ld		c, 0
	call	writeVDPReg

	ld		a, (spriteMagnificationEnabled)
	or		SpriteSize
	or		$80
	
	ld		b, a						; Enable 16K VRAM, Screen, NMI interrupt. Sprite size is set by SpriteSize define
	ld		c, 1
	call	writeVDPReg

	ld		b, Screen1VRAM / $400		; Set Name Table location.
	ld		c, 2
	call	writeVDPReg

	ld		b, Color1VRAM / $40 OR $7F	; Set Color Table location.
	ld		c, 3
	call	writeVDPReg

	ld		b, Tile1VRAM / $800 OR 3	; Set Pattern Table location.
	ld		c, 4
	call	writeVDPReg

	ld		b, SpriteAttributes / $80	; Set Sprite Attribute Table location.
	ld		c, 5
	call	writeVDPReg

	ld		b, SpritePattern / $800		; Set Sprite Pattern Table location.
	ld		c, 6
	call	writeVDPReg

	ld		b, $00						; Set background color to black
	ld		c, 7
	call	writeVDPReg

	ret
	
; Turn on screen
; void turnOnScreen();
turnOnScreen_: public turnOnScreen_
	ld		a, (spriteMagnificationEnabled)
	or		SpriteSize
	or		$E0

	ld		b, a						; Enable 16K VRAM, Screen, NMI interrupt. Sprite size is set by SpriteSize define
	ld		c, 1
	call	writeVDPReg

	ret
	
; Turn off screen
; void turnOffScreen();
turnOffScreen_:	public turnOffScreen_
	ld		a, (spriteMagnificationEnabled)
	or		SpriteSize
	or		$80
	
	ld		b, a						; Enable 16K VRAM, Screen, NMI interrupt. Sprite size is set by SpriteSize define
	ld		c, 1
	call	writeVDPReg

	ret

enableIRQ_:	public enableIRQ_
	; Clear nmi counts
	xor		a
	ld		(nmiCount), a
	ld		(lastNMICount), a

	ei

	ret

disableIRQ_:	public disableIRQ_
	di

	ret

; void waitForVBlank();
waitForVBlank_:	public waitForVBlank_
	ld		a, (lastNMICount)
	ld		b, a

waitVBlankLoop:
	ld		a, (nmiCount)
	cp		b
	
	jr		z, waitVBlankLoop
	
	ld		(lastNMICount), a

	ld		a, (frameCount)
	inc		a
	ld		(frameCount), a

	ret

; Use for ddp target.
setupInterrupt:	public setupInterrupt
	; Set NMI handler location
	ld		a, $C3
	ld		($66), a

	ld		hl, nmiHandler
	ld		($67), hl

	ret
