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
CMPI $5 %r4 
BEQ .p_fire 
BUC .main 
CMP %r2 %r13 
BEQ .main 
STORI $0 %r2 
SUBI $6 %r2 
LOAD %r8 %r2 
ORI $1 %r8 
STOR %r8 %r2 
BUC .main 
CMP %r2 %r14 
BEQ .main 
STORI $0 %r2 
ADDI $6 %r2 
LOAD %r8 %r2 
ORI $1 %r8 
STOR %r8 %r2 
BUC .main 
MOV %r2 %r6 
SUBI $1 %r6 
LOAD %r7 %r6 
ORI $4 %r7 
STOR %r7 %r6 
STORI $1 %r13 
STORI $1 %r14 
BUC .main 
