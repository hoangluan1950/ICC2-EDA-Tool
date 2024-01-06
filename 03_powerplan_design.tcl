###################################
#     Powerplan Block design      #
#     SUNEDU-Le Thanh Tuan        #
###################################
### Load design setting
set step "powerplan"
set previous_step "floorplan"

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

############################################################
# - Remove any existing PG rings/straps/connections
# - Remove any existing strategies, regions, ...
############################################################
 remove_pg_strategies -all
 remove_pg_patterns -all
 remove_pg_regions -all
 remove_pg_via_master_rules -all
 remove_pg_strategy_via_rules -all
 remove_routes -net_types {power ground} -ring -stripe -macro_pin_connect -lib_cell_pin_connect

### Gen pg script
generate_pg_script -input scripts/power_plan/${DESIGN_NAME}_mesh_config2.txt -output pg_command.tcl
source pg_command.tcl

set Top_PG_layer "M9"
create_terminal -of_objects [get_shapes -filter "shape_use==stripe && layer_name==$Top_PG_layer"]

#### Save block
save_block

### output data:
## write lef of block, will be used later when needed
sh mkdir -p output/$step
create_frame -block_all true
write_lef output/$step/$DESIGN_NAME.lef
write_def output/$step/$DESIGN_NAME.def

## Create Abstract model, use for Top PnR
create_abstract -read_only -timing_level full_interface

#close_lib -all
#exit


