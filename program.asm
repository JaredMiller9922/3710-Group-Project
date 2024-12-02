# set initial player location
MOVI $127 %r1 
ADD %r1 %r1
ADDI $2 %r1  # r1 = Grid Start $256
MOVI $17 %r2
ADD %r1 %r2  # r2 = Player Location
MOV %r1 %r13
ADDI $5 %r13  # r13 = Lower Bound Start $261
MOV %r13 %r14
ADDI $24 %r14  # r14 = Upper Bound Start $285
STORI $1 %r2 

# set initial enemy location
MOVI $12 %r5
ADD %r1 %r5  # r5 = Enemy Location
STORI $2 %r5 

# main game loop
.main
MOVI $-1 %r3  # r3 = MM-IO Location
LOAD %r4 %r3  # r4 = MM-IO Value 

MOVI $23 %r5
CMPI $1 %r4   # Player has moved left
JEQ %r5

MOVI $30 %r5
CMPI $2 %r4   # Player has moved right
JEQ %r5

MOVI $13 %r5
JUC %r5 # Redo Loop main

# TODO: Currently overwrites the entire bit sequence
# TODO: Remove me from current grid square
.p_left

MOVI $13 %r5
CMP %r2 %r13   # Player has moved right
JEQ %r5

SUBI $6 %r2
STORI $1 %r2
MOVI $13 %r5
JUC %r5 # Redo Loop
# TODO: Currently overwrites the entire bit sequence
# TODO: Remove me from current grid square
.p_right

MOVI $13 %r5
CMP %r2 %r14   # Player has moved right
JEQ %r5

ADDI $6 %r2
STORI $1 %r2
MOVI $13 %r5
JUC %r5 # Redo Loop