# set initial player location
MOVI $127 %r1 
ADD %r1 %r1
ADDI $2 %r1    # r1 = Grid Start $256
MOVI $17 %r2
ADD %r1 %r2    # r2 = Player Location
MOV %r1 %r13
ADDI $5 %r13   # r13 = Lower Bound Start $261
MOV %r13 %r14
ADDI $24 %r14  # r14 = Upper Bound Start $285
STORI $1 %r2 

WAIT %r0 %r0   # TODO: Remove For waiting only

# set initial enemy location
MOVI $12 %r5
ADD %r1 %r5    # r5 = Enemy Location
STORI $2 %r5 

# main game loop
.main
WAIT %r0 %r0   # For waiting only
MOVI $-1 %r3   # r3 = MM-IO Location
LOAD %r4 %r3   # r4 = MM-IO Value 

CMPI $1 %r4    # Player has moved left
BEQ .p_left

CMPI $2 %r4    # Player has moved right
BEQ .p_right

CMPI $5 %r4    # Player has fired
BEQ .p_fire


BUC .main      # Redo Loop main

# TODO: Remove me from current grid square w/o overwriting whatever is there {May not be a problem}
.p_left
CMP %r2 %r13   # Checks if player is at left boundary
BEQ .main

STORI $0 %r2   # Removes player from current location
SUBI $6 %r2    # Moves player left
LOAD %r8 %r2   # Next location contents
ORI  $1 %r8    # Or player bit and next location contents so you don't overwrite
STOR %r8 %r2   # Update player location
BUC .main      # Redo Loop

# TODO: Remove me from current grid square w/o overwriting whatever is there {May not be a problem}
.p_right
CMP %r2 %r14   # Checks if player is at right boundary
BEQ .main

STORI $0 %r2   # Removes player from current location
ADDI $6 %r2    # Move right
LOAD %r8 %r2   # Next location contents
ORI $1 %r8     # Or player bit and next location contents so you don't overwrite
STOR %r8 %r2   # Update player location
BUC .main      # Redo Loop

.p_fire
MOV %r2 %r6
SUBI $1 %r6    # %r6 bullet location
LOAD %r7 %r6   # %r7 bullet location contents
ORI $4 %r7     # Makes so we don't overwrite next location 
STOR %r7 %r6   # Store the and'ed value of the grid location at the location

BUC .main