# Initialize n = 0
MOVI $0 %r3        # %r3 = 0

# Initialize x = 14
MOVI $14 %r6       # %r6 = 14

# Initialize f1 = 1
MOVI $1 %r4        # %r4 = 1

# Initialize f2 = -1
MOVI $-1 %r5       # %r5 = -1

.loop
# Check if n == x; if so, branch to end
CMP %r3 %r6
BEQ .end           # if %r3 == %r6, go to .end

# Calculate f1 = f1 + f2
ADD %r5 %r4        # %r4 = %r4 + %r5

# Calculate f2 = f1 - f2
MOV %r4 %r10         # move r4 to r10
SUB %r5 %r10         # r10 = r10 - r5
MOV %r10 %r5         # move r10 to r5        # %r5 = %r4 - %r5

# Store f1 in memory at address (128 + n)
# Assuming we have a way to handle memory with an immediate offset
MOVI $127 %r7      # Load base address 128 into %r7
ADD %r3 %r7        # Add offset n (stored in %r3) to base address
STOR %r4 %r7       # Store %r4 (f1) in memory at computed address

# Increment n by 1
ADDI $1 %r3        # %r3 = %r3 + 1

# Jump back to loop
MOVI $4 %r12
JUC %r12

.end
# Read from memory address 192 to get switch input
MOVI $-1 %r7       # Load address 192 into %r7
LOAD %r3 %r7       # Load value at memory address 192 into %r3

# Read the nth Fibonacci number from memory (128 + n)
MOVI $127 %r8      # Load base address 128 into %r8
ADD %r3 %r8        # Add n (stored in %r3) to base address
LOAD %r4 %r8       # Load Fibonacci number at computed address into %r4

# Store Fibonacci number into memory address 192 (to output on LEDs)
STOR %r4 %r7       # Store %r4 at memory address 192

# Jump back to end to repeat
MOVI $16 %r13
JUC %r13