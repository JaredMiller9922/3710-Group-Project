# set initial player location
MOVI $127 %r1 
ADD %r1 %r1
ADDI $2 %r1  # r1 = Grid Start $256
MOVI $17 %r2
ADD %r1 %r2  # r2 = Player Location
STORI $1 %r2 

# set initial enemy location
MOVI $12 %r5
ADD %r1 %r5  # r5 = Enemy Location
STORI $2 %r5 

# main game loop
.main
MOVI $-1 %r3  # r3 = MM-IO Location
LOAD %r4 %r3  # r4 = MM-IO Value 

CMPI $1 %r4   # Player has moved left
BEQ .p_left

CMPI $2 %r4   # Player has moved left
BEQ .p_right

BUC .main # Redo Loop

# TODO: Currently overwrites the entire bit sequence
# TODO: Remove me from current grid square
.p_left
SUBI $6 %r2
STORI $1 %r2
BUC .main
# TODO: Currently overwrites the entire bit sequence
# TODO: Remove me from current grid square
.p_right
ADDI $6 %r2
STORI $1 %r2
BUC .main