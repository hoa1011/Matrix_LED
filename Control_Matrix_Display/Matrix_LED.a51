ORG 0000h
	ljmp RST_INT
ORG 0030h
	;dung R0 luu gia tri hang, R1 luu gia tri cot
	main_pro:
	mov A,P2 
	anl A,#00000001b
	cjne A,#00h, skip //A khac 0 thi nhay toi skip
	lcall nhannut1
	
	ljmp skip1
	skip:
	lcall nhannut2
	
	mov P1,R0
	mov P2,R1

	skip1:
	ljmp main_pro
	
	nhannut1:
	mov A, 0B0h //P3
	anl A, #0Fh //mask 
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
	mov 80h, #00h	;Khoi tao gia tri ban dau cho cot LED khi chua nhan nut //P0
	mov 0A0h, #00h ;Khoi tao gia tri ban dau cho hang LED khi chua nhan nut //P2
	mov 90h, #00h	;Khoi tao gia tri ban dau cho cot LED khi chua nhan nut //P1
	ljmp main_pro
	
	
	kiemtra1:
	cpl P2.0
	lcall delay500ms
	cjne A, #00001110b, two1
	mov R0,#00001000b
	clr A
	ret
	
	two1:
	cjne A, #00001101b, three1
	mov R0, #00001100b
	clr A
	ret
	
	three1:
	cjne A, #00001011b, four1
	mov R0, #00001110b
	clr A
	ret
	
	four1:
	; 4: 0000 0111
	mov R0,#00001111b
	clr A
	ret
	

	;-- sau khi nhan nut lan 1 ma sau 15s khong nhan nut lan 2
	;-- tu dong RST lai trang thai ban dau cua he thong
	nhannut2:
	mov R2, #15
	lap5s:
	mov R4, #005h
	lap1:
	mov R7, #0C8h
	lap2:	
	;-- Timer1 mode 1 working here
	mov TMOD, #10h
	mov TH1, #0FCh
	mov TL1, #018h
	setb TR1
	lapnhan2:
	;-- nhan phan hoi tu lan nhan 2 --
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan2 
	;------------------------------
	jnb TF1, lapnhan2
	clr TF1
	clr TR1
	djnz R7, lap2
	djnz R4, lap1
	djnz R2, lap5s
	cpl P2.0
	ljmp RST_INT
	
	

	
	duocnhan2:
	lcall delay
	mov A, 0B0h
	anl A, #0FH
	cjne A, #0Fh, kiemtra2
	sjmp chongdoi2
	
	
	chongdoi2:
	lcall delay
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan2
	sjmp chongdoi2
	

	
	kiemtra2:
	cpl P2.0
	lcall delay500ms
	cjne A, #00001110b, two2
	mov R1,#10000000b
	clr A
	ret
	
	two2:
	cjne A, #00001101b, three2
	mov R1, #11000000b
	clr A
	ret
	
	three2:
	cjne A, #00001011b, four2
	mov R1, #11100000b
	clr A
	ret
	
	four2:
	; 4: 0000 0111
	mov R1, #11110000b
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
	; su dung timer 0 che do 1
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

	delay500ms:
	; su dung timer 0 che do 1
	mov R6, #005h
	loop5a:
	mov R5, #064h
	loop4a:
	mov TMOD, #01h
	mov TH0, #0FCh
	mov TL0, #018h
	setb TR0
	loop_1msa:
	jnb TF0, loop_1msa
	clr TF0
	clr TR0
	djnz R5, loop4a
	djnz R6, loop5a
	ret

END
