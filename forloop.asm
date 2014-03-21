# UNTITLED PROGRAM

	.data	# Data declaration section

	.text

main:		# Start of code section


	li $t0,10
	li $t1,0
	
	jal loop1
	
	
	done:   li $v0,10
		syscall
		
	loop1:	bne $t0,$t1,loop2
	
		add $a0,$t1,$0
		li $v0,1
		syscall
		
		jr $ra
		
		loop2: addi $t1,$t1,1
			j loop1
		
		

# END OF PROGRAM