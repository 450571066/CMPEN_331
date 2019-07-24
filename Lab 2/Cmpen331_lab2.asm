	.text
  #       .align  2               # MARS doesn't like this   
      
	.globl  main
main:   
	subu    $sp, $sp, 40    # stack push, 40 bytes        
	sw      $ra, 20($sp)    # save return address register (sw = store word)        
	sd      $a0, 32($sp)    # save registers $a0, $a1 (sd = store doubleword)        
	sw      $0, 24($sp)     # sum = 0        
	sw      $0, 28($sp)     # i = 0
loop:        
	lw      $t6, 28($sp)    # i        
	mul     $t7, $t6, $t6   # i * i        
	lw      $t8, 24($sp)    # sum        
	addu    $t9, $t8, $t7   # sum + i*i        
	sw      $t9, 24($sp)    # sum = sum + i*i        
	addu    $t0, $t6, 1     # i + 1        
	sw      $t0, 28($sp)    # i = i + 1        
	ble     $t0, 100, loop  # if (i <= 100) goto loop  
	      
	la      $a0, str1        
	jal     Print_string    # print the string whose starting address is in register $a0        
	lw      $a0, 24($sp)    # sum        
	jal     Print_integer   # print the integer in register $a0        
	la      $a0, str2        
	jal     Print_string    # print the string whose starting address is in register $a0      
	  
	# this exit sequence can be used with QtSPIM, but not with MARS
#       move    $v0, $0         # return status 0
#       lw      $ra, 20($sp)    # restore saved return address
#       addu    $sp, $sp, 40    # stack pop (important - same 40 bytes as before!)
#       jr      $ra             # return from main() to the OS       
	# MARS likes this, but we need to demo Exit2
#       jal     Exit            # end the program, no explicit return status
	# MARS likes this       
	move    $a0, $0        
	jal     Exit2           # end the program, with return status from register a0
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -        
	.data        
	.align  0
	
str1:        
	.asciiz "The sum from 0 .. 100 is :"
str2:        
	.asciiz ":\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Wrapper functions around some of the system calls
# See P&H COD, Fig. A.9.1, for the complete list.        

	.text
#       .align  2               # MARS doesn't like this        
	.globl  Print_integer
Print_integer:  # print the integer in register $a0        
	li      $v0, 1        
	syscall        
	jr      $ra        
	
	.globl  Print_string
Print_string:   # print the string whose starting address is in register $a0        
	li      $v0, 4        
	syscall        
	jr      $ra        
	
	.globl  Exit
Exit:           # end the program, no explicit return status        
	li      $v0, 10        
	syscall        
	jr      $ra     # this instruction is never executed        
	
	.globl  Exit0
Exit0:          # end the program, default return status        
	li      $a0, 0  # return status 0        
	li      $v0, 17        
	syscall        
	jr      $ra     # this instruction is never executed
	
	.globl  Exit2
Exit2:          # end the program, with return status from register $a0        
	li      $v0, 17        
	syscall        
	jr      $ra     # this instruction is never executed
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
