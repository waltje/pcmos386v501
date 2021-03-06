	title		MOS UNITED KINGDOM Keyboard Driver
	include	page.inc


;		MOS UNITED KINGDOM Keyboard Driver
;
;       (c) Copyright 1988-1991 The Software Link, Incorporated
;		    All Rights Reserved

;	RKG	12/20/88	Rewrite of driver
;	BWR	11/29/89	Marked messages for foreign language
;				translation.
;	BWR	02/03/90	SHIFT-"\" now produces correct character,
;				the OR (PIPE) symbol "|".
;	BWR	02/14/90	The above was NOT correct.  The Correct
;				symbols are (\ and |) for keycode 41 and
;				(# and ~) for keycode 43.
;       BWR     02/04/91        Still several keys incorrectly mapped.
;                               This time, we have a real-live UK keyboard
;                               to test with.  At present, ALL keys seem
;                               to work correctly.  Version number now
;                               updated to level 4.11
;
	include	moskbfor.inc	; include foreign keyboard driver code
	
	; addition spcvcts go here
	
	dw	0, 0, 0, 0

ACCNTSPC label	byte	; no special accents

	SUBTTL	BASE CASE KEYBOARD SCAN CODE TRANSLATION TABLE
	page
	.xall		; suppress macro expansion

	dw	0, 0	; for PC/AT alternate keys
	db	'\',41
	db	'#',43
BASETBL	label	word
	scan = 0
	
	nokey	0	;  0
	key	1bh	;  1 escape
	irpc	x,<1234567890-=>
	key	'&x'
	endm
	key	08h	; 14 backspace
	
	key	09h	; 15 tab
	irpc	x,<qwertyuiop[]>
	key	'&x'
	endm
	key	0Dh	; 28 return

	spckey	ctrl	; 29 control
	
	irpc	x,<asdfghjkl;>
	key	'&x'
	endm
	key	27h	; 40 ' apostrophe
        key     '`'     ; 41 agrave apostrophe
	
	spckey	lshift	; 42 left shift
	
	key	'#'	; 43 special on 102 keyboard
	
	irpc	x,<zxcvbnm,./>
	key	'&x'
	endm

	spckey	rshift	; 54
	key	'*'	; 55 multiply sign
	spckey	alt	; 56 left alt
	key	' '	; 57 space bar
	spckey	caps	; 58 caps lock

	; function keys  F1 - F10
	irp	x,<59,60,61,62,63,64,65,66,67,68>
	fn	x
	endm

	spckey	num	; 69 num lock
	spckey	scroll	; 70 scroll lock

	fn	71	; 71 home
	fn	72	; 72 up arrow
	fn	73	; 73 page up
	key	'-'	; 74 '-' on keypad
	fn	75	; 75 left arrow
	fn	76	; 76 center cursor 5 on keypad
	fn	77	; 77 right arrow
	key	'+'	; 78 '+' on keypad
	fn	79	; 79 end
	fn	80	; 80 down arrow
	fn	81	; 81 page down

	spckey	insert	; 82 insert
	fn	83	; 83 delete
	
	nokey	84
	nokey	85
        key     '\'
	fn	85h	; 87 F11
	fn	86h	; 88 F12
	
	irp	x,<89,90,91,92>
	nokey	x
	endm
	
; following are cursor control version of num pad keys
;   (they aren't affected by num lock or shift)
	fn	81
	spckey	insert
	fn	83
	key	0Dh
	irp	x,<71,72,73,75,77,79,80>
	fn	x
	endm
	
; following are pf1-pf24 function keys
	irp	x,<160,161,162,163,164,165,166,167,168,169,170,171>
	fnx	x
	endm
	irp	x,<172,173,174,175,176,177,178,179,180,181,182,183>
	fnx	x
	endm

	chklen	<Base case table length is wrong>


	SUBTTL	SHIFT CASE KEYBOARD SCAN CODE TRANSLATION TABLE
	page

	dw	0, 0	; for PC alternate keys
	db	'~',41
	db	'|',43
SHFTTBL	label	word
	scan = 0
	
	nokey	0	;  0
	key	27	;  1 Escape
        irpc    x,<!"�$%^&*()_+>
	key	'&x'
	endm
	key	08h	; 14 backspace
	
	fn	15	; 15 back tab
        irpc    x,<QWERTYUIOP{}>
	key	'&x'
	endm
	key	0Dh	; 28 return

	spckey	ctrl	; 29 control
	irpc	x,<ASDFGHJKL:@>
	key	'&x'
	endm
        key     '�'

	spckey	lshift	; 42 left shift
	
	key	'~'	; 43 special on 102 keyboard
	
	irpc	x,<ZXCVBNM>
	key	'&x'
	endm
	key	'<'
	key	'>'
	key	'?'
	
	spckey	rshift	; 54
	spckey	prtscr	; 55
	spckey	alt	; 56 left alt
	key	' '	; 57 space bar
	spckey	caps	; 58 caps lock

	; shifted function keys  F1 - F10
        irp     x,<84,85,86,87,88,89,90,91,92,93>
	fn	x
	endm

	spckey	num	; 69 num lock
	nokey	70
;	spckey	scroll	; 70 scroll lock

	; numeric pad number keys
	irpc	x,<789-456+1230.>
	key	'&x'
	endm
	
	nokey	84
	nokey	85

        key     '|'
	fn	87h	; 87 F11
	fn	88h	; 88 F12
	
	irp	x,<89,90,91,92>
	nokey	x
	endm
	
; following are cursor control version of num pad keys
;   (they aren't affected by num lock or shift)

;	No known reason these are here, perhaps terminals??

	fn	81	; 93 page-down
	spckey	insert
	fn	83	; 95 delete
	key	0Dh
	irp	x,<71,72,73,75,77,79,80>
	fn	x
	endm
	
; following are pf1-pf24 function keys
	irp	x,<160,161,162,163,164,165,166,167,168,169,170,171>
	fnx	x
	endm
	irp	x,<172,173,174,175,176,177,178,179,180,181,182,183>
	fnx	x
	endm

	chklen	<shift case table length is wrong>

	SUBTTL	CTRL CASE OF KEYBOARD SCAN CODE TRANSLATION TABLE
	page

	dw	0, 0	; for PC alternate keys
CTRLTBL	label	word
	scan = 0
	
	nokey	0
	key	1Bh	;  1 Escape
	nokey	2
	key	00h	;  3 Ctrl-2
	nokey	4
	nokey	5
	nokey	6
	key	1Eh	;  7 Ctrl-6
	nokey	8
	nokey	9
	nokey	10
	nokey	11
	key	1Fh	; 12 Ctrl-'-'
	nokey	13
	key	7Fh	; 14 Ctrl-Backspace

	fn	094h	; 15 Ctrl-Tab

	irpc	x,<qwertyuiop[]>
	ctrlkey	'&x'
	endm

	key	0Ah	; 28 new-line
	
	spckey	ctrl

	irpc	x,<asdfghjkl>
	ctrlkey	'&x'
	endm

	nokey	39
	nokey	40
	nokey	41
	spckey	lshift
	ctrlkey	'<'

	irpc	x,<zxcvbnm>
	ctrlkey	'&x'
	endm

	nokey	51
	nokey	52
	nokey	53

	spckey	rshift
	fn	114		; 55 Ctrl-PrScr acts like ^P

	spckey	alt
	key	' '
	spckey	caps

;	Control Function keys
	irp	x,<94,95,96,97,98,99,100,101,102,103>
	fn	x
	endm

	spckey	pause	; 69 ctrl-numlock = pause
	spckey	break	; 70 ctrl-scrollock = break
	
;	Control numpad keys
	irp	x,<77h,8Dh,84h,8Eh,73h,8Fh,74h,90h,75h,91h,76h,92h,93h>
	fn	x
	endm
	
	irp	x,<84,85,86>
	nokey	x
	endm

	fn	89h	; 87 ctrl-F11
	fn	8Ah	; 88 ctrl-F12
	
	irp	x,<89,90,91,92>
	nokey	x
	endm
	
	; cursor control without shifting or num-locking to numerals
	fn	118	; 93 ctrl-pgdn
	nokey	94
	nokey	95
	key	0Ah	; 96 ctrl-return
	fn	119	; 97 ctrl-home
	nokey	98
	fn	132	; 99 ctrl-pgup
	fn	115	;100 ctrl-left
	fn	116	;101 ctrl-right
	fn	117	;102 ctrl-end
	nokey	103

	; pf1 - pf24
	irp	x,<208,209,210,211,212,213,214,215,216,217,218,219>
	fnx	x
	endm
	irp	x,<220,221,222,223,224,225,226,227,228,229,230,231>
	fnx	x
	endm

	chklen	<Ctrl case table length is wrong>

	SUBTTL	ALT CASE OF KEYBOARD SCAN CODE TRANSLATION TABLE

	dw	0, 0	; for PC alternate keys
ALTTBL	label	word
	scan = 0
	
	nokey	0
	nokey	1	; 1 alt-esc
	
	; alt-1 thru alt-=  keys 2-13
	irp	x,<120,121,122,123,124,125,126,127,128,129,130,131>
	fn	x
	endm

	fn	0Eh	; 14 alt-backspace
	fn	0A5h	; 15 alt-tab
	
	;	alt-q, w, e, r, t, y, u, i, o, p
	irp	x,<16,17,18,19,20,21,22,23,24,25>
	fn	x
	endm
	
	nokey	26
	nokey	27
	fn	1Ch	; 28 alt-return
	spckey	ctrl
	
	;	alt-a, s, d, f, g, h, j, k, l
	irp	x,<30,31,32,33,34,35,36,37,38>
	fn	x
	endm
	fn	39	; 39 alt-';'
	fn	40	; 40 alt-'''
	fn	41	; 41 alt-'`'

	spckey	lshift
	nokey	43
	;	alt-z, x, c, v, b, n, m
	irp	x,<44,45,46,47,48,49,50>
	fn	x
	endm
	fn	51	; 51 alt-,
	fn	52	; 52 alt-.
	fn	53	; 53 alt-/
	spckey	rshift
	fn	55	; 55 alt-*

	spckey	alt
	key	' '
	spckey	caps

	; alt-function keys 59-68
	irp	x,<104,105,106,107,108,109,110,111,112,113>
	fn	x
	endm

	spckey	pause
	spckey	break
	spckey	altnum
	spckey	altnum
	spckey	altnum
	fn	4Ah		; 74 Alt--
	spckey	altnum
	spckey	altnum
	spckey	altnum
	fn	4Eh		; 78 Alt-+
	spckey	altnum
	spckey	altnum
	spckey	altnum
	spckey	altnum
	fn	0A3h		; 83 Alt-del

	irp	x,<84,85,86>
	nokey	x
	endm
	fn	8Bh		; 87 Alt-F11
	fn	8Ch		; 88 Alt-F12
	irp	x,<89,90,91,92>
	nokey	x
	endm

	; cursor control without shifting or num-locking to numerals
	fn	118	; 93 ctrl-pgdn
	nokey	94
	nokey	95
	key	0Ah	; 96 ctrl-return
	fn	119	; 97 ctrl-home
	nokey	98
	fn	132	; 99 ctrl-pgup
	fn	115	;100 ctrl-left
	fn	116	;101 ctrl-right
	fn	117	;102 ctrl-end
	nokey	103

	; pf1 - pf24
	irp	x,<232,233,234,235,236,237,238,239,240,241,242,243>
	fnx	x
	endm
	irp	x,<244,245,246,247,248,249,250,251,252,253,254,255>
	fnx	x
	endm


	chklen	<Alt case table length is wrong>

	SUBTTL	CTRL-ALT CASE OF KEYBOARD SCAN CODE TRANSLATION TABLE
	page

	dw	0, 0	; for PC alternate keys
CALTTBL	label	word
	scan = 0

	nokey	0
	nokey	1
	irp	x,<2,3,4,5,6,7,8,9,10,11,12,13>
	nokey	x
	endm
	key	08h	; bs key
	nokey	15

	irp	x,<16,17,18,19,20,21,22,23,24,25,26,27>
	nokey	x
	endm
	nokey	28	; 28 enter key
	spckey	ctrl
	
	irp	x,<30,31,32,33,34,35,36,37,38,39,40>
	nokey	x
	endm
	key	'|'	; 41
	spckey	lshift
	
	irp	x,<43,44,45,46,47,48,49,50,51,52,53>
	nokey	x
	endm
	spckey	rshift
	fn	114		; 55 '*' also prtscr

	spckey	alt
	key	' '
	spckey	caps

	; ctrl-alt-function keys 59-68
	spckey	uskeyb		; 59 ctrl-alt-F1 revert to US keyboard
	irp	x,<105,106,107,108,109,110,111,112,113>
	fn	x
	endm

	spckey	pause
	spckey	break
	fn	119
	nokey	72
	fn	132
	nokey	74
	fn	115
	nokey	76
	fn	116
	nokey	78
	fn	117
	nokey	80
	fn	118
	nokey	82
	spckey	reboot

	irp	x,<84,85,86,87,88,89,90,91,92>
	nokey	x
	endm

	; cursor control without shifting or num-locking to numerals
	fn	118	; 93 ctrl-pgdn
	nokey	94
	nokey	95
	key	0Ah	; 96 ctrl-return
	fn	119	; 97 ctrl-home
	nokey	98
	fn	132	; 99 ctrl-pgup
	fn	115	;100 ctrl-left
	fn	116	;101 ctrl-right
	fn	117	;102 ctrl-end
	nokey	103

	; pf1 - pf24
	irp	x,<208,209,210,211,212,213,214,215,216,217,218,219>
	fnx	x
	endm
	irp	x,<220,221,222,223,224,225,226,227,228,229,230,231>
	fnx	x
	endm

	chklen	<Ctrl-Alt case table length is wrong>


	subttl	INITIALIZATION
	page

	; from instmsg beyond is not retained in TSR

instmsg	DB	'PC-MOS UNITED KINGDOM Keyboard Driver (v4.11)',13,10 ;@@XLAT
	DB	'(C) Copyright 1987-1991 The Software Link, Incorporated',13,10,'$' ;@@XLAT

	include	moskbinz.inc	; include initialization code

code	ends
	end	BEGIN
