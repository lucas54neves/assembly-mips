# Title: Questao 6 do trabalho pratico de Arquitetura de Computadores II		Filename: Ex6.asm
# Author: Davi Horner, Lucas Neves, Thiago Luigi					Date: 18/05/2019
# Description: Programa que determine o montante de capital ao final de cada ano durante 10 anos.
# Input: Dois numeros decimais, a taxa e o valor aplicado
# Output: O montante de cada ano
################### Data segment ###################
.data
	Taxa:		.asciiz	"Informe a taxa de juros ao ano [A taxa deve estar em decimal]: "
	Valor:		.asciiz	"Informe o valor aplicado: "
	Resultado:	.asciiz	"\nO montante eh: "
	Um:		.float 1.0
	Zero:		.float 0.0
################### Code segment ###################
.text
.globl main
	main:	
		# f2 = 1
		lwc1 $f2,Um
		# f18 = 0
		lwc1 $f18,Zero
									
		# Mostra a mensagem pedindo a taxa
		la $a0,Taxa
		li $v0,4
		syscall
	
		# Le a taxa
		li $v0,6
		syscall
		# f4 = taxa
		mov.d $f4,$f0
	
		# Mostra a mensagem pedindo o valor aplicado
		la $a0,Valor
		li $v0,4
		syscall
	
		# Le o valor aplicado
		li $v0,6
		syscall
		# f6 = valor
		mov.d $f6,$f0
	
		add $t1,$zero,$zero
		add.s $f16,$f18,$f2
		Loop:	
			# f8 = taxa * periodo
			mul.s $f8,$f16,$f4
			# f10 = Capital * taxa * periodo
			mul.s $f10,$f8,$f6
			# Montante = Capital + Capital * taxa * periodo
			add.s $f14,$f10,$f6
		
			li $v0,4
			la $a0,Resultado
			syscall
			li $v0,2
			mov.d $f12,$f14
			syscall
		
			# Incrementa o periodo de um ano
			add.s $f16,$f16,$f2				
			
			# Incrementa o contador
			add $t1,$t1,1
			
			blt $t1,10,Loop
		
		li    $v0,10	# exit
		syscall
