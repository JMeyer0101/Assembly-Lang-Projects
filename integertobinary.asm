.data 


String1: .asciiz "Input a number in decimal form:	"
border: .asciiz "==========================================="

.text

main:	

	li $t9,2		#base 2 divisor
	li $t8,1		#counter for 32-n operation
	li $s7,4		#for moving pointer by x4
	li $s6,1		#counter for outputloop operation, should eventually equal s8
	li $s5,32		#used for 32-n operation
	li $s3,1



	

	la $a0,String1			#print string prompt
	li $v0,4
	syscall

	

	li $v0,5
	syscall

	add $a0,$v0,$0


	jal sub1

	


remainingzerocalc: sub $s4,$s5,$t8

	j remainingzeroloop

	
remainingzeroloop:	add $a0,$0,0	
			
			li $v0,1	
			syscall
			
		
			sub $s4,$s4,1
			beq $s4,$0,outputloop
			
			

			j remainingzeroloop





outputloop:  lw $a0,0($sp)		#load binary value from stack
		addi $sp,$sp,4		#increment stack pointer
		
		li $v0,1
		syscall			#print binary value
					
		addi $s6,$s6,1		#increase counter

		beq $s6,$t8,exit			#repeat for t8 times
		
		
		j outputloop
			
exit:  li $v0,10
		syscall	

sub1:   add $s0,$a0,$0			#take from a and work with input num, 
					#go back to main, pop out remainder


	addi $t8,$t8,1				#increment counter for 32-n operation



	div $s0,$t9			#perform division on userinput (s0, s9 = 2 for base 2)

	mflo $s2			#store dividend into s2
	mfhi $t2			#store remainder into t2

	sub $sp,$sp,4			#decrement stack pointer by 4
	sw $t2,0($sp)			#store remainder into stack
	

	

	add $a0,$s2,$0				#store s2 into a0 dividend into argument
	

	beq $a0,$0,RA			#if dividend is 0 then base change complete, jump to ra
	
	j sub1				#if divident is not 0 then sub1 will loop


	RA: jr $ra				#ra returns to main
		