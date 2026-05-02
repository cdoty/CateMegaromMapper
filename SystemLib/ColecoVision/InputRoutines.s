include "../../System/SystemDefines.inc"

clearJoysticks_:	public clearJoysticks_
	; Clear joystick values
	xor		a
	ld		(joystick1Value), a
	ld		(joystick1LastValue), a
	ld		(joystick2Value), a
	ld		(joystick2LastValue), a

	ret

updateJoysticks_:	public updateJoysticks_
	ld		a, (Joystick1Value)
	ld		(Joystick1LastValue), a
	ld		a, (Joystick2Value)
	ld		(Joystick2LastValue), a

	call	readJoysticks
	
	ret

readJoystick1_:	public readJoystick1_
	ld		a, (joystick1Value)

	ret

readJoystick2_:	public readJoystick2_
	ld		a, (joystick2Value)

	ret

readJoysticks:
	; readJoysticks uses register b and c
	push	bc
	push	de

	; Enable keypad read
	ld		a, $FF
	out		(KeypadReadEnable), a

	; Read keypad 1 data
	in		a, (Input1Port)
	
	; Invert and isolate button 2 input
	cpl
	and		$40

	; Shift into button 2 position
	srl		a
	
	; Save result
	ld		b, a

	; Read keypad 2 data
	in		a, (Input2Port)
	
	; Invert and isolate button 2 input
	cpl
	and		$40

	; Shift into button 2 position
	srl		a
	
	; Save result
	ld		c, a

	; Enable joystick read
	ld		a, $FF
	out		(JoystickReadEnable), a

	; Read joystick 1 data and invert
	in		a, (Input1Port)
	cpl
	
	; Save input data so button 2 can be examined
	ld		d, a
	
	; Get DPAD status
	and		$0F
	
	; Save data
	or		b
	ld		b, a

	; Get button 1 status and shift into button 1 position
	ld		a, d
	and		$40
	srl		a
	srl		a

	; Or in saved data
	or		b

	; Store result
	ld		(joystick1Value), a

	; Read joystick 2 data and invert
	in		a, (Input2Port)
	cpl
	
	; Save input data so button 2 can be examined
	ld		d, a

	; Get DPAD status
	and		$0F
	
	; Save data
	or		c
	ld		c, a

	; Get button 1 status and shift into button 1 position
	ld		a, d
	and		$40
	srl		a
	srl		a

	; Or in saved data
	or		c

	; Store result
	ld		(joystick2Value), a

	pop		de
	pop		bc

	ret

dseg

joystick1Value:
    ds	1

joystick1LastValue:
    ds	1

joystick2Value:
    ds	1

joystick2LastValue:
    ds	1
