# set initial player location
MOVI $127 %r1 
ADD %r1 %r1
ADDI $2 %r1  # r1 = Grid Start $256
MOVI $17 %r2
ADD %r1 %r2  # r2 = Player Location
STORI $1 %r2 