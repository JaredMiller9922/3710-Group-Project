MOVI $0 %r3 
MOVI $14 %r6 
MOVI $1 %r4 
MOVI $-1 %r5 
CMP %r3 %r6 
BEQ $16 
ADD %r5 %r4 
MOV %r4 %r10 
SUB %r5 %r10 
MOV %r10 %r5 
MOVI $127 %r7 
ADD %r3 %r7 
STOR %r4 %r7 
ADDI $1 %r3 
MOVI $4 %r12 
JUC %r12 
MOVI $-1 %r7 
LOAD %r3 %r7 
MOVI $127 %r8 
ADD %r3 %r8 
LOAD %r4 %r8 
STOR %r4 %r7 
MOVI $16 %r13 
JUC %r13 
