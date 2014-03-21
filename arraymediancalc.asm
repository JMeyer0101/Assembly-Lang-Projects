.data

Array1: .space 40
string2:  .asciiz "enter number "
string1:  .asciiz "enter number of integers"
decimal:  .asciiz "."
string3:  .asciiz "\nmedian is:    "
newline:  .asciiz "\n"


.text
		la $s0,Array1			#initialize array

		la $a0,string1			#print input prompt for num 
		li $v0,4
		syscall


		li $v0,5
		syscall

		add $t0,$v0,$0			#store user integer
		li $t1,0			#initialize counter
		
		

		jal fillarray			#jump to fillarray



		la $s0,Array1			#re-initialize array
		li $t1,0			#re initialize counter
		li $t2,2			#initialize denominator forevenoddcheck

		li $t5,4			#used for multiplication

		jal findevenodd

		

######################################################################################

findevenodd:    div $a0,$t2

		mfhi $t3

		li $t1,0			#re initialize counter

		beq $t3,$t1,evencalcmedian

		bne $t3,$t1,oddcalcmedian


#######################################################################################


evencalcmedian:   la $s0,Array1			#re-initialize array
		  li $t1,0			#re initialize counter

		 div $a0,$t2
	
		  mflo $t4			#move quotient to t4

		  mult $t4,$t5

		mflo $t4
		

		add $s0,$s0,$t4		#increment array by t4 value

		lw $t7,0($s0)     	#lw into t7

		sub $s0,$s0,4		#subb pointer

		lw $t6,0($s0)		#lw into t6


		add $t7,$t7,$t6		#store sum of t7 and t6 into t7

		div $t7,$t2			#divide t7 by 2


		mflo $t4			#move quotient to t4
		

		la $a0,string3		#print median is
		li $v0,4
		syscall

		add $a0,$t4,$0
		li $v0,1
		syscall

		la $a0,decimal		#print decimal point
		li $v0,4
		syscall

		li $t4,5		

		add $a0,$t4,$0		#print 
		li $v0,1
		syscall

		

		j exit

###################################################################################

oddcalcmedian:   la $s0,Array1			#re-initialize array
		  li $t1,0			#re initialize counter

		 div $t0,$t2
	
		  mflo $t4			#move quotient to t4

		  mult $t4,$t5

		mflo $t4

		add $s0,$s0,$t4		#increment array by t4 value

		lw $t7,0($s0)     	#lw into t7

		
		la $a0,string3		#print newline
		li $v0,4
		syscall

		add $a0,$t7,$0
		li $v0,1
		syscall

		j exit




####################################################################################

#output:		addi $t1,1 		#increment counter
#
#		lw $a0,0($s0)		#store integer into array
#
#		addi $s0,$s0,4		#increment pointer
#
#		li $v0,1		#print integer
#		syscall
#
#		la $a0,newline		#print newline
#		li $v0,4
#		syscall

		

#		bne  $t1,$t0,output

#		j exit

#########################################################################################


fillarray:     	
	
		la $a0,string2			#print input prompt for num 
		li $v0,4
		syscall	
		
		addi $t1,$t1,1 			#increment counter

		add $a0,$t1,$0			#print counter prompt for num 
		li $v0,1
		syscall	

		li $v0,5			#get userinput
		syscall

		sw $v0,0($s0)		#store integer into array

		addi $s0,$s0,4		#increment pointer
		

		bne  $t1,$t0,fillarray

		jr $ra

####################################################################################



exit: li $v0,10
	syscall