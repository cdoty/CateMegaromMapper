include "../../../System/SystemDefines.inc"

ext	expandedRAMEnabled

; Sets expandedRAMEnabled
; 0: No memory expansion 
; 1: Memory expansion enabled
enableExpandedRAM:	public enableExpandedRAM
	; Save the return address since the stack will be destroyed if the RAM is swapped in.
	pop		de

	; See if memory expansion is already enabled
	call	checkExpandedRAM

	cp		1
	jr		z, exitEnableExpandedRAM

	; If not, try to enable it
	ld		a, 1
	out		(MemoryExpansionPort), a

	; Check again to make sure it was enabled
	call	checkExpandedRAM

exitEnableExpandedRAM:
	push	de

	ret

; Return A - 0: No memory expansion  1: Memory expansion present
checkExpandedRAM:
	ld		b, 1

	ld		a, $11
	ld		(RAMStart), a

	ld		a, $22
	ld		(RAMStart + DefaultRamSize), a

	ld		hl, RAMStart
	
	cp		(hl)
	jp		nz, TestRam2

	ld		b, 0

	jp		exitCheckExpandedRam

TestRam2:
	ld		a, $33
	ld		(RAMStart + DefaultRamSize * 2), a

	ld		a, $44
	ld		(RAMStart + DefaultRamSize * 3), a

	ld		hl, RAMStart + DefaultRamSize * 2
	
	cp		(hl)
	jp		nz, TestRam3

	ld		b, 0

	jp		exitCheckExpandedRam

TestRam3:
	ld		a, $55
	ld		(ExtraRAMStart), a
	ld		(ExtraRAMStart + ExtraRAMSize - 1), a

	ld		hl, ExtraRAMStart
	cp		(hl)
	jp		nz, ExitTestRam3

	ld		hl, ExtraRAMStart + ExtraRAMSize - 1
	cp		(hl)
	jp		z, TestRam4

ExitTestRam3:
	ld		b, 0
	jp		exitCheckExpandedRam

TestRam4:
	ld		a, $AA
	ld		(ExtraRAMStart + ExtraRAMSize / 4 * 2), a
	ld		(ExtraRAMStart + ExtraRAMSize / 4 * 3), a

	ld		hl, ExtraRAMStart + ExtraRAMSize / 4 * 2
	cp		(hl)
	jp		nz, ExitTestRam4

	ld		hl, ExtraRAMStart + ExtraRAMSize / 4 * 3
	cp		(hl)
	jp		z, TestRam5

ExitTestRam4:
	ld		b, 0
	jp		exitCheckExpandedRam

TestRam5:
	ld		a, $81
	ld		(ExtraRAMStart), a
	ld		(ExtraRAMStart + ExtraRAMSize / 4 * 3), a

	ld		hl, ExtraRAMStart
	cp		(hl)
	jp		nz, ExitTestRam5

	ld		hl, ExtraRAMStart + ExtraRAMSize / 4 * 3
	cp		(hl)
	jp		z, TestRam6

ExitTestRam5:
	ld		b, 0
	jp		exitCheckExpandedRam

TestRam6:
	ld		a, $42
	ld		(ExtraRAMStart + ExtraRAMSize / 4), a
	ld		(ExtraRAMStart + ExtraRAMSize / 4 * 2), a

	ld		hl, ExtraRAMStart + ExtraRAMSize / 4
	cp		(hl)
	jp		nz, ExitTestRam6

	ld		hl, ExtraRAMStart + ExtraRAMSize / 4 * 2
	cp		(hl)
	jp		z, exitCheckExpandedRam

ExitTestRam6:
	ld		b, 0

exitCheckExpandedRam:
	ld		a, b
	ld		(expandedRAMEnabled), a

	ret
