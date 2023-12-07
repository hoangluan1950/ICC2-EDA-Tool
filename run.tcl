###########################################
##     Lab 5  - Clock tree Synthesis      #
##     SUNEDU - Le Thanh Tuan             #
###########################################

set step "cts"
set previuos_step "placement"

if {![file exist nlib]} {sh mkdir nlib} else {sh rm -rf nlib/* }
if {[file exist ../lab4_placement/nlib/$previuos_step.nlib]} {
   sh cp -rf ../lab4_placement/nlib/$previuos_step.nlib nlib/$step.nlib
} else {echo "Error: $previuos_step  does not exist \nPlease check data $previuos_step then retry" ;return }

####
open_lib nlib/$step.nlib
open_block ORCA_TOP
link
      
###
# B2. Check clock name of all modes by command:
mark_clock_trees -clear
set_attribute [get_nets -physical_context -f "dont_touch==true"] dont_touch false
  
synthesize_clock_trees -propagate_only
current_mode func
get_clocks   ;# How many clock in func mode?

## B3. Check clock summary, clock structure
sh mkdir -p reports
report_clock_qor -type summary  > reports/${step}.func.prects.clock.summary
report_clock_qor -type structure > reports/${step}.func.prects.clock.structure  

## B4. Check Clock Tree Balance Points
## Pin1: I_SDRAM_TOP/I_SDRAM_IF/sd_mux_CK/S0
#source set_bal_ig.tcl
set_clock_balance_points  -modes [all_modes]  -consider_for_balancing true \
    -balance_points [get_pins "I_SDRAM_TOP/I_SDRAM_IF/sd_mux_*/S0"]

## Pin 2: I_SDRAM_TOP/I_SDRAM_IF/sd_mux_CKn/S0
set_clock_balance_points  -modes [all_modes]  -consider_for_balancing false \
    -balance_points [get_pins "I_SDRAM_TOP/I_SDRAM_IF/sd_mux_CKn/S0"]


report_clock_balance_points > reports/report_clock_balance_points.rpt  
# Check pin 1 and pin 2 in this file report_clock_balance_points.rpt
report_clock_qor -type structure > reports/func.prects.clock.structure_2nd 
# check pin 1 and pin 2 in file func.prects.clock.structure_2nd, and compare with file func.prects.clock.structure


## B5. set Dont Touch Cells
set_dont_touch [get_cells "I_SDRAM_TOP/I_SDRAM_IF/sd_mux_*"]
report_dont_touch I_SDRAM_TOP/I_SDRAM_IF/sd_mux_*

set_dont_touch [get_cells "I_CLOCKING/sys_clk_in_reg"]
report_dont_touch I_CLOCKING/sys_clk_in_reg

## B6. Set Clock Tree Targets
set_clock_tree_options -target_skew 0.05 -corners [get_corners ss*]
set_clock_tree_options -target_skew 0.02 -corners [get_corners ff*]

report_clock_tree_options


## B7. Set cell type for CTS

derive_clock_cell_references -output cts_leq_set.tcl > /dev/null

set CTS_CELLS [get_lib_cells "*/NBUFF*LVT  */INVX*_LVT  */CGL* */LSUP* */*DFF*"]
set_attribute $CTS_CELLS dont_use false

set_lib_cell_purpose -exclude cts [get_lib_cells ] 
set_lib_cell_purpose -include cts $CTS_CELLS
source scripts/cts_include_refs.tcl

#source scripts/cts_include_refs.tcl
report_lib_cells -objects [get_lib_cells] -columns {name:20 valid_purposes dont_touch}

## CTS NDRs
####################################

source -echo scripts/ndr.tcl

report_routing_rules -verbose

report_clock_routing_rules


## Timing and DRC Setup
####################################

#      Ensure that driving cells are specified on all clock ports
report_ports -verbose [get_ports *clk]
set_driving_cell -scenarios [all_scenarios] -lib_cell NBUFFX4_RVT [get_ports ate_clk]

report_ports -verbose [get_ports *clk]

report_clocks -skew

#      Change the uncertainty for all clocks in all scenarios
foreach_in_collection scen [all_scenarios] {
  current_scenario $scen
  set_clock_uncertainty 0.1 -setup [all_clocks]
  set_clock_uncertainty 0.05 -hold [all_clocks]
}

#      Set a max transition for the clocks in func mode only
current_mode func
set_max_transition 0.15 -clock_path [get_clocks] -corners [all_corners]

set_app_options -name time.remove_clock_reconvergence_pessimism -value true

report_clock_settings

## Disable CCD feature
set_app_options -name clock_opt.flow.enable_ccd -value false


clock_opt -to route_clock

save_block

report_clock_qor -to I_SDRAM_TOP/I_SDRAM_IF/sd_mux_*/S0 -corners ss_125c > reports/Latency_of_exception_pins.rpt

###
# Report full clock reports
report_clock_qor -type structure > reports/funx.cts.clock.structure.rpt
report_clock_qor -type latency > reports/funx.cts.clock.latency.rpt
report_clock_qor -type summary > reports/funx.cts.clock.summary.rpt


save_lib -all
exit

# Also, have a look at the clock latency graph
