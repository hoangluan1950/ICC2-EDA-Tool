################################
#     Lab 4  - Placement       #
#     SUNEDU - Le Thanh Tuan   #
################################

set step "placement"
set previuos_step "powerplan"

if {![file exist nlib]} {sh mkdir nlib} else {sh rm -rf nlib/* }
if {[file exist ../lab3_powerplan/nlib/$previuos_step.nlib]} {
     sh cp -rf ../lab3_powerplan/nlib/$previuos_step.nlib nlib/$step.nlib
} else {echo "Error: $previuos_step  does not exist \nPlease check data $previuos_step then retry" ; return }

####
open_lib nlib/$step.nlib
open_block ORCA_TOP
link


## setting #
source ./rm_setup/icc2_pnr_setup.tcl

#################################
## MCMM Setup
##################################
source -echo scripts/mcmm_ORCA_TOP.tcl

# check scenarios by command
report_scenario

## set scenarios ff to false, not need it in placeopt
set_scenario_status -active false [get_scenarios ff_Cmin_125c_func]

### check scenarios by command :
report_scenario

#### Excercise: check below items ####
# 1. read command in file: scripts/mcmm_ORCA_TOP.tcl to understand how to create mode, corner, scenarios and all related settings
# 2. List down all corner, modes and scenarios.
# 3. Answer question: what scenarios used for setup timing, what scenario used for hold timing.
# 4. Answer question: what is PVT check result ? Pass or fail
# end mmmc ###

### Report PVT to see if any pvt mismatch
report_pvt

#### set placement setting
set TIE_LIB_CELL_PATTERN_LIST "*/TIE*"

set_lib_cell_purpose -include optimization [get_lib_cells $TIE_LIB_CELL_PATTERN_LIST]
set_attribute [get_lib_cells $TIE_LIB_CELL_PATTERN_LIST]  -name dont_use -value false
### Set dont use cell
set dont_use_lib [get_lib_cells {*/*LVT}]

set_lib_cell_purpose -exclude optimization $dont_use_lib
set_attribute $dont_use_lib dont_use true

# Limit the fanout of each tie cell to 8
set_app_options -list {opt.tie_cell.max_fanout 8}
mark_clock_trees -dont_touch

set_app_options -name place.coarse.enhanced_auto_density_control -value true
reset_app_options opt.dft.optimize_scan_chain
report_app_options  opt.dft.optimize_scan_chain
set_app_options -name place.legalize.enable_advanced_legalizer -value true
set_app_options -name opt.common.enable_rde -value true

#
check_mv_design > reports/report_mv.before_placement
#


#
#source scripts/keepouts.tcl
# set max layer, min layer
set_ignored_layers -min_routing_layer M1 -max_routing_layer M8

### check utilization
report_utilization > reports/report_utilization.before_placement
echo "Number of STD cell:  [sizeof_collection [get_cells -physical_context -filter "design_type!=macro"]]" >> reports/report_utilization.before_placement
echo "Number of Macro cell: [sizeof_collection [get_cells -physical_context -filter "design_type==macro"]]" >> reports/report_utilization.before_placement
#############################################################################
# Placement steps

#############################################################################
## Step 1: coarse  placement
 place_opt -from initial_place -to initial_place
## Check global route congestion after coarse  placement
 route_global -congestion_map_only true

#save coarse  placement block
 save_block -as initial_place

## Report utilization
report_utilization > reports/report_utilization.initial_place
echo "Number of STD cell:  [sizeof_collection [get_cells -physical_context -filter "design_type!=macro"]]" >> reports/report_utilization.initial_place
echo "Number of Macro cell: [sizeof_collection [get_cells -physical_context -filter "design_type==macro"]]" >> reports/report_utilization.initial_place


#### Excercise: check below items ####
# 1. Check global route congestion map ,view congestion map in GUI
# 2. Compare utilization, number of cell before and after coarse  placement (check file *utilization.initial_place and *utilization.before_placement)
# 3. Check STD cell overlap, view in GUI
## Finish placement step 1 

#############################################################################
### Step 2: init_drc
 place_opt -from initial_drc -to initial_drc
 save_block -as initial_drc

##Report:
report_utilization > reports/report_utilization.initial_drc
echo "Number of STD cell:  [sizeof_collection [get_cells -physical_context -filter "design_type!=macro"]]" >> reports/report_utilization.initial_drc
echo "Number of Macro cell: [sizeof_collection [get_cells -physical_context -filter "design_type==macro"]]" >> reports/report_utilization.initial_drc

report_qor -summary > reports/report_qor_summary.initial_drc.rpt

#### Excercise: check below items ####
# 1. Compare utilization, number of cell between initial_place and initial_drc (check file *utilization.initial_place and *utilization.initial_drc)
# 2. Check STD cell overlap, view in GUI 

## Finish placement step 2, initial_drc

#############################################################################
### Step 3: initial_opto to final_opto
 place_opt -from initial_opto -to final_opto
 route_global -congestion_map_only true
 save_block -as final_opto
 save_block -as ORCA_TOP_PlaceOpt
 save_block
##Report:
report_utilization > reports/${step}_utilization.rpt
echo "Number of STD cell:  [sizeof_collection [get_cells -physical_context -filter "design_type!=macro"]]" >>  reports/${step}_utilization.rpt
echo "Number of Macro cell: [sizeof_collection [get_cells -physical_context -filter "design_type==macro"]]" >> reports/${step}_utilization.rpt
report_qor -summary > reports/${step}.qor_summary.rpt
report_timing -report_by group > reports/${step}.timing_group_summary.rpt
report_timing -max_paths 10 -transition_time -nets > reports/${step}.timing.rpt
report_threshold_voltage_groups > reports/${step}.vth_ratio.rpt

#create_utilization_configuration dflt -exclude {hard_macros macro_keepouts soft_macros io_cells hard_blockages}
#report_utilization -config dflt -of_objects [get_voltage_areas *] reports/${ste].voltage_area.utilization.rpt

stop_gui
save_lib -all
#close_lib -all
#exit
