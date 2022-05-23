; Progess: 
	;- Xong duoc phan xuat tin hieu cho lan nhan dau tien
	;- Chua code lan nhan thu 2 
; Kho khan:
	;- Gap nhieu van de RTC do co su dung transistor NPN de bao ve, nuoi den va khuech dai tin hieu
ORG 0000h
	ljmp RST_INT
ORG 0030h
	;dung R0 luu gia tri hang, R1 luu gia tri cot, R2 luu so lan lap ham nhan nut
	main_pro:
	mov 80h, #00h	;Khoi tao gia tri ban dau cho cot LED khi chua nhan nut
	mov 0A0h, #00h ;Khoi tao gia tri ban dau cho hang LED khi chua nhan nut
	mov 90h, #00h	;Khoi tao gia tri ban dau cho cot LED khi chua nhan nut
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan
	
	ljmp main_pro
	
	duocnhan:
	lcall delay
	mov A, 0B0h
	anl A, #0FH
	cjne A, #0Fh, kiemtra
	sjmp chongdoi
	
	; code chua hoan thien chuc nag reset chua dung duoc 
	RST_INT:

	ljmp main_pro
	
	
	kiemtra:
	; TH khi A = 0000|0111b
	cjne A, #00001110b, two
	anl A, #00001000b
	ljmp display
	
	two:
	cjne A, #00001101b, three
	anl A, #00001100b
	ljmp display
	
	
	three:
	cjne A, #00001011b, four
	anl A, #00001000b
	add A, #00000110b
	ljmp display
	
	four:
	; 4: 0000 0111
	anl A, #00000000b
	add A, #00001111b
	ljmp display	
	
	display:
	mov P2, A
	mov P0, A
	lcall delay
	ljmp display
	
	chongdoi:
	lcall delay
	mov A, 0B0h
	anl A, #0Fh
	cjne A, #0Fh, duocnhan
	sjmp chongdoi
	
	delay:
	; su dung timer 1 che do 1
	loop1:
	mov TMOD, #10h
	mov TH1, #0D8h
	mov TL1, #0F0h
	setb TR1
	loop2:
	jnb TF1, loop2
	clr TF1
	clr TR1
	ret
END
