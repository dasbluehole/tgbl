%define NUM_OF_USER_SECTORS 14
%define INCLUDE_COMMON
%define INCLUDE_TEXT
%define INCLUDE_KEYBOARD
%define INCLUDE_TIME
; Include pictures module
%define INCLUDE_PICTURE
%include "tgbl_main.asm"
tgblm_start main

main:
	call tgbl_initVGA
	tgblm_hideCursor
	call initKeys

	call drawText

	.mainLoop:
		call tgbl_keyboardHandler
		tgblm_sleep 10
		jmp .mainLoop
	hlt

initKeys:
	call tgbl_clearKeyHandlersTable
	tgblm_initKey KEY_ESC, ESC_key_handler
	tgblm_initKey KEY_M, M_key_handler
	tgblm_initKey KEY_A, A_key_handler
	ret

ESC_key_handler:
	call tgbl_shutdown

M_key_handler:
	tgblm_drawPicture MonaLisa, 0, 0
	ret

A_key_handler:
	tgblm_drawPicture Ancap, 2, 12
	ret

drawText:
	tgblm_printString l1, FG_LGRAY, scrHMid - 1, scrWMid - l1_len / 2
	tgblm_printString l2, FG_LGRAY, scrHMid, scrWMid - l2_len / 2
	tgblm_printString l3, FG_LGRAY, scrHMid + 1, scrWMid - l3_len / 2
	ret

tgblm_endSector 1, main

; Constants
constSector:
tgblm_addConstString l1, "Press M to draw Mona Lisa"
tgblm_addConstString l2, "Press A to draw Ancap Meme"
tgblm_addConstString l3, "Press ESC to shutdown"
tgblm_addPicture MonaLisa, "mona_lisa.pic"
tgblm_addPicture Ancap, "ancap.pic"

tgblm_endSector 13, constSector
