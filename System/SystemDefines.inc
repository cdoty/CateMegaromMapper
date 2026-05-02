RAMStart			equ	$6000	; Ram start address
RAMSize				equ	$3F0	; Ram size, excluding space reserved for stack
DefaultRamSize		equ	$400	; Default ram size
StackStart			equ	$6400	; Stack start address
ExtraRAMStart		equ	$6400	; Ram start address
ExtraRAMSize		equ	$1C00	; Extra ram size
ExpandedStackStart	equ	$8000	; Expanded stack start address
VDPBase				equ	$BE		; VDP data base port 
VDPReadBase			equ	VDPBase	; VDP control base port
WriteOffset			equ	1		; Difference between read and write ports for each base port
MemoryExpansionPort	equ	$53		; Memory expansion port
KeypadReadEnable	equ	$80		; Keypad read enable port
JoystickReadEnable	equ	$C0		; Joystick read enable port
SoundPort			equ	$E0		; Sound port
Input1Port			equ	$FC		; Joystick and Keypad 1 data port
Input2Port			equ	$FF		; Joystick and Keypad 2 data port
SystemSprites		equ	32		; Maximum system sprites
Joysticks			equ	2		; Joysticks supported
JoystickButtons		equ	2		; Joystick buttons supported
HiddenSpriteX		equ	0		; Hidden sprite position
HiddenSpriteY		equ	209
