# Version 2, do nothing, then exit

# switch to the Text segment
        .text        
        
        .globl  main
main:
        # the rest of the main program will go here        
        
        # call function Exit0        
        jal     Exit0   # end the program, default return status
        
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# switch to the Data segment
        .data        
        
        # global data will be defined here

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Wrapper functions around some of the system calls
# See P&H COD, Fig. A.9.1, for the complete list.

# switch to the Text segment
        .text        
        
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