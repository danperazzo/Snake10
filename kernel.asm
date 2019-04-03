org 0x7e00
jmp 0x0000:start

titulo db 'Snake 10', 0
score db 'score: ',0

sHead times 2 dd 60
sTail times 2 dd 60
tam dw 1

state times 2 db 0





white equ 15

black equ 0

yellow equ 14

green equ 10

blue equ 1

red equ 12



leftarrow equ $1E
rightarrow equ $20
uparrow equ $11
downarrow equ $1F

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

	mov  dl, 12
	mov  dh, 9
	mov  bh, 0
	mov  bl, green
	
	call prepareStringBox
	
	mov si, titulo
	call printString
	
	
	call read_char
	
	
ret









initiate:

	

	mov al,black
	call LimpaArea

	call printaTela

	mov dx,150
	mov cx,20

	mov al,red

	call drawComida

	mov word [sHead+0],60
	mov word [sHead+4],60
	mov word [sTail+0],60
	mov word [sTail+4],60





	movement:

	call delay

	mov cx,[sHead+0]
	mov dx,[sHead+4]

	mov al,green 

	call drawPers

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


	.fim:

		cmp al,113
		je start


	cmp word[sHead+0],5
	jge .NtOutofbounds1


	add word [sHead+0], 5
	add word [sTail+0], 5


	.NtOutofbounds2:

	cmp word[sHead+4],30
	jge .NtOutofbounds3


	add word [sHead+4], 5
	add word [sTail+4], 5

	.NtOutofbounds1:

	cmp word[sHead+0],305
	jle .NtOutofbounds2


	sub word [sHead+0], 5
	sub word [sTail+0], 5

	.NtOutofbounds3:

	cmp word[sHead+4],185
	jle .NtOutofbounds4


	sub word [sHead+4], 5
	sub word [sTail+4], 5

	.NtOutofbounds4:





	












	jmp movement






start:
	
	call initVideo

	ini:


	call menu

	gameitself:

	call initiate






	
	
	
	




