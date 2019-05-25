# Title: Questao 1 do trabalho pratico de Arquitetura de Computadores II		Filename: Ex1.asm
# Author: Davi Horner, Lucas Neves, Thiago Luigi					Date: 18/05/2019
# Description: Um inteiro positivo n eh dito perfeito, se ele for igual a soma de seus divisores positivos diferentes de n.
# Dado um inteiro positivo n, o programa verifica se n eh perfeito.
# Input: Um numero inteiro positivo.
# Output: Diz se eh perfeito.
################### Data segment ###################
.data
Numero:		.asciiz "Entre com o numero: "
EhPerfeito:	.asciiz "O numero eh perfeito."
NaoEhPerfeito:	.asciiz "O numero nao eh perfeito."
################### Code segment ###################
.text
.globl main
	main:
		# Leitura do numero
		la $a0,Numero
		li $v0,4
		syscall
		li $v0,5
		syscall
		move $t0,$v0				# t0 = n
	
		# Iterador do Loop
		add $t1,$zero,$zero
		add $t1,$t1,1				# t1 = i		# Comeca com 1
		add $t2,$zero,$zero			# t2(soma) = 0

		# Loop que vai de 1 ate n verificando se sao divisores de n e adicionando a soma se for divisor
		Loop:
			div $t0,$t1
			mfhi $t3
			beqz $t3,Divisor
			Incremento:
			add $t1,$t1,1
			blt $t1,$t0, Loop
		beq $t2,$t0,NumeroEhPerfeito
		j NumeroNaoEhPerfeito
	
	# Informa que o numero eh perfeito
	NumeroEhPerfeito:
		li $v0,4
		la $a0,EhPerfeito
		syscall
		j Exit
	
	# Informa que o numero nao e perfeito
	NumeroNaoEhPerfeito:
		li $v0,4
		la $a0,NaoEhPerfeito
		syscall
		j Exit
	
	# Adiciona o número a soma se ele for divisor
	Divisor:
		add $t2,$t2,$t1
		j Incremento
	
	# Fecha o programa
	Exit:
		li    $v0,10
		syscall
