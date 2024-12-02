MOVI $127 %r1 
ADD %r1 %r1 
ADDI $2 %r1 
MOVI $17 %r2 
ADD %r1 %r2 
MOV %r1 %r13 
ADDI $5 %r13 
MOV %r13 %r14 
ADDI $30 %r14 
STORI $1 %r2 
MOVI $12 %r5 
ADD %r1 %r5 
STORI $2 %r5 
MOVI $-1 %r3 
LOAD %r4 %r3 
MOVI $23 %r5 
CMPI $1 %r4 
JEQ %r5 
MOVI $30 %r5 
CMPI $2 %r4 
JEQ %r5 
MOVI $13 %r5 
JUC %r5 
MOVI $13 %r5 
CMP %r2 %r13 
JEQ %r5 
SUBI $6 %r2 
STORI $1 %r2 
MOVI $13 %r5 
JUC %r5 
MOVI $13 %r5 
CMP %r2 %r14 
JEQ %r5 
ADDI $6 %r2 
STORI $1 %r2 
MOVI $13 %r5 
JUC %r5 
