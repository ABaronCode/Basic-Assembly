.data  
   string1:    .asciiz "Hello "  
   string2:    .asciiz "World!"  
   finalStr:   .space 256   
.text  
.globl main
 main:  
   la $s1, finalStr  
   la $s2, string1  
   la $s3, string2   
copyFirstString:  
   lb $t0, ($s2)          
   beqz $t0, copySecondString
   sb $t0, ($s1)            
   addi $s2, $s2, 1      
   addi $s1, $s1, 1    
   j copyFirstString             

copySecondString:  
   lb $t0, ($s3)          
   beqz $t0, printString
   sb $t0, ($s1)            
   addi $s3, $s3, 1      
   addi $s1, $s1, 1    
   j copySecondString

printString:
	li $v0, 4
	la $a0, finalStr
	syscall
	
	li $v0, 10
	syscall
