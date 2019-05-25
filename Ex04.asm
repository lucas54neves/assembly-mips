# Title: Questao 4 do trabalho pratico de Arquitetura de Computadores II		Filename: Ex4.asm
# Author: Davi Horner, Lucas Neves, Thiago Luigi					Date: 18/05/2019
# Description: Programa que calcule a potencia de um numero inteiro m elevado a potencia de outro numero inteiro n.
# Input: Dois numeros inteiros.
# Output: O resultado do primeiro numero elevado ao segundo
################### Data segment ###################
.data
	Base: .asciiz "Informe a base da exponenciacao: "
	Expoente: .asciiz "Informe o expoente positivo da exponenciacao: "
	Resultado: .asciiz "Resultado da exponenciacao eh: "
################### Code segment ###################
.text
.globl main
	main:
		# Leitura da base
		la $a0,Base
		li $v0,4
		syscall
		li    $v0,5
		syscall
		move  $t0,$v0
	
		# Leitura do expoente
		la $a0,Expoente
		li $v0,4
		syscall
		li $v0,5
		syscall
		move $t1,$v0
	
		# $t2 comeca com 1 para ser multiplicado pela base
		# Ou retorna 1 se o expoente for 0
		add $t2,$zero,1
	
		# Se o expoentente for zero, o resultado eh 1
		beqz $t1,Exit
	
		# Iterador do Loop
		add $t3,$zero,$zero
	
		Loop:	mul $t2,$t2,$t0
			add $t3,$t3,1
		blt $t3,$t1 Loop
	
	# Imprime o resultado
	li $v0,4
	la $a0,Resultado
	syscall
	li $v0,1
	move $a0,$t2
	syscall
	
	# Fecha o programa
	Exit:	li    $v0,10
		syscall
