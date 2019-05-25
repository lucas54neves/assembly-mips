# Title: Questao 7 do trabalho pratico de Arquitetura de Computadores II		Filename: Ex7.asm
# Author: Davi Horner, Lucas Neves, Thiago Luigi					Date: 18/05/2019
# Description: Dado um inteiro positivo, o programa calcula o valor da soma.
# Input: Um numero inteiro.
# Output: Um numero ponto flutuante.
################### Data segment ###################
.data
	Numero:		.asciiz "Informe o numero: "
	Resultado:	.asciiz "Resultado da soma eh: "
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
	
		# Mostra a mensagem pedindo o numero
		la $a0,Numero
		li $v0,4
		syscall
	
		# Le a numero
		li $v0,6
		syscall
		# f6 = numero
		mov.d $f6,$f0
		
		# numerador = 1
		add.s $f8,$f4,$f2
		# denominador = n
		add.s $f10,$f4,$f6
		# soma = 0
		add.s $f14,$f4,$f4
		
		Loop:
			# f16 = numerador / denominador
			div.s $f16,$f8,$f10
			# soma = soma + divisao	
			add.s $f14,$f14,$f16
			# incremento do numerador
			add.s $f8,$f8,$f2
			# decremento do denominador
			sub.s $f10,$f10,$f2
			c.le.s $f8,$f6
			bc1t Loop
		
		# Imprime o resultado
		li $v0,4
		la $a0,Resultado
		syscall
		li $v0,2
		mov.d $f12,$f14
		syscall
		
		# Fecha o programa
		li    $v0,10
		syscall
