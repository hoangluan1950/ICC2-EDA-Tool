###################################
#     CTS Block design            #
#     SUNEDU-Le Thanh Tuan        #
###################################
### Load design setting
set step "cts"
set previous_step "placement"

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

##########################################
## Update ABS or ETM for sub block 
set BLOCK_TYPE "single"
if {$BLOCK_TYPE != "single"} {
 set sub1_name "bslice"
 set sub2_name "risc_core"
 set sub1_abs [sh realpath ../${sub1_name}/nlib/${sub1_name}_cts.nlib]
 set sub2_abs [sh realpath ../${sub2_name}/nlib/${sub2_name}_cts.nlib]
 stop_gui ; close_block -f
 set_ref_libs -clear

 foreach lib $REFERENCE_LIBRARY {
   set_ref_libs -add $lib
 }
 set_ref_libs -add $sub1_abs
 set_ref_libs -add $sub2_abs

 open_block $DESIGN_NAME
 link_block -rebind -force

}
##########################################
source ./rm_setup/icc2_pnr_setup.tcl


##########################################
# Create mmmc again if needed
source ./scripts/mmmc/create_mcmm.tcl

mark_clock_trees -clear
set_attribute [get_nets -physical_context -f "dont_touch==true"] dont_touch false

synthesize_clock_trees -propagate_only


##########################################
## set clock exception for sub block
if {$BLOCK_TYPE != "single"} {
 set sub1_exception_file [lindex [glob ls ../$sub1_name/clock_auto_exceptions*.tcl] end]
 set sub2_exception_file [lindex [glob ls ../$sub2_name/clock_auto_exceptions*.tcl] end]
 set sub1_inst_name1 "bslice_x1"
 set sub1_inst_name2 "bslice_x2"
 set sub1_inst_name3 "bslice_y1"
 set sub1_inst_name4 "bslice_y2"
 set sub2_inst_name1 "risc_core"

 echo "sed 's/get_pin /get_pin $sub1_inst_name1\\//g' $sub1_exception_file > $sub1_inst_name1.clock_exception.add_prefix" > cmd
 echo "sed 's/get_pin /get_pin $sub1_inst_name2\\//g' $sub1_exception_file > $sub1_inst_name2.clock_exception.add_prefix" >> cmd
 echo "sed 's/get_pin /get_pin $sub1_inst_name3\\//g' $sub1_exception_file > $sub1_inst_name3.clock_exception.add_prefix" >> cmd
 echo "sed 's/get_pin /get_pin $sub1_inst_name4\\//g' $sub1_exception_file > $sub1_inst_name4.clock_exception.add_prefix" >> cmd
 echo "sed 's/get_pin /get_pin $sub2_inst_name1\\//g' $sub2_exception_file > $sub2_inst_name1.clock_exception.add_prefix" >> cmd
 sh source ./cmd

 source -c ./$sub1_inst_name1.clock_exception.add_prefix
 source -c ./$sub1_inst_name2.clock_exception.add_prefix
 source -c ./$sub1_inst_name3.clock_exception.add_prefix
 source -c ./$sub1_inst_name4.clock_exception.add_prefix
 source -c ./$sub2_inst_name1.clock_exception.add_prefix
}
##########################################
report_clock_qor -type summary  > reports/${step}.func.prects.clock.summary
report_clock_qor -type structure > reports/${step}.func.prects.clock.structure


# B6. Set Clock Tree Targets
set_clock_tree_options -target_skew 0.05 -corners [get_corners ss*]

derive_clock_cell_references -output cts_leq_set.tcl > /dev/null

set CTS_CELLS [get_lib_cells "*/NBUFF*LVT  */INVX*_LVT  */CGL* */LSUP* */*DFF*"]
set_attribute $CTS_CELLS dont_use false

set_lib_cell_purpose -exclude cts [get_lib_cells ]
set_lib_cell_purpose -include cts $CTS_CELLS

source rm_setup/cts_include_refs.tcl
report_lib_cells -objects [get_lib_cells] -columns {name:20 valid_purposes dont_touch}

## CTS NDRs
####################################
source -echo rm_setup/ndr.tcl

report_routing_rules -verbose
report_clock_routing_rules

## Timing and DRC Setup
###################################

#      Ensure that driving cells are specified on all clock ports
report_ports -verbose [get_ports *clk]
set_driving_cell -scenarios [all_scenarios] -lib_cell NBUFFX4_LVT [get_ports *clk* -filter "direction==in" ]

report_ports -verbose [get_ports *clk]

report_clocks -skew

#      Change the uncertainty for all clocks in all scenarios
foreach_in_collection scen [all_scenarios] {
  current_scenario $scen
  set_clock_uncertainty 0.1 -setup [all_clocks]
  set_clock_uncertainty 0.05 -hold [all_clocks]
}
#	Set balance point
set_clock_balance_points -consider_for_balancing true -modes [all_modes ] -balance_points oeb_reg/CLK -delay 0.4
set_clock_balance_points -consider_for_balancing true -modes [all_modes ] -balance_points bslice_pre/s1_op2_reg[3][43]/CLK -delay 0.22
set_clock_balance_points -consider_for_balancing true -modes [all_modes ] -balance_points bslice_pre/s1_op2_reg[3][46]/CLK -delay 0.21
set_clock_balance_points -consider_for_balancing true -modes [all_modes ] -balance_points bslice_pre/s1_op2_reg[0][39]/CLK -delay 0.16
#set_clock_balance_points -consider_for_balancing true -modes [all_modes ] -balance_points bslice_pre/s1_op1_reg[1][30]/CLK -delay 0.25

#      Set a max transition for the clocks in func mode only
current_mode func
set_max_transition 0.15 -clock_path [get_clocks] -corners [all_corners]

set_app_options -name time.remove_clock_reconvergence_pessimism -value true

report_clock_settings

## Disable CCD feature
set_app_options -name clock_opt.flow.enable_ccd -value false

### Do CTS
clock_opt -to route_clock

save_block

report_clock_qor -type structure > reports/cts.clock.structure.rpt
report_clock_qor -type latency > reports/cts.clock.latency.rpt
report_clock_qor -type summary > reports/cts.clock.summary.rpt




# write lef of block, will be used later when needed
#sh mkdir -p output/$step
#write_def output/$step/$DESIGN_NAME.def

## Create Abstract model, use for Top PnR
create_abstract -read_only -timing_level full_interface




save_lib -all
close_lib
#exit








