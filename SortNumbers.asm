#Alex Baronsky/Programing Assignment ICSI 404
#Goal is to have user input 0 or any other number
#if 0 will sort stored array in descending order, ascending for any other number
#loop to check each value in an array to sort another to print to user

.data

	#variables
	str1:	.asciiz	"Enter 0 to sort in descending order.\n"
	str2:	.asciiz	"Any number different than 0 will sort in ascending order.\n"
	str3:	.asciiz	"\nBefore Sort: \n"
	str4:	.asciiz "\n\nAfter Sort:\n"
	str5:	.asciiz "\n"
	str6:	.asciiz " "

	length: .word 9
	list: .word 7, 9, 4, 3, 8, 1, 2, 5, 6

.text
.globl main
   start:
	#Print str1
	li	$v0, 4 #Tell system to print
	la	$a0, str1 #Tell system what to print
	syscall
	
	li	$v0, 4
	la 	$a0, str2
	syscall
	
	#Get integer input from user
	li 	$v0, 5 #Read int from console
	syscall
	
	#Store int in $t0->temp holder for int
	move	$t7, $v0

	#Print String 3
	li	$v0, 4
	la 	$a0, str3
	syscall

	#Bring the array into the program
	lw	$s7, length
	move	$s0, $zero #array address	
	move	$s1, $zero #loop counter initialize
	
   print_Arr:
	#declare temp to exit loop, since 9 variables in array we loop 9 from length
	beq	$s0, $s7, stackInitialize
	
	lw	$a0, list($s1)
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, str6
	syscall

	#increment counter
	addi	$s0, $s0, 1	#loop counter, use for
	addi	$s1, $s1, 4	#array pointer
	j print_Arr

   stackInitialize:
	addi $sp, $sp, 20
	sw $ra 16($sp)
	sw $s7, 12($sp)
	sw $s6, 8($sp)
	sw $s5, 4($sp)
	sw $s4, 0($sp)

	add $s4, $zero, $zero #counter for loop
	add $s6, $a0, $zero #array
	add $s7, $a1, $zero #pointer

   loopOne:
	addi $s5, $s4, -1
	sll $t1, $s5, 2
	add $t2, $s6, $t1

   loopTwo:
	lw $t3, 0($t2)
	lw $t4, 4($t2)

	sgt $t0, $t3, $t4
	bne $t0, $zero, alreadyAscending

   ascending:
	sw $t3, 4($t2)
	sw $t4, 0($t2)

   alreadyAscending:
	addi $s5, $s5, -1 #array pointer
	addi $t2, $t2, -4 #stack pointer
	
	sge $t0, $s4, $zero
	bne $t0, $zero, loopTwo

	addi $s4, $s4, 1
	slt $t0, $s0, $s3
	bne $t0, $zero, loopOne

   #Should return what command for what way to order($t9 register is holding user value)
   #check:
	#li	$v0, 4
	#la	$a0, str4
	#syscall

	#bne 	$zero, $t9, testOne #Test if NOT equal to 0
	#beq 	$zero, $t9, testTwo #Test if equal to 0
	#j exit

   exit:
	#Exit Calls
	li	$v0, 10
	syscall