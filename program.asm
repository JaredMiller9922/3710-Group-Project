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
MOVI $16 %r15	# Universal Enemy Bullet Update Value Default: b'10000

WAIT %r0 %r0   # TODO: Remove For waiting only

# set initial enemy location
MOVI $12 %r5
ADD %r1 %r5    # r5 = Enemy Location
STORI $2 %r5 

# main game loop
.main
WAIT %r0 %r0   # For waiting only


# Check E Spawn
MOVRI $25 %r10  # Store a random value 
CMPI  $4 %r10  # Check if we should spawn an enemy
BEQ .e_spawn_check
BUC .after_spawn      # TODO: Ask Jesse where this should go

.after_spawn

MOVI $-1 %r3   # r3 = MM-IO Location
LOAD %r4 %r3   # r4 = MM-IO Value 

CMPI $1 %r4    # Player has moved left
BEQ .p_left

CMPI $2 %r4    # Player has moved right
BEQ .p_right

CMPI $5 %r4    # Player has fired
BEQ .p_fire

.secondary

# Loop Through all grid cells   r14 is Grid End
MOV %r1 %r9		# Start of Grid
.grid_loop
# Check Some stuff
# Update values
LOAD %r10 %r9	# Load value of grid cell into %r10
MOVI $4 %r11	# Move b'100 into %r11
AND %r10 %r11	# AND to get just bullet value
CMPI $4 %r11
BNE .after_player_bullet	# Update bullet if there is one


MOV %r9 %r11	# Current location Value = %r11
XORI  $4 %r10	# Remove the Bullet
STOR %r10 %r11   # Removes Bullet from current location 
SUBI $1 %r11    # Moves Bullet up
LOAD %r8 %r11   # Next location contents
ORI  $4 %r8    # Or Bullet bit and next location contents so you don't overwrite
STOR %r8 %r11   # Update Bullet location

.after_player_bullet


LOAD %r10 %r9	# Load value of grid cell into %r10
MOVI $24 %r11	# Move b'11000 into %r11
AND %r10 %r11	# AND to get just bullet value
MOVI $8 %r8		# MOV b'1000 for enemy bullet
OR %r15 %r8		# OR with universal enemy bullet bit to check if should update
CMP %r8 %r11
BNE .after_enemy_bullet	# Update bullet if there is one and matches universal enemy bullet bit


MOV  %r9 %r11		# Current location Value = %r11
MOVI $24 %r8		# Move b'11000 into %r11
AND  %r10 %r8		# AND to get just bullet value
XOR  %r8 %r10		# Remove the bullet and Universial Enemy Bullet bit
STOR %r10 %r11		# Removes Bullet from current location 
ADDI $1 %r11		# Moves Bullet Down
LOAD %r8 %r11		# Next location contents
ORI  $8 %r8			# Or Bullet bit and next location contents so you don't overwrite
OR   %r15 %r8		# Or in the universial bit 
XORI $16 %r8		# XOR with b'10000 to move in not Universial Enemy Bullet bit
STOR %r8 %r11		# Update Bullet location

.after_enemy_bullet

ADDI $1 %r9		# Increment current Grid Location
CMP %r14 %r9	# Check if last Grid Location
BGE .grid_loop	# Branch if at End of Grid

XORI	$16 %r15		# Flip Universial Enemy Bullet Bit

BUC .main      # Redo Loop main

# TODO: Remove me from current grid square w/o overwriting whatever is there {May not be a problem}
.p_left
CMP %r2 %r13   # Checks if player is at left boundary
BEQ .secondary

STORI $0 %r2   # Removes player from current location
SUBI $6 %r2    # Moves player left
LOAD %r8 %r2   # Next location contents
ORI  $1 %r8    # Or player bit and next location contents so you don't overwrite
STOR %r8 %r2   # Update player location
BUC .secondary      # Redo Loop

# TODO: Remove me from current grid square w/o overwriting whatever is there {May not be a problem}
.p_right
CMP %r2 %r14   # Checks if player is at right boundary
BEQ .secondary

STORI $0 %r2   # Removes player from current location
ADDI $6 %r2    # Move right
LOAD %r8 %r2   # Next location contents
ORI $1 %r8     # Or player bit and next location contents so you don't overwrite
STOR %r8 %r2   # Update player location
BUC .secondary      # Redo Loop

.p_fire
MOV %r2 %r6
SUBI $0 %r6    # %r6 bullet location
LOAD %r7 %r6   # %r7 bullet location contents
ORI $4 %r7     # Makes so we don't overwrite next location 
STOR %r7 %r6   # Store the and'ed value of the grid location at the location

BUC .secondary



.e_spawn_check
WAIT %r0 %r0   # TODO: Remove For waiting only
WAIT %r0 %r0   # TODO: Remove For waiting only

MOVRI $4 %r10  # Choose one of the five spawn locations

CMPI $0 %r10
BNE $3         # This should jump past the next instruction
MOVI $0 %r11
BUC .e_spawn

CMPI $1 %r10
BNE $3         # This should jump past the next instruction
MOVI $6 %r11
BUC .e_spawn

CMPI $2 %r10
BNE $3         # This should jump past the next instruction
MOVI $12 %r11
BUC .e_spawn

CMPI $3 %r10
BNE $3         # This should jump past the next instruction
MOVI $18 %r11
BUC .e_spawn

CMPI $4 %r10
BNE $3         # This should jump past the next instruction
MOVI $24 %r11
BUC .e_spawn

.e_spawn
MOV %r1 %r10   # Grid start
ADD %r11 %r10  # Spawn Location 

LOAD %r11 %r10 # Load the current contents of spawn location
MOVI $2 %r12   # Make sure there isn't already an enemy here
AND %r11 %r12

CMPI $2 %r12
BEQ .after_spawn      # There was already an enemy here don't spawn
ORI $2 %r11   # There wasn't an enemy here so spawn w/o overwriting
STOR %r11 %r10
BUC .after_spawn      # TODO: Where does Jesse Go
