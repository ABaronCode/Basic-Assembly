#Alex Baronsky, PGRM Assignment 2, ICSI 404, Spring 2022

.data
	#Array
	infix: .space 40
	postfix: .space 40

	#Outputs
	msg: .asciiz "Input your expression: "
	msgTwo: .asciiz "Infix: "
	msgThree: .asciiz "Postfix: "
	msgFour: .asciiz "Evaluation of expression: "
	msgEquals: .asciiz " = "
	spacer: .asciiz "\n"
	
.text
.globl main
	input:
		#Print msg
		li $v0, 4
		la $a0, msg
		syscall
		
		#User input
		li $v0, 8

		#Load space for array and allocate space
		la $a0, infix
		li $a1, 40
		syscall 
		
		#print /n to space information
		li $v0, 4
		la $a0, msgTwo
		syscall
		
		#print out infix back to user
		li $v0, 4
		la $a0, infix
		syscall

	convertToPostfix:
		li $s1, '+'
		li $s2, '-'
		li $s3, '('
		li $s4, ')'
		li $s5, '\n'

		#counter to loop
		li $t0, -1
		#Load String
		la $s6, postfix

		#push all values from infix to stack
		push:
			addi $t0, $t0, 1	#counter		

			#hold character in t4
			lb $t4, infix($t0)

			#breakout if '\n'
			beq $t4, $s5, evaluate

			#check values if equal to operators or parenthesis
			beq $t4, $s1, operators
			beq $t4, $s2, operators
			beq $t4, $s3, parenL
			beq $t4, $s4, popOff

			#Operand management, there should be a way to check in another way but this works
			beq $t4, $t4, combineOperators

			j push

	evaluate:
		######
	output:	
		li $v0, 4
		la $a0, msgThree
		syscall
		
		li $v0, 4
		la $a0, postfix
		syscall

		li $v0, 4
		la $a0, spacer
		syscall

		#exit statement
		li $v0, 10
		syscall

	#######Managing stack#######
	#'+' and '-', this is possible because they have same precedence
	operators:
		addi $sp, $sp, -4
		sw $t4, 0($sp)	

		j push
	#'('
	parenL:
		addi $sp, $sp, -4
		sw $t4, 0($sp)	

		j push
	#Take the stuff off the stack and store into new string
	popOff:
		lw $t4, 0($sp)
		addi $sp, $sp, 4
		beq $t4,'(', push

		#######Replace this print statement with concatenate the value to the string we are building
		j combineStack

	#######Manage Output String#######
	#Add numbers to String
	combineOperators:
		sb $t4, ($s6)
		addi $s6, $s6, 1

		j push
	#All the stack that is not an array is added to ourpost
	combineStack:
		sb $t4, ($s6)
		addi $s6, $s6, 1

		j popOff