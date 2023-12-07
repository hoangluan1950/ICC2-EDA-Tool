#######################################
# Lab 1  - import design              # 
#######################################
# Exercise 1:
if {![file exist nlib]} { sh mkdir -p nlib}  ;# create nlib folder if it does not exist
if {![file exist nlib]} {sh mkdir nlib} else {sh rm -rf nlib/* }


create_lib -technology Data_In/tech/saed32nm_1p9m.tf nlib/import_design.nlib    ;# Create nlib with tech file
read_verilog -top ORCA_TOP Data_In/ORCA_TOP_design_data/ORCA_TOP.v              ;# Read verilog file
link_block                                                                      ;# link block

##
# Question 1 ? Check error/Warning log and think of reason of error/Warning then continue:

start_gui ;# check location of cells


close_lib -force   ;# close lib without saving
stop_gui   ;# close GUI
######################################
# Exercise 2:
# #####################################
if {![file exist nlib]} { sh mkdir -p nlib}
if {[file exist nlib/import_design.nlib]} { sh rm -rf nlib/import_design.nlib}
set ndm_path [glob ls Data_In/CLIBs/*.ndm]   ;# collect all ndm files to variable ndm_path
create_lib -technology Data_In/tech/saed32nm_1p9m.tf -ref_libs  $ndm_path nlib/import_design.nlib 
read_verilog -top ORCA_TOP Data_In/ORCA_TOP_design_data/ORCA_TOP.v
link_block


##
# Question 2 ? Check error log and think of reason of different log compare to exercise 1

save_lib -all

list_block   ;# check block in lib

####
start_gui ;# check location of cells
##
# Question 3: What is difference in layout, compare to exercise 1 ? What is reason ?


##
set  power_net_name_1 [get_object_name [get_nets -physical_context -filter "net_type==power"]]


### load upf
load_upf Data_In/ORCA_TOP_design_data/ORCA_TOP.upf
commit_upf
connect_pg_net -automatic

##
set  power_net_name_2 [get_object_name [get_nets -physical_context -filter "net_type==power"]]

##
# Question 4 ? Compare $power_net_name_1 with $power_net_name_2 , find the reason of difference

### Load scan def
read_def Data_In/ORCA_TOP_design_data/ORCA_TOP.scandef

### set layer
set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8}] routing_direction vertical
set_ignored_layers -max_routing_layer M8


save_block
save_lib -all
####
close_lib -all





