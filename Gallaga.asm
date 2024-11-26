# TODO: Currently every single store overwrites bits
.init
    # Set Player Location
    MOVI $16396 %r1 # 16396 = 0100000000001100
    STOR $1 %r1 # Set player bit 

    # Set Enemy Location
    MOVI $16401 %r2 # 16401 = 0100000000010001
    STOR $8 %r2 # Set enemy bit
.main
    # Check for player input
    LOAD $-1 %r3 # Load from memory mapped IO

    CMPI $1 %r3 # Left
    Bcond $5 .p_left # Branch if $1 and %r3 are equvialent

    CMPI $2 %r3 # Right
    Bcond $5 .p_right # Branch if $1 and %r3 are equvialent

.p_left
    STOR $0 %r1 # Remove player from cur_pos

    SUBI $-6 %r1 # Calculate left grid cell
    STOR $1 %r1 # Update cur_pos left grid cell
.p_right
    # Set cur_pos player bit to 0
    STOR $0 %r1

    # Update cur_pos + 6 player bit
    SUBI $6 %r1
    STOR $1 %r1


