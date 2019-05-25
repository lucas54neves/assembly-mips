# Title: Questao 10 do trabalho pratico de Arquitetura de Computadores II		Filename: Ex10.asm
# Author: Davi Horner, Lucas Neves, Thiago Luigi					Date: 18/05/2019
# Description: Os pontos (x, y) que pertencem a figura H (abaixo) sao tais que: x ≥ 0, y ≥ 0 e x^2 + y^2 ≤ 1.
# Dados n pontos reais (x, y), verifique se cada ponto pertence ou nao a H.
# Input: Um numero n que corresponde a quantidade de pontos para testar e n pontos.
# Output: Informacao se o ponto pertence a figura
################### Data segment ###################
.data
	Quantidade:	.asciiz "Informe a quantidade de pontos: "
	PontoX:		.asciiz "Informe a coordenada X: "
	PontoY:		.asciiz "Informe a coordenada Y: "
	Pertence:	.asciiz "Esse ponto pertence a figura.\n"
	NaoPertence:	.asciiz "Esse ponto nao pertence a figura.\n"
	UmAsFloat:	.float 1.0
	ZeroAsFloat:	.float 0.0
################### Code segment ###################
.text
.globl main
	main:
		# f2 = 1
		lwc1 $f2,UmAsFloat
		# f4 = 0
		lwc1 $f4,ZeroAsFloat
	
		# Mostra a mensagem pedindo o número
		la $a0,Quantidade
		li $v0,4
		syscall
	
		# Le a quantidade de pontos
		li    $v0,5
		syscall
		# t1 = quantidade de pontos
		move  $t1,$v0
		
		# t0 = 0 (Contador)
		add $t0,$zero,$zero
		
		Loop:
			# Mostra a mensagem pedindo a coordenada X
			la $a0,PontoX
			li $v0,4
			syscall
	
			# Le a numero
			li $v0,6
			syscall
			# f6 = coordenada x
			mov.d $f6,$f0
			
			# Mostra a mensagem pedindo a coordenada Y
			la $a0,PontoY
			li $v0,4
			syscall
	
			# Le a numero
			li $v0,6
			syscall
			# f8 = coordenada y
			mov.d $f8,$f0
			
			jal Verifica
			
			# Incrementa o contador
			add $t0,$t0,1
			blt $t0,$t1 Loop
		
		# Fecha o programa
		li    $v0,10
		syscall
	
	# Verifica se o ponto pertence a figura
	Verifica:
		c.lt.s $f6,$f4
		bc1t NaoEh
		c.lt.s $f8,$f4
		bc1t NaoEh
		mul.s $f6,$f6,$f6
		mul.s $f8,$f8,$f8
		add.s $f10,$f6,$f8
		c.lt.s $f2,$f10
		bc1t NaoEh
		
		# Mostra a mensagem informando que pertence a figura
		la $a0,Pertence
		li $v0,4
		syscall
		jr $ra
		
	NaoEh:
		# Mostra a mensagem informando que nao pertence a figura
		la $a0,NaoPertence
		li $v0,4
		syscall
		jr $ra
