###################################
#     Import Block design         #
#     SUNEDU-Le Thanh Tuan        #
###################################
### Load design setting
set step "import"
set previous_step ""


### Note: check and update variable in for ./rm_setup/design_info_setup.tcl for your block
source ./rm_setup/design_info_setup.tcl 
source ./rm_setup/setup.tcl

### Create design folder:
set NLIB "nlib/$DESIGN_LIBRARY"
if {[file exist $NLIB]} {sh rm -rf $NLIB}
if {![file exist nlib]} {sh mkdir -p nlib}

### Create nlib
create_lib -use_technology_lib $TECH_LIB -ref_libs $REFERENCE_LIBRARY $NLIB
save_lib
# ############## For hier block only ############################################
# ###  Add sub block ABS NLIB, b4core need 2 sub core: risc and bslice, 
# ###  can use floorplan or power ABD for import
# set risc_nlib   [sh realpath ../risc_core/nlib/risc_core_placement.nlib]
# set bslice_nlib [sh realpath ../bslice/nlib/bslice_placement.nlib]
# 
# set_ref_lib -add $risc_nlib
# set_ref_lib -add $bslice_nlib
# save_lib
###############################################################################

### Read verilog
read_verilog -top $DESIGN_NAME $VERILOG_NETLIST_FILES              ;# Read verilog file
link_block                                                                      ;# link block

### load UPF
reset_upf
load_upf $UPF_FILE
commit_upf
connect_pg_net -automatic
 

save_block
save_lib -all
####
close_lib -all
exit

