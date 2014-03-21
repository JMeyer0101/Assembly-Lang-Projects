.data


input:  .space 10
encrypt:  .space 10
decrypt: .space 10

nextline:  .asciiz "\n"
.text

main:

la $s0,input			#initialize arrays
la $s2,encrypt
la $s3,decrypt

la $a0,input			#initialize input space into a0


li $v0, 8			#initiate read string input


li $a1,10			#load a1 with length of string

syscall



#

la $s0,input  #re initialize input array

li $s1,10		#initilize xor key
li $t7,10		#initialize counter

li $v0,4		#print
la $a0,nextline
syscall

li $v0,4
la $a0,input
syscall

la $s0,input  #re initialize input array
#########################################




#
 li $t1,0

jal encryptloop


la $s2,encrypt   #re-initialize encrypt array
li $t7,10	#re-initialize counter

li $v0,4
la $a0,nextline
syscall


li $v0,4
la $a0,encrypt
syscall





jal decryptloop




li $t0,0

la $s3,decrypt   #re-initialize encrypt array
li $t7,10	#re-initialize counter

jal outputloop

li $t0,0

li $v0,10
syscall




la $s3,decrypt   #re-initialize decrypt array
li $t7,9	#re-initialize counter

 

encryptloop:	lb $t0,0($s0)  #load array val into t0

	addi $s0,$s0,1  #increase pointer by one

	xor $t1,$t0,$s1 #perform xor on t0 value, store in t1

	sb $t1,0($s2)  #store into s2
	
	li $t1,0

	addi $s2,$s2,1  #increment s2 pointer

	sub $t7,$t7,1		#decrement counter

	bne $t7,$0,encryptloop

	li $t7,10

	jr $ra
	

decryptloop:

	lb $t0,0($s2)


	addi $s2,$s2,1  #increase pointer by one

	xor $t1,$t0,$s1 #perform xor on t0 value


	sb $t1,0($s3)  #store into s3

	li $t0,0

	li $t1,0

	addi $s3,$s3,1  #increment s3 pointer

	sub $t7,$t7,1		#decrement pointer

	bne $t7,$0,decryptloop  #if counter not 0, continue decrypt

	li $t7,10

	jr $ra
	
outputloop:

	la $a0,decrypt

	li $v0,4

	syscall

	jr $ra
