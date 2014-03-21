# nested subroutine example

	.data	
string1:  .asciiz "subroutine 1, ra pushed into stack\n"
string2:  .asciiz "subroutine 2, ra popped from stack\n"
done: .asciiz  "done.\n"
	.text

main:		
	
	start:  jal sampleloop
					#jr returns here after nestedloop
	exit:	la $a0,done
		li $v0,4
		syscall
		
		li $v0,10
		syscall
	
	
	
	
	sampleloop: 	sub $sp,$sp,4
			sw $ra,0($sp)
			
	
			la $a0,string1
			li $v0,4
			syscall
			
			
			jal nestedloop
			
			
			
			nestedloop:  	li $v0,4			
					la $a0,string2
					syscall
			
					lw $ra,0($sp)		#nested subroutine loads return register into ra
					add $sp,$sp,4
				
					jr $ra
			
# END OF PROGRAM