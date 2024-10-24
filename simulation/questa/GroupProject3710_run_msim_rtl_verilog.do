transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/alucontrol.v}
vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/GroupProject3710.v}
vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/shifter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/flops.v}
vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/muxes.v}
vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/bram.v}

vlog -vlog01compat -work work +incdir+C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project {C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/Datapath_Memory_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Datapath_Memory_tb

add wave *
view structure
view signals
run 100 ns
