# COMP 411 FALL 2020 LAB 4 STARTER CODE

.data 0x0
  executionTime:	.word 0
  numberOfProcessors:	.word 0
  totalPrice:		.word 0
  
  timePrompt:		.asciiz "Please enter the desired execution time (in seconds): "	
  pricePrompt:		.asciiz "Please enter the price of the processor(in dollars): "
  cpiPrompt:		.asciiz "Please enter the average CPI of the processor: "
  executionTimeIs:	.asciiz "Execution time in seconds: "
  isDesired:		.asciiz "This processor meets the desired execution time, adding to cart."
  notDesired:		.asciiz "This processor does not meet the desired execution time."
  totalProcessors:	.asciiz "Total number of processors purchased: "
  isTotalPrice:		.asciiz "Total price of processors purchased: "
  doneShopping:		.asciiz "You are done shopping for processors."
  newline:		.asciiz "\n"

.text
main:
 # Print the prompt for time
  addi 	$v0, $0, 4  	# system call 4 is for printing a string
  la	$a0, timePrompt 	# address of timePrompt is in $a0
  syscall
  # Read the Execution TIme
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  move  $s2, $v0           		
  add	$t0, $0, $v0			# copy the execution time into $8
  sw 	$s0, numberOfProcessors	# number of Processors stored in $s0
  sw 	$s1, totalPrice		# total Price stored in $s1
  j	loop	
 		
loop:
  # TO-DO: Complete the body of the loop.
  # Use the system calls provided above for input/output as a template for handling strings.
  #================================================================================================#
  #Print Price	
  addi 	$v0, $0, 4  	# system call 4 is for printing 
  la	$a0, pricePrompt 	# address of pricePrompt
  syscall           		
  #Read price
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall
  beq   $v0, $0, end 	        # if v0 == 0 we are done
  
  move  $t4, $v0
  #Print CPI
  addi 	$v0, $0, 4 	
  la	$a0, cpiPrompt 	
  syscall   	
  #Read CPI
  addi  $v0, $0, 5
  syscall
  #Store into Execution Time
  move  $t1, $v0
  #Print Excecution time prompt
  addi 	$v0, $0, 4  	
  la	$a0, executionTimeIs 	
  syscall           	
  #Shift to convert cpi to exec, load the word into a0, add t1=exectime
  sll   $t1, $t1, 1 
  lw    $a0, executionTime
  add   $a0, $a0, $t1  
  #Print Exec Tim
  addi  $v0, $0, 1
  la    $a1, executionTime
  syscall
  addi  $v0, $0, 4
  la	$a0, newline 	 
  syscall	
  #load eTime a0, add t1 to a0
  lw    $a1, executionTime
  add   $a1, $a1, $t1  
  #Check to see if desired then print
  slt   $t2, $a1, $s2
  beq 	$t2, 1, desired
  beq   $a1, $s2, desired
  j notD
desired:
  #add processor
  addi   $s0, $s0, 1  
  lw     $a0, numberOfProcessors
  add    $a0, $a0, $s0  
  #add price
  add    $s1, $s1, $t4  
  lw     $a0, totalPrice
  add    $a0, $a0, $s1  

  #Printing desired
  addi 	$v0, $0, 4   
  la	$a0, isDesired 	
  syscall
  la	$a0, newline 	 
  syscall
  j loop
notD:
  addi 	$v0, $0, 4   
  la	$a0, notDesired 	
  syscall    
  la	$a0, newline 	 
  syscall	
  j loop    		# jump back to the top
  
  end:

  #================================================================================================#
exit:
  # TO-DO: Complete the behavior of the program after exiting the loop.
  # Indicate that we have left the loop and output the number of processors and total price.
  #================================================================================================#
  #Done Shopping
  addi 	$v0, $0, 4  	# system call 4 is for printing a string
  la	$a0, doneShopping 	# address of timePrompt is in $a0
  syscall
  la	$a0, newline 	 
  syscall	
  #Print Total Processors
  addi 	$v0, $0, 4  	
  la	$a0, totalProcessors 	
  syscall
  lw    $a0, numberOfProcessors
  add   $a0, $a0, $s0
  addi  $v0, $0, 1
  la    $a1, numberOfProcessors
  syscall
  addi  $v0, $0, 4
  la	$a0, newline 	 
  syscall	
  
  la	$a0, isTotalPrice 	
  syscall
  lw    $a0, totalPrice
  add   $a0, $a0, $s1
  addi  $v0, $0, 1
  la    $a1, totalPrice
  syscall
 
 
  #================================================================================================#
  
  # Boilerplate system call to terminate program.
  ori $v0, $0, 10       	# system call code 10 for exit
  syscall   			
 
