_COLECOHEADER:	public _COLECOHEADER
	include	"../../../System/Signature.inc"

ext	startup
ext	nmiHandler
ext	spriteTable

	dw	spriteTable		; Sprite table
	dw	0				; Sprite order table, not used
	dw	0				; Work buffer, not used
	db	0				; Disable joystick 1 polling
	db	0				; Disable joystick 2 polling
	dw	startup			; Start of code

_RST08:	public _RST08
	reti
	nop

_RST10:	public _RST10
	reti
	nop

_RST18:	public _RST18
	reti
	nop

_RST20:	public _RST20
	reti
	nop

_RST28:	public _RST28
	reti
	nop

_RST30:	public _RST30
	reti
	nop

_IRQ:	public _IRQ
	reti
	nop

_NMI:	public _NMI
	jp		nmiHandler

_GAMETITLE:	public _GAMETITLE
	include	"../../../System/Title.inc"
