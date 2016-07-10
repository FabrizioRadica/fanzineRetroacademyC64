;****************************
;* TextRreade by Fabrizio Radica - 10-07-2016
;* Not optimized code
;* 
;*
;* http://www.retroacademy.it
;* https://www.facebook.com/retroacademy/
;*
;****************************


	processor 6502
	org $0801 ;indirizzo del Basic
	;Stringa BASIC che invoca il SYS all'indirizzo di partenza del prg
	;In questo caso SYS2080 (org $8020)
	;e poi firmo il programma (visualizzabile aprendo il file con un HEX Editor)
	.byte $0c,$08,$0a,$00,$9e,"2080",$0,"2012 by Fabbroz75"
		
	org  $0820 ;SYS2080 in basic
		

initSID = $1000
playSID = $1003


;Inizializzo
start
	
	sei
	lda #$00

clrspr  
	lda #$00
	sta $3000,x ;cancello area sprites
	inx			; incremento x
	bne clrspr	
	tax 
clear    
	lda #$20    ;Cancella lo schermo 
    sta $0400,x ; 
    sta $0500,x ; 
    sta $0600,x ; 
    sta $06e8,x ;
    inx         
    bne clear      

;Schermo nero
    txa			;copio il valore 0 nell'Accumulatore
    sta $d020
    sta $d021 

	ldx #$000
	ldx #$000

write:
		lda txt,x		
		and #$3f

		cmp "@"
		beq loop

		sta $0400+80,x
		sta $d800+80,x

		;lda #1
		;sta $d800+80,x

		inx 
		cpx #255
		bne write  


loop
	jsr playSID

raster
	lda #$40
	cmp $d012
	bne *-3

	jmp loop


txt
	.text "Ciao a tutti gli utenti RetroAcademy. Siamo orgogliosi di presentarvi, in assoluta controtendenza, una raccolta di news ed eventi sfogliabile e visualizzabile direttamente sul vostro Commodore 64 (e presto anche MSX e Amstrad)! Stiamo lavorando per VOI!!!"

txt2
	.text "Staff RetroAcademy"

	org $1000-$7e
    INCBIN "Xain_d_Sleena.sid"
