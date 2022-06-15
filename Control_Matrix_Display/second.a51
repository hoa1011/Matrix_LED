
	

ORG 0000h
	ljmp RST_INT
ORG 0030h
	;dung R0 luu gia tri hang, R1 luu gia tri cot, R2 luu so lan lap ham nhan nut
	main_pro:
	lcall nhannut

	ljmp main_pro
	
	nhannut:
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan
	ljmp nhannut
	
	duocnhan:
	lcall delay
	mov A, 0B0h
	anl A, #0FH
	cjne A, #0Fh, kiemtra
	sjmp chongdoi
	
	; code chua hoan thien chuc nag reset chua dung duoc 
	RST_INT:
	mov 80h, #00h	;Khoi tao gia tri ban dau cho cot LED khi chua nhan nut
	mov 0A0h, #00h ;Khoi tao gia tri ban dau cho hang LED khi chua nhan nut
	mov 90h, #00h	;Khoi tao gia tri ban dau cho cot LED khi chua nhan nut
	ljmp main_pro
	
	
	kiemtra:
	; TH khi A = 0000|0111b
	cjne A, #00001110b, two
	anl A, #00001000b
	mov R1,A
	clr A
	ljmp display

	
	two:
	cjne A, #00001101b, three
	anl A, #00001100b
	mov R1, A
	clr A

	ljmp display
	
	three:
	cjne A, #00001011b, four
	anl A, #00001000b
	add A, #00000110b
	mov R1, A
	clr A

	ljmp display
	
	four:
	; 4: 0000 0111
	anl A, #00000000b
	add A, #00001111b
	mov R1,A
	clr A
	
	ljmp display
	
	display:
	mov P2, R1
	ret

	
	chongdoi:
	lcall delay
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan
	sjmp chongdoi
	
	;delay ngan
	delay:
	mov R2, #20
	loop1:
	mov R3, #250
	loop2:
	djnz R3, loop2
	djnz R2, loop1
	ret
	
	
	;delay
	delay1s:
	; su dung timer 1 che do 1
	mov R6, #005h
	loop5:
	mov R5, #0C8h
	loop4:
	mov TMOD, #01h
	mov TH0, #0FCh
	mov TL0, #018h
	setb TR0
	loop_1ms:
	jnb TF0, loop_1ms
	clr TF0
	clr TR0
	djnz R5, loop4
	djnz R6, loop5
	ret

END