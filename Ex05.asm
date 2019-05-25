# Title: Questao 5 do trabalho prático de Arquitetura de Computadores II		Filename: Ex5.asm
# Author: Davi Horner, Lucas Neves, Thiago Luigi					Date: 18/05/2019
# Description: Dado um inteiro nao-negativo n, o programa verifica se n eh triangular.
# Input: Um numero inteiro.
# Output: Diz se eh triangular ou nao
################### Data segment ###################
.data
	Numero:	.asciiz "Entre com o numero: "
	Triangular: .asciiz "O numero eh triangular"
	NaoTriangular: .asciiz "O numero nao eh triangular"
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
		# t0 = n
		move $t0,$v0
	
		# Iterador do Loop
		# t1 = i
		add $t1,$zero,1

		Loop:	
			# t2 = i + 1
			add $t2,$t1,1
			# t3 = i + 2
			add $t3,$t1,2
			mult $t2,$t1
			mflo $t4
			mult $t4,$t3
			# t4 = t1 * t2 * t3
			mflo $t4
			beq $t4,$t0,EhTriangular
			# t1 = t1 + 1
			add $t1,$t1,1
			blt $t1,$t4 Loop
	
	# Informa que nao eh triangular
	NaoEhTriangular:
		la $a0,NaoTriangular
		li $v0,4
		syscall
		j Exit
	
	# Informa que o numero eh triangular
	EhTriangular:
		la $a0,Triangular
		li $v0,4
		syscall

	# Fecha o programa
	Exit:
		li    $v0,10
		syscall
