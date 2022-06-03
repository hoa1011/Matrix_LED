ORG 0000h
	ljmp RST_INT
ORG 0030h
	;dung R0 luu gia tri hang, R1 luu gia tri cot, R2 luu so lan lap ham nhan nut
	main_pro:
	;-- Kiem tra xem co su bien dong dong gi cua tin hieu den cot hay khong (Dam bao cho viec hang truoc cot sau)
	;-- Kiem tra lien tuc -> Muc dich xem co nhan nut xu ly hang cot khong
	mov A,P2 ; Dua tin hieu port 2 vao thanh ghi A de xu ly
	anl A,#00001111b ;AND thanh ghi A voi 0000 1111 de kiem tra xem co su thay doi o P2 khong
	cjne A,#00h, skip ;co su thay doi P2(A khac 0) thi nhay sang ham skip de xu ly nut nhan cot
	lcall nhannut1 ;goi ham nhan nut 1 nut nhan index hang
	
	mov P0,R0	; -- P0 = R0 dua gia tri chua trong thanh ghi R0 ra P0
	ljmp skip1 ; nhay toi ham skip1 quay lai chuong trinh chinh kiem tra nut cot khong thi nhay toi ham nhan nut hang
	skip:
	lcall nhannut2
	mov P2,R1	; sau khi xu ly xong dua R1 ra P2
	skip1:
	ljmp main_pro
	
	;-- Cac ham xu ly nut nhan
	
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
	mov R0,#00001111b
	clr A
	ret
	
	nhannut2:
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan2
	ljmp nhannut2
	
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

	delay500ms:
	; su dung timer 1 che do 1
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
