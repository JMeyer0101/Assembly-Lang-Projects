#Jason Meyer
#CS231
#Assignment 2 Program
#3/14/14

#This program creates a user defined array and reverses it before printing
#it out



.data

Array:  .space 80
String1: .asciiz "Enter a value for array size [0-20]:		"
String2: .asciiz "\nNumber must be divisible by 3\n\n"
arrayprompt: .asciiz "enter array values\n"
String3: .asciiz "\ndone."
String4: .asciiz "\n"

.text

main:
la $s7,Array
li $s0,21
li $s1,1
li $s2,3
li $s3,4


begin:		la $a0,String1		#print user prompt
		la $v0,4
		syscall
		
		jal readNum
		jal verifySize
		
		add $t7,$a0,$0 		#$t7 = array.length
		li $t6,0		#initialize counter
		la $a0,arrayprompt	#prompt user to input array values
		li $v0,4
		syscall
		
		jal createArray		#create user defined array

continue:	jal reverseArray	#reverse array

print:		jal printArray		#print reversed array
		
		la $a0,String3		#exit
		li $v0,4	
		syscall
		li $v0,10
		syscall


readNum:	

		la $v0,5		#get int from from user
		syscall

		add $a0,$v0,$0		#transfer user input into $a0

		jr $ra
		

verifyPos:	bltz $a0,createArray		#branch on less than 0
		jr $ra

verifySize:
		bltz $a0,begin		#branch on less than 0
		slt $t0,$a0,$s0 	#check if <21 i.e 20
		bne $t0,$s1,begin  	#check if >20 
		
		jr $ra
		
		
		
checkDiv:	div $a0,$s2		#divide by 3
		mfhi $t0		#move remainder to $t0
		slt $t0,$t0,$s1		#return 1 if remainder is 0
		beq $t0,$0,divError	#if remainder is not 0 then error
		
		jr $ra

divError:	
		la $a0,String2		#print out div error
		li $v0,4
		syscall
			
		j createArray		#continue array creation
	

createArray:	
		jal readNum		#get user input
		jal verifyPos		#verify positive input
		jal checkDiv		#verify divisible by 3
		sw $a0,0($s7)		#store input value into array
		addi $t6,$t6,1		#increment counter
		addi $s7,$s7,4		#increment pointer by one word
		bne $t6,$t7,createArray	#if counter != array.length then loop
		
		
		la $s7,Array		#re-initialize array
		
		j continue		#continue
		
reverseArray:	addi $t5,$t7,-1		#decrement array.length by 1
		mult $t5,$s3		#get last indexy by mult array.length by 4
		mflo $t5		#store value into t5 (t5 = last index = tail)
		
		li $t6,0		#t6 = first index = head
		
		swap:	
			
			lw $t8, 0($s7)		#load head value into t8
			
			la $s7,Array		#reinitialize array
			
			add $s7,$s7,$t5	#increment pointer to tail
			lw $t9,0($s7)		#load tail value into t9
			
			
			
			sw $t8,0($s7)	#swap tail with head value
			
			la $s7,Array	#reinitialize array
			
			add $s7,$s7,$t6 #incrememnt pointer to head
			sw $t9,0($s7)	#swap head with tail value
			
			addi $t6,$t6,4	#increment head
			beq $t6,$t5,print		#if head=tail then done go to print
			addi $t5,$t5,-4	#decrement tail
			beq $t6,$t5,print		#if head=tail then done go to print
			
			la $s7,Array	#reinitialize array
			
			add $s7,$s7,$t6 #increment pointer to head
			
			j swap

		
		
printArray:	la $s7,Array		#re-initialize array
		
		printloop: beq $t7,$0,done	#when counter = 0, then done
		
			lw $a0,0($s7)		#load word into $a0
			li $v0,1		#print word
			syscall
			la $a0,String4		#newline
			li $v0,4
			syscall
			addi $s7,$s7,4	#increase pointer
			addi $t7,$t7,-1	#decrement counter (counter = array.length)
			j printloop
			
			
done:   	jr $ra
		
		
		