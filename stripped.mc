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
MOVI $16 %r15 
MOVI $0 %r3 
WAIT %r0 %r0 
MOVI $12 %r5 
ADD %r1 %r5 
STORI $2 %r5 
WAIT %r0 %r0 
MOVRI $4 %r10 
CMPI $4 %r10 
BEQ .e_spawn_check 
BUC .after_spawn 
MOVI $-1 %r4 
LOAD %r4 %r4 
LOAD %r10 %r2 
ANDI $9 %r10 
CMPI $9 %r10 
BNE .input 
STORI $0 %r2 
MOVI $17 %r2 
ADD %r1 %r2 
STORI $1 %r2 
MOVI $0 %r3 
MOVI $-1 %r4 
STOR %r3 %r4 
CMPI $28 %r4 
BEQ .p_left 
CMPI $35 %r4 
BEQ .p_right 
CMPI $41 %r4 
BEQ .p_fire 
MOV %r1 %r9 
LOAD %r10 %r9 
MOVI $4 %r11 
AND %r10 %r11 
CMPI $4 %r11 
BNE .after_player_bullet 
MOV %r9 %r11 
XORI $4 %r10 
STOR %r10 %r11 
ANDI $2 %r10 
CMPI $2 %r10 
BNE .player_bullet_continue 
STORI $0 %r11 
ADDI $1 %r3 
MOVI $-1 %r4 
STOR %r3 %r4 
BUC .after_player_bullet 
SUBI $1 %r11 
LOAD %r8 %r11 
ORI $4 %r8 
MOV %r1 %r10 
SUBI $1 %r10 
CMP %r10 %r11 
BEQ .after_player_bullet 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_player_bullet 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_player_bullet 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_player_bullet 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_player_bullet 
STOR %r8 %r11 
LOAD %r10 %r9 
MOVI $24 %r11 
AND %r10 %r11 
MOVI $8 %r8 
OR %r15 %r8 
CMP %r8 %r11 
BNE .after_enemy_bullet 
MOV %r9 %r11 
MOVI $24 %r8 
AND %r10 %r8 
XOR %r8 %r10 
STOR %r10 %r11 
ADDI $1 %r11 
LOAD %r8 %r11 
ORI $8 %r8 
OR %r15 %r8 
XORI $16 %r8 
MOV %r1 %r10 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_enemy_bullet 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_enemy_bullet 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_enemy_bullet 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_enemy_bullet 
ADDI $6 %r10 
CMP %r10 %r11 
BEQ .after_enemy_bullet 
STOR %r8 %r11 
LOAD %r10 %r9 
ANDI $2 %r10 
CMPI $2 %r10 
BEQ .e_action_check 
ADDI $1 %r9 
CMP %r14 %r9 
BGE .grid_loop 
XORI $16 %r15 
BUC .main 
CMP %r2 %r13 
BEQ .secondary 
STORI $0 %r2 
SUBI $6 %r2 
LOAD %r8 %r2 
ORI $1 %r8 
STOR %r8 %r2 
BUC .secondary 
CMP %r2 %r14 
BEQ .secondary 
STORI $0 %r2 
ADDI $6 %r2 
LOAD %r8 %r2 
ORI $1 %r8 
STOR %r8 %r2 
BUC .secondary 
MOV %r2 %r6 
SUBI $0 %r6 
LOAD %r7 %r6 
ORI $4 %r7 
STOR %r7 %r6 
BUC .secondary 
MOVRI $4 %r10 
CMPI $0 %r10 
BNE $3 
MOVI $0 %r11 
BUC .e_spawn 
CMPI $1 %r10 
BNE $3 
MOVI $6 %r11 
BUC .e_spawn 
CMPI $2 %r10 
BNE $3 
MOVI $12 %r11 
BUC .e_spawn 
CMPI $3 %r10 
BNE $3 
MOVI $18 %r11 
BUC .e_spawn 
CMPI $4 %r10 
BNE $3 
MOVI $24 %r11 
BUC .e_spawn 
MOV %r1 %r10 
ADD %r11 %r10 
LOAD %r11 %r10 
MOVI $2 %r12 
AND %r11 %r12 
MOVI $20 %r9 
CMPI $2 %r12 
JEQ %r9 
ORI $2 %r11 
STOR %r11 %r10 
JUC %r9 
MOVRI $8 %r10 
CMPI $0 %r10 
BNE .after_enemy_check 
MOVI $0 %r11 
BUC .e_fire 
CMPI $0 %r10 
BNE $3 
MOVI $-6 %r11 
BUC .e_left 
CMPI $0 %r10 
BNE $3 
MOVI $6 %r11 
BUC .e_right 
MOV %r9 %r10 
CMP %r1 %r10 
BEQ .after_enemy_check 
BUC .e_move 
MOV %r9 %r10 
MOV %r1 %r12 
ADDI $24 %r12 
CMP %r12 %r10 
BEQ .after_enemy_check 
BUC .e_move 
ADD %r11 %r10 
MOVI $2 %r12 
LOAD %r11 %r11 
AND %r11 %r12 
CMPI $2 %r12 
BEQ .after_enemy_check 
STORI $0 %r9 
LOAD %r12 %r10 
ORI $2 %r12 
STOR %r12 %r10 
BUC .after_enemy_check 
MOV %r9 %r6 
SUBI $0 %r6 
LOAD %r7 %r6 
ORI $8 %r7 
STOR %r7 %r6 
BUC .after_enemy_check 
