###################################
#     Placement Block design      #
#     SUNEDU-Le Thanh Tuan        #
###################################
### Load design setting
set step "placement"
set previous_step "powerplan"

### Note: check and update variable in for ./rm_setup/design_info_setup.tcl for your block
source ./rm_setup/design_info_setup.tcl 
source ./rm_setup/setup.tcl
### Copy nlib:
set NLIB "nlib/$DESIGN_LIBRARY"
if {[file exist $NLIB]} {sh rm -rf $NLIB}
if {[file exist nlib/$Previous_nlib]} {sh cp -rf  nlib/$Previous_nlib $NLIB} else {echo "Previous design does not exist, please check again"}

### Open design
open_lib $NLIB
open_block $DESIGN_NAME
link_block


#################################
## MCMM Setup
##################################
source ./rm_setup/icc2_pnr_setup.tcl

source -echo scripts/mmmc/create_mcmm.tcl

report_pvt
##
set_lib_cell_purpose -include optimization [get_lib_cells $TIE_LIB_CELL_PATTERN_LIST]
set_dont_touch [get_lib_cells $TIE_LIB_CELL_PATTERN_LIST] false
#      Limit the fanout of each tie cell to 8
set_app_options -name opt.tie_cell.max_fanout -value 8

##
set_app_options -name place.coarse.enhanced_auto_density_control -value true
set_app_options -name opt.dft.optimize_scan_chain -value false
set_app_options -name place.coarse.continue_on_missing_scandef -value true
set_app_options -name place.legalize.enable_advanced_legalizer -value true
set_app_options -name opt.common.enable_rde -value true

##
check_mv_design


## place ISO cell first
set ISO_cell [get_cells -p -o [ get_net -p -o [get_ports *]] -f "ref_name=~ISO*"]
set port_ISO [get_port -o [get_net -o [get_cells -p -o [ get_net -p -o [get_ports *]] -f "ref_name=~ISO*"] ]]
magnet_placement -cells $ISO_cell  $port_ISO
set_attribute $ISO_cell -name physical_status -value legalize_only
legalize_placement

### Add boundary buffer
set port [get_port -f "port_type==signal" ]
set port_ISO [get_port -o [get_net -o [get_cells -p -o [ get_net -p -o [get_ports *]] -f "ref_name=~ISO*"] ]]
set port_no_ISO [remove_from_collection $port $port_ISO]
set port_no_ISO_no_clk [remove_from_collection $port_no_ISO clk]
add_buffer -new_net_names boundary_net -new_cell_names boundary_buffer -lib_cell saed32_rvt|saed32_rvt_std/NBUFFX4_RVT $port_no_ISO_no_clk
add_buffer -inverter_pair -new_net_names boundary_net -new_cell_names boundary_buffer -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT [get_port clk]
magnet_placement -cells [get_cells -p *boundary_buffer*] $port_no_ISO
set_attribute [get_cells -p *boundary_buffer*] -name physical_status -value legalize_only
set_size_only [get_cells -p *boundary_buffer*]
legalize_placement


### Add guide buffer
set pin [get_pins -p -o [get_cells -p -f "design_type==macro"] -f "port_type==signal && direction==out"]
add_buffer -new_net_names guide_net -new_cell_names guide_buffer -lib_cell saed32_rvt|saed32_rvt_std/NBUFFX4_RVT $pin
magnet_placement -cells [get_cells -p *guide_buffer*] $pin
set_attribute [get_cells -p *guide_buffer*] -name physical_status -value legalize_only
set_size_only [get_cells -p *guide_buffer*]
legalize_placement



##
place_opt -from initial_place -to initial_place
place_opt -from initial_drc -to initial_drc
place_opt -from initial_opto -to final_opto
##
route_global  -congestion_map_only true
save_block

#####
report_qor -summary  > reports/${step}.timing_qor_summary.rpt
report_threshold_voltage_groups > reports/${step}.vth_ratio.rpt
report_timing  > reports/${step}.timing.rpt
report_timing -report_by group > reports/${step}.timing_group_summary.rpt


#### Save block
save_block

### output data:
## write lef of block, will be used later when needed
sh mkdir -p outputs/$step
write_def outputs/$step/$DESIGN_NAME.def

## Create Abstract model, use for Top PnR
create_abstract -read_only -timing_level full_interface

#close_lib -all
#exit


