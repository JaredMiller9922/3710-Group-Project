# TODO: Currently every single store overwrites bits
.init
    # Set Player Location
    MOVI $16396 %r1 # 16396 = 0100000000001100
    STORI $1 %r1 # Set player bit 

    # Set Enemy Location
    MOVI $16401 %r2 # 16401 = 0100000000010001
    STORI $8 %r2 # Set enemy bit
.main
    # Check for player input
    LOAD $-1 %r3 # Load from memory mapped IO

    CMPI $1 %r3 # Left
    Jcond $5 .p_left # Branch if $1 and %r3 are equvialent

    CMPI $2 %r3 # Right
    Jcond $5 .p_right # Branch if $1 and %r3 are equvialent

.p_left
    STORI $0 %r1 # Remove player from cur_pos

    SUBI $-6 %r1 # Calculate left grid cell
    STORI $1 %r1 # Update cur_pos left grid cell

.p_right
    # Set cur_pos player bit to 0
    STORI $0 %r1

    # Update cur_pos + 6 player bit
    SUBI $6 %r1
    STORI $1 %r1


