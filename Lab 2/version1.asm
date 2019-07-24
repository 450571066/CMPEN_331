# Version 1, do nothing, then exit

# switch to the Text segment
        .text
        .globl  main
main:        
	# the rest of the main program will go here        
	
	# end the program, no explicit return status        
	li      $v0, 10        
	syscall
	
# switch to the Data segment       
	 .data
# global data will be defined here