org 0x7e00
jmp 0x0000:start

data:
	titulo db 'Snake 10', 0
	score db 'score: ',0
	pontosPrint times 3 db '0', 0

	sHead times 2 dd 60
	sTail times 2 dd 60
	sFood times 2 dd 0
	tam times 1 dd 0

	state times 2 db 0

	;y - 30 até 185
	;x -  5 até 310
	posix times 8 dd 300, 40, 100, 175, 50, 65, 275, 150
	posiy times 8 dd 170, 100, 50, 80, 65, 130, 45, 150
	
	;strings para o menu 
	startG db 'Start', 0
	instrucions db 'Instrucions', 0
	credits db 'Credits', 0
	instru0 db 'Press:', 0
	instru1 db 'W -> Move Up', 0
	instru2 db 'S -> Move Down', 0
	instru3 db 'D -> Move Right', 0
	instru4 db 'A -> Move Left', 0
	instru5 db 'You die if you touch the borders.', 0
	cred0 db 'Natalia Soares', 0
	cred1 db 'Daniel Perazzo', 0
	cred2 db 'Matheus Albuquerque', 0
	;-------------------------------
	win db 'You Win!', 0
	lose db 'You Lose!', 0

	white equ 15
	black equ 0
	yellow equ 14
	green equ 10
	blue equ 1
	red equ 12

delay:
	mov bp, 50
	mov dx, 70
	delay2:
		dec bp
		nop
		jnz delay2
	dec dx
	jnz delay2

ret


initVideo:
	
	mov al, 13h
	mov ah, 0
	int 10h
ret

print_pixel:
	
	mov ah, 0Ch
	int 10h
ret


printString:
	
	lodsb
	mov cl, 0
	cmp cl, al
	je .done
	
	mov ah, 0xe
	int 0x10
	jmp printString
	
	.done:
ret

prepareStringBox: ;set coordinates in dl and dh, set color in bl

	mov bh,0
	mov  ah, 02h
	int  10h
	
ret

	


LimpaArea:

	push dx
	push cx

	mov dx, 0

	.loop1:

		cmp dx, 200
		je .end1

		mov cx, 0

		.loop2:
		
			cmp cx, 320
			je .end2

			call print_pixel
			inc cx
			jmp .loop2

		.end2:

		inc dx
		jmp .loop1

	.end1:

	pop cx
	pop dx
ret

read_char:
    
    mov ah, 0
    int 16h
ret

drawPers:

	push cx
	push dx
	
	mov bx, dx
	add bx, 10

	.forpers1:

		cmp dx, bx
		je .endforpers1

		push bx
		mov bx, cx
		add bx, 10

		.forpers2:

			cmp cx, bx
			je .endforpers2

			call print_pixel
			inc cx

			jmp .forpers2

		.endforpers2:

		sub cx, 10
		pop bx

		inc dx
		jmp .forpers1

	.endforpers1:

	pop dx
	pop cx
ret

drawComida:

	push cx
	push dx
	
	mov bx, dx
	add bx, 2

	.forcomida1:

		cmp dx, bx
		je .endforcomida1

		push bx
		mov bx, cx
		add bx, 2

		.forcomida2:

			cmp cx, bx
			je .endforcomida2

			call print_pixel
			inc cx

			jmp .forcomida2

		.endforcomida2:

		sub cx, 2
		pop bx

		inc dx
		jmp .forcomida1

	.endforcomida1:

	pop dx
	pop cx
ret

printaTela:
 
    mov al,blue
 
    mov cx,0
    mov dx,25
 
   
 
 
 
    printTelaQuad1Loop1:
 
        cmp dx,30
        je endQuad1PrintTelaLoop1
 
        mov cx,0
 
 
        printTelaQuad1Loop2:
 
 
            cmp cx, 320
            je endQuad1PrintTelaLoop2
 
            call print_pixel
           
            inc cx
 
            jmp printTelaQuad1Loop2
 
 
 
        endQuad1PrintTelaLoop2:
 
 
        inc dx
 
        jmp printTelaQuad1Loop1
 
 
 
 
    endQuad1PrintTelaLoop1:
 
    mov cx,0
    mov dx,30
 
 
 
    printTelaQuad2Loop1:
 
        cmp dx,200
        je endQuad2PrintTelaLoop1
 
        mov cx,0
 
 
        printTelaQuad2Loop2:
 
 
            cmp cx, 5
            je endQuad2PrintTelaLoop2
 
            call print_pixel
           
            inc cx
 
            jmp printTelaQuad2Loop2
 
 
 
        endQuad2PrintTelaLoop2:
 
 
        inc dx
 
        jmp printTelaQuad2Loop1
 
 
 
 
    endQuad2PrintTelaLoop1:
 
    mov cx,315
    mov dx,30
 
 
 
    printTelaQuad3Loop1:
 
        cmp dx,200
        je endQuad3PrintTelaLoop1
 
        mov cx,315
 
 
        printTelaQuad3Loop2:
 
 
            cmp cx, 320
            je endQuad3PrintTelaLoop2
 
            call print_pixel
           
            inc cx
 
            jmp printTelaQuad3Loop2
 
 
 
        endQuad3PrintTelaLoop2:
 
 
        inc dx
 
        jmp printTelaQuad3Loop1
 
 
 
 
    endQuad3PrintTelaLoop1:
 
    mov cx,0
    mov dx,195
 
    printTelaQuad4Loop1:
 
        cmp dx,200
        je endQuad4PrintTelaLoop1
 
        mov cx,0
 
 
        printTelaQuad4Loop2:
 
 
            cmp cx, 320
            je endQuad4PrintTelaLoop2
 
            call print_pixel
           
            inc cx
 
            jmp printTelaQuad4Loop2
 
 
 
        endQuad4PrintTelaLoop2:
 
 
        inc dx
 
        jmp printTelaQuad4Loop1
 
 
 
 
    endQuad4PrintTelaLoop1:
 
    mov  dl, 27
    mov  dh, 1
    mov  bh, 0
    mov  bl, white
 
    call prepareStringBox
 
    mov si, score
    call printString
 
    mov  dl, 3
    mov  dh, 1
    mov  bh, 0
    mov  bl, white
 
    call prepareStringBox
 
    mov si,titulo
    call printString
 
   
   
 
 
    ret


menu:
	mov al, black
	call LimpaArea

	mov  dl, 12 ;x
	mov  dh, 9 ;y
	mov  bh, 0 
	mov  bl, green ;cor
	call prepareStringBox
	mov si, titulo
	call printString

	.Play:
		;mov al, black
		;call LimpaArea
		mov  dl, 12 ;x
		mov  dh, 9 ;y
		mov  bh, 0 
		mov  bl, green ;cor
		call prepareStringBox
		mov si, titulo
		call printString

		mov dl, 12
		mov dh, 15
		mov bh, 0
		mov bl, red
		call prepareStringBox
		mov si, startG
		call printString
		
		mov dl, 12
		mov dh, 18
		mov bh, 0
		mov bl, white
		call prepareStringBox
		mov si, instrucions
		call printString

		mov dl, 12
		mov dh, 21
		mov bh, 0
		mov bl, white
		call prepareStringBox
		mov si, credits
		call printString
		call read_char

		cmp al,115
		je .Instruc
		
		cmp al, 13
		je .endmenu

		jmp .Play

	.Instruc:
		;mov al, black
		;call LimpaArea

		mov  dl, 12 ;x
		mov  dh, 9 ;y
		mov  bh, 0 
		mov  bl, green ;cor
		call prepareStringBox	
		mov si, titulo
		call printString


		mov dl, 12
		mov dh, 15
		mov bh, 0
		mov bl, white
		call prepareStringBox
		mov si, startG
		call printString
		
		mov dl, 12
		mov dh, 18
		mov bh, 0
		mov bl, red
		call prepareStringBox
		mov si, instrucions
		call printString

		mov dl, 12
		mov dh, 21
		mov bh, 0
		mov bl, white
		call prepareStringBox
		mov si, credits
		call printString	

		call read_char
		cmp al, 119 ;w==19
		je .Play
		cmp al, 115 ; s== 115
		je .Cred
		cmp al, 13
		je .printInstruct
		
		jmp .Instruc

		.printInstruct:
			mov al, black
			call LimpaArea

			mov dl, 12
			mov dh, 5
			mov bh, 0
			mov bl, green
			call prepareStringBox
			mov si, instrucions
			call printString

			mov dh, 8
			mov bl, white
			call prepareStringBox
			mov si, instru0
			call printString

			mov dh, 11
			call prepareStringBox
			mov si, instru1
			call printString

			mov dh, 14
			call prepareStringBox
			mov si, instru2
			call printString

			mov dh, 17
			call prepareStringBox
			mov si, instru3
			call printString

			mov dh, 20
			call prepareStringBox
			mov si, instru4
			call printString

			mov dl, 5
			mov dh, 23
			call prepareStringBox
			mov si, instru5
			call printString

			call read_char

			mov al, black
			call LimpaArea

			jmp .Instruc

	.Cred:
	;	mov al, black
	;	call LimpaArea

		mov  dl, 12 ;x
		mov  dh, 9 ;y
		mov  bh, 0 
		mov  bl, green ;cor
		call prepareStringBox
		mov si, titulo
		call printString

		mov dl, 12
		mov dh, 15
		mov bh, 0
		mov bl, white
		call prepareStringBox
		mov si, startG
		call printString
	
		mov dl, 12
		mov dh, 18
		mov bh, 0
		mov bl, white
		call prepareStringBox
		mov si, instrucions
		call printString

		mov dl, 12
		mov dh, 21
		mov bh, 0
		mov bl, red
		call prepareStringBox
		mov si, credits
		call printString	

		call read_char

		cmp al, 119 ;w==19
		je .Instruc
		cmp al, 13
		je .printCred

		jmp .Cred
		.printCred:
			mov al, black
			call LimpaArea

			mov dl, 12
			mov dh, 5
			mov bh, 0
			mov bl, green
			call prepareStringBox
			mov si, credits
			call printString
			
			mov dh, 8
			mov bl, white
			call prepareStringBox
			mov si, cred0
			call printString

			mov dh, 11
			call prepareStringBox
			mov si, cred1
			call printString

			mov dh, 14
			call prepareStringBox
			mov si, cred2
			call printString

			call read_char

			mov al, black
			call LimpaArea

			jmp .Cred
	.endmenu:

ret


initiate:

	mov byte [state], 0 

	mov al,black
	call LimpaArea

	call printaTela

	mov  dl, 33
	mov  dh, 1
	mov  bh, 0
	mov  bl, white
	call prepareStringBox
	mov si, pontosPrint
	call printString

	mov word [sFood+0],20
	mov word [sFood+4],150

	mov cx,[sFood+0]
	mov dx,[sFood+4]

	mov al,red

	call drawComida

	mov word [sHead+0],200
	mov word [sHead+4],160
	mov word [sTail+0],200
	mov word [sTail+4],160


	movement:
		mov cx,[sHead+0]
		mov dx,[sHead+4]

		mov al,green 

		call drawPers

		call delay

		mov al,[state]


		mov ah, 01h ; checks if a key is pressed
		int 16h
		jz end_pressed ; zero = no pressed

		mov ah, 00h ; get the keystroke
		int 16h

		mov byte[state],al

		end_pressed:

		call delay


		.nextS:

			cmp al,115
			jne .nextW

			mov al,green

			mov cx,[sTail+0]
			mov dx,[sTail+4]
			mov al,black
			call drawPers

			


			add word [sHead+4], 5
			add word [sTail+4], 5

			;push cx
			;push dx

	
			cmp dx, [sFood+4]
			jle .comparaY
			jne .fim


			;mov word [sTail+0],[sHead+0]
			;push dx
			;mov word [sHead+4], dx

		.nextW:

			cmp al,119
			jne .nextD


			mov cx,[sTail+0]
			mov dx,[sTail+4]
			mov al,black
			call drawPers

			mov al,green
			add word [sHead+4], -5
			add word [sTail+4], -5

			;push cx
			;push dx

	
			cmp dx, [sFood+4]
			jle .comparaY
			jne .fim


		.nextD:

			cmp al,100
			jne .nextA



			mov cx,[sTail+0]
			mov dx,[sTail+4]
			mov al,black
			call drawPers

			mov al,green
			add word [sHead+0], 5
			add word [sTail+0], 5
			
			;push cx
			;push dx

			cmp cx, [sFood+0]
			jle .comparaX
			jne .fim

		.nextA:

			cmp al,97
			jne .fim

			mov cx,[sTail+0]
			mov dx,[sTail+4]
			mov al,black
			call drawPers

			mov al,green
			add word [sHead+0], -5
			add word [sTail+0], -5

			;push cx
			;push dx

			cmp cx, [sFood+0]
			jle .comparaX
			jne .fim
		
		.comparaX:
			add cx, 9
			cmp cx, [sFood+0]
			jge .comparaY1
			jle .fim
		.comparaY1:
			cmp dx, [sFood+4]
			jle .comparaY2
			jge .fim
		.comparaY2:
			add dx, 9
			cmp dx, [sFood+4]
			jge .comeu
			jle .fim


		.comparaY:
			add dx, 9
			cmp dx, [sFood+4]
			jge .comparaX1
			jle .fim	
		.comparaX1:
			cmp cx, [sFood+0]
			jle .comparaX2
			jge .fim
		.comparaX2:
			add cx, 9
			cmp cx, [sFood+0]
			jge .comeu
			jle .fim


		.comeu:
			add byte [pontosPrint],1
			cmp byte [pontosPrint], '9'
			je .printWin

			mov cx,[sFood+0]
			mov dx, [sFood+4]
			mov al,black
			call drawComida

			mov bx, [tam]
			mov cx, [posix+bx] 
			mov dx, [posiy+bx] 
			add word [tam], 4
			mov word [sFood+0], cx
			mov word [sFood+4], dx
	
			mov al,red
			call drawComida

			mov  dl, 33
			mov  dh, 1
			mov  bh, 0
			mov  bl, black
			call prepareStringBox
			call printString

			mov  dl, 33
			mov  dh, 1
			mov  bh, 0
			mov  bl, white
			call prepareStringBox
			mov si, pontosPrint
			call printString


		.fim:

			cmp al,113
			je start


		.NtOutofbounds1:
			cmp word[sHead+0], 5
			jge .NtOutofbounds2

			;add word [sHead+0], 5
			;add word [sTail+0], 5
			jmp .printLose

		.NtOutofbounds2:
			cmp word[sHead+0],305
			jle .NtOutofbounds3


			;sub word [sHead+0], 5
			;sub word [sTail+0], 5
			jmp .printLose

		.NtOutofbounds3:
			cmp word[sHead+4],30
			jge .NtOutofbounds4

			;add word [sHead+4], 5
			;add word [sTail+4], 5
			jmp .printLose

		.NtOutofbounds4:
			cmp word[sHead+4],185
			jle movement

			;sub word [sHead+4], 5
			;sub word [sTail+4], 5
			jmp .printLose
			;jmp movement

		.printLose:
			mov  dl, 15 ;x
			mov  dh, 9 ;y
			mov  bh, 0 
			mov  bl, red ;cor
			call prepareStringBox
			mov si, lose
			call printString
			call read_char
			mov byte [pontosPrint], '0'
			jmp .endgame
		
		.printWin:
			mov  dl, 33
			mov  dh, 1
			mov  bh, 0
			mov  bl, white
			call prepareStringBox
			mov si, pontosPrint
			call printString

			mov  dl, 15 ;x
			mov  dh, 9 ;y
			mov  bh, 0 
			mov  bl, green ;cor
			call prepareStringBox
			mov si, win
			call printString
			call read_char
			mov byte [pontosPrint], '0'
			jmp .endgame
	.endgame:
ret

start:
	
	call initVideo

	ini:
	call menu

	gameitself:

	call initiate

	jmp ini