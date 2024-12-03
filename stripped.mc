MOVI $127 %r1 
ADD %r1 %r1 
ADDI $2 %r1 
MOVI $17 %r2 
ADD %r1 %r2 
MOV %r1 %r13 
ADDI $5 %r13 
MOV %r13 %r14 
ADDI $24 %r14 
STORI $1 %r2 
WAIT %r0 %r0 
MOVI $12 %r5 
ADD %r1 %r5 
STORI $2 %r5 
WAIT %r0 %r0 
MOVI $-1 %r3 
LOAD %r4 %r3 
CMPI $1 %r4 
BEQ .p_left 
CMPI $2 %r4 
BEQ .p_right 
BUC .main 
STORI $0 %r3 
STORI $0 %r4 
CMP %r2 %r13 
BEQ .main 
STORI $0 %r2 
SUBI $6 %r2 
STORI $1 %r2 
BUC .main 
STORI $0 %r3 
STORI $0 %r4 
CMP %r2 %r14 
BEQ .main 
STORI $0 %r2 
ADDI $6 %r2 
STORI $1 %r2 
BUC .main 
