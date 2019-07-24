# CMPEN 331, Lab 2

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# switch to the Data segment
	.data
	# global data is defined here

	# Don't forget the backslash-n (newline character)
Homework:
	.asciiz	"CMPEN 331 Homework 2\n"
Name_1:
	.asciiz	"Tianqi Liu\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# switch to the Text segment
	.text
	# the program is defined here

	.globl	main
main:
	# Whose program is this?
	la	$a0, Homework
	jal	Print_string
	la	$a0, Name_1
	jal	Print_string
	
	# int i, j = 2, n = 3;
	# for (i = 0; i <= 16; i++)
	#   {
	#      ... j = testcase[i]
	#      ... calculate n from j
	#      ... print i, j and n
	#   }
	
	# register assignments
	#  $s0   i
	#  $s1   j = testcase[i]
	#  $s2   n
	#  $t0   address of testcase[i]
	#  $a0   argument to Print_integer, Print_string, etc.
	#  add to this list if you use any other registers
	#  $t1   holder for if value left hand side
	#  $t2   holder for if value right hand side	
	#  $t3   holder for aaaaa bbbbbbb cccccc dddddd
	#  $t4   holder for value of n

	# initialization
	li	$s1, 2			# j = 2
	li	$s2, 3			# n = 3
	
	# for (i = 0; i <= 16; i++)
	li	$s0, 0			# i = 0
	la	$t0, testcase		# address of testcase[i]
	bgt	$s0, 16, bottom
top:
	lw	$s1, 0($t0)		# j = testcase[i]
	# calculate n from j
	# Your part starts here
	li $t1, 0
					# the largest j value is 0x7f
	srl $t2, $s1, 7			# j >> 7, delete right 7 bits	
	bne  $t2, $t1, Else1		# if t2 is greater than 0, then jump to Else1
	
	move $s2, $s1
	j print
	
Else1:					# the largest j value is 0x7ff
	srl $t2, $s1, 11		# j >> 11, delete right 11 bits
	bne $t2, $t1, Else2		# if t2 is greater than 0, then jump to Else2
	
	srl $t3, $s1, 6			# $t3 = aaaaa
	li $t4, 6			# $t4 = 110
	sll $t4, $t4, 5			# $t4 = 110 00000
	or $t4, $t4, $t3		# $t4 = 110 aaaaa
	sll $t4, $t4, 8			# $t4 = 110 aaaaa 00 000000
	ori $t4, $t4, 0x80		# $t4 = 110 aaaaa 10 000000
	andi $t3, $s1, 0x3f		# $t3 = bbbbbb
	or $s2, $t4, $t3		# n = 110 aaaaa 10 bbbbbb
	j print
	
Else2:					# the largest j value is 0xffff
	srl $t2, $s1, 16		# j >> 16, delete right 16 bits
	bne $t2, $t1, Else3		# if t2 is greater than 0, then jump to Else3
	
	srl $t3, $s1, 12		# $t3 = aaaa
	li $t4, 14			# $t4 = 1110
	sll $t4, $t4, 4			# $t4 = 1110 0000
	or $t4, $t4, $t3		# $t4 = 1110 aaaa
	sll $t4, $t4, 8			# $t4 = 1110 aaaa 00 000000
	ori $t4, $t4, 0x80		# $t4 = 1110 aaaa 10 000000
	andi $t3, $s1, 0xfc0		# $t3 = bbbbbb 000000
	srl $t3, $t3, 6			# $t3 = bbbbbb
	or $t4, $t4, $t3		# $t4 = 1110 aaaa 10 bbbbbb
	sll $t4, $t4, 8			# $t4 = 1110 aaaa 10 bbbbbb 00 000000
	ori $t4, $t4, 0x80		# $t4 = 1110 aaaa 10 bbbbbb 10 000000
	andi $t3, $s1, 0x3f		# $t3 = cccccc
	or $s2, $t4, $t3		# n = 1110 aaaa 10 bbbbbb 10 cccccc
	j print
	
Else3:					# the largest j value is 0x10ffff
	srl $t2, $s1, 16		# j >> 16, delete right 16 bits
	li $t1 0x80			# after shifting, the largest value is 1000 0000
	bgt $t2, $t1, Else4		# if t2 is greater than 1000 0000, jump to Else4
	
	srl $t3, $s1, 18		# $t3 = aaa
	li $t4, 30			# $t4 = 11110
	sll $t4, $t4, 3			# $t4 = 11110 000
	or $t4, $t4, $t3		# $t4 = 11110 aaa
	sll $t4, $t4, 8			# $t4 = 11110 aaa 00 000000
	ori $t4, $t4, 0x80		# $t4 = 11110 aaa 10 000000
	srl $t3, $s1, 12		# #t3 = aaa bbbbbb
	andi $t3, $t3, 0x3f		# $t3 = bbbbbb	
	or $t4, $t4, $t3		# $t4 = 11110 aaa 10 bbbbbb
	sll $t4, $t4, 8			# $t4 = 11110 aaa 10 bbbbbb 00 000000
	ori $t4, $t4, 0x80		# $t4 = 11110 aaa 10 bbbbbb 10 000000
	srl $t3, $s1, 6			# $t3 = aaa bbbbbb cccccc
	andi $t3, $t3, 0x3f		# $t3 = cccccc
	or $t4, $t4, $t3		# $t4 = 11110 aaa 10 bbbbbb 10 cccccc
	sll $t4, $t4, 8			# $t4 = 11110 aaa 10 bbbbbb 10 cccccc 00 000000
	ori $t4, $t4, 0x80		# $t4 = 11110 aaa 10 bbbbbb 10 cccccc 10 000000
	andi $t3, $s1, 0x3f		# $t3 = dddddd
	or $s2, $t4, $t3		# n = 11110 aaa 10 bbbbbb 10 cccccc 10 dddddd
	
	j print
Else4:					# default else, j is outside the UTF-8 range of character codes
	lui $t4, 0xffff			# $t4 = 0xFFFF 0000
	ori $s2, $t4, 0xffff		# n = 0xFFFF FFFF
	j print
	
	# Your part ends here
	
	# print i, j and n
print:
	move	$a0, $s0	# i
	jal	Print_integer
	la	$a0, sp		# space
	jal	Print_string
	move	$a0, $s1	# j
	jal	Print_hex
	la	$a0, sp		# space
	jal	Print_string
	move	$a0, $s2	# n
	jal	Print_hex
	la	$a0, sp		# space
	jal	Print_string
	move	$a0, $s1	# j
	jal	Print_bin
	la	$a0, sp		# space
	jal	Print_string
	move	$a0, $s2	# n
	jal	Print_bin
	la	$a0, nl		# newline
	jal	Print_string
	
	# for (i = 0; i <= 16; i++)
	addi	$s0, $s0, 1	# i++
	addi	$t0, $t0, 4	# address of testcase[i]
	ble	$s0, 16, top	# i <= 16
bottom:
	
	la	$a0, done	# mark the end of the program
	jal	Print_string
	
	jal	Exit0	# end the program, default return status

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	.data
	# global data is defined here
sp:
	.asciiz	" "	# space
nl:
	.asciiz	"\n"	# newline
done:
	.asciiz	"All done!\n"

testcase:
	# UTF-8 representation is one byte
	.word 0x0000	# nul		# Basic Latin, 0000 - 007F
	.word 0x0024	# $ (dollar sign)
	.word 0x007E	# ~ (tilde)
	.word 0x007F	# del

	# UTF-8 representation is two bytes
	.word 0x0080	# pad		# Latin-1 Supplement, 0080 - 00FF
	.word 0x00A2	# cent sign
	.word 0x0627	# Arabic letter alef
	.word 0x07FF	# unassigned

	# UTF-8 representation is three bytes
	.word 0x0800
	.word 0x20AC	# Euro sign
	.word 0x2233	# anticlockwise contour integral sign
	.word 0xFFFF

	# UTF-8 representation is four bytes
	.word 0x10000
	.word 0x10348	# Hwair, see http://en.wikipedia.org/wiki/Hwair
	.word 0x22E13	# randomly-chosen character
	.word 0x10FFFF

	.word 0x89ABCDEF	# randomly chosen bogus value

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Wrapper functions around some of the system calls
# See P&H COD, Fig. A.9.1, for the complete list.

	.text

	.globl	Print_integer
Print_integer:	# print the integer in register $a0 (decimal)
	li	$v0, 1
	syscall
	jr	$ra

	.globl	Print_string
Print_string:	# print the string whose starting address is in register $a0
	li	$v0, 4
	syscall
	jr	$ra

	.globl	Exit
Exit:		# end the program, no explicit return status
	li	$v0, 10
	syscall
	jr	$ra	# this instruction is never executed

	.globl	Exit0
Exit0:		# end the program, default return status
	li	$a0, 0	# return status 0
	li	$v0, 17
	syscall
	jr	$ra	# this instruction is never executed

	.globl	Exit2
Exit2:		# end the program, with return status from register $a0
	li	$v0, 17
	syscall
	jr	$ra	# this instruction is never executed

# The following syscalls work on MARS, but not on QtSPIM

	.globl	Print_hex
Print_hex:	# print the integer in register $a0 (hexadecimal)
	li	$v0, 34
	syscall
	jr	$ra

	.globl	Print_bin
Print_bin:	# print the integer in register $a0 (binary)
	li	$v0, 35
	syscall
	jr	$ra

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
