
ORG 0000h
	ljmp RST_INT
ORG 0030h
	;dung R0 luu gia tri hang, R1 luu gia tri cot, R2 luu so lan lap ham nhan nut
	main_pro:
	lcall nhannut1
	mov P0, R0
	lcall nhannut2
	mov P2, R1
	lcall delay1s ;delay 2s cho led ma tran sang dung 2s roi tat
	lcall delay1s

	mov 80h, #00h	
	mov 0A0h, #00h 
	mov 90h, #00h	
	ljmp main_pro
	
	nhannut1:
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan1
	ljmp nhannut1
	
	duocnhan1:
	lcall delay
	mov A, 0B0h
	anl A, #0FH
	cjne A, #0Fh, kiemtra1
	sjmp chongdoi1
	
	
	chongdoi1:
	lcall delay
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan1
	sjmp chongdoi1
	
	RST_INT:
	mov 80h, #00h	;Khoi tao gia tri ban dau cho cot LED khi chua nhan nut
	mov 0A0h, #00h ;Khoi tao gia tri ban dau cho hang LED khi chua nhan nut
	mov 90h, #00h	;Khoi tao gia tri ban dau cho cot LED khi chua nhan nut
	ljmp main_pro
	
	
	kiemtra1:
	cjne A, #00001110b, two1
	anl A, #00001000b
	mov R0,A
	clr A
	ret
	
	two1:
	cjne A, #00001101b, three1
	anl A, #00001100b
	mov R0, A
	clr A
	ret
	
	three1:
	cjne A, #00001011b, four1
	anl A, #00001000b
	add A, #00000110b
	mov R0, A
	clr A
	ret
	
	four1:
	; 4: 0000 0111
	anl A, #00000000b
	add A, #00001111b
	mov R0,A
	clr A
	ret
	
	nhannut2:
	mov A, 0B0h
	anl A, #0F0h
	cjne A, #0F0h, duocnhan2
	ljmp nhannut2
	
	duocnhan2:
	lcall delay
	mov A, 0B0h
	anl A, #0F0H
	cjne A, #0F0h, kiemtra2
	sjmp chongdoi2
	
	
	chongdoi2:
	lcall delay
	mov A, 0B0h
	anl A, #0F0h
	cjne A, #0F0h, duocnhan2
	sjmp chongdoi2
	

	
	kiemtra2:
	cjne A, #11100000b, two2
	anl A, #10000000b
	mov R1,A
	clr A
	ret
	
	two2:
	cjne A, #11010000b, three2
	anl A, #11000000b
	mov R1, A
	clr A
	ret
	
	three2:
	cjne A, #10110000b, four2
	anl A, #10000000b
	add A, #01100000b
	mov R1, A
	clr A
	ret
	
	four2:
	; 4: 0000 0111
	anl A, #00000000b
	add A, #11110000b
	mov R1,A
	clr A
	ret
	

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