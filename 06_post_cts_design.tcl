###################################
#     POST_CTS Block design       #
#     SUNEDU-Le Thanh Tuan        #
###################################
### Load design setting
set step "post_cts"
set previous_step "cts"

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

#########################################
## Update ABS or ETM for sub block 
set BLOCK_TYPE "single"
if {$BLOCK_TYPE != "single"} {
 set sub1_name "bslice"
 set sub2_name "risc_core"
 set sub1_abs [sh realpath ../${sub1_name}/nlib/${sub1_name}_post_cts.nlib]
 set sub2_abs [sh realpath ../${sub2_name}/nlib/${sub2_name}_post_cts.nlib]
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

#################################
## MCMM Setup, 
## create mmmc again if needed
source ./scripts/mmmc/create_mcmm.tcl

##################################
source ./rm_setup/icc2_pnr_setup.tcl

#### Clock setting
synthesize_clock_trees -propagate_only  ;# active clock propagated 
compute_clock_latency                   ;# compute clock latency for virtual clock
mark_clock_trees -fix_sinks -dont_touch ;# fix clock tree

### active hold timing
set_scenario_status -hold true [get_scenarios *]

#### set cell type for hold fix
set_lib_cell_purpose -exclude hold [get_lib_cells]
set_lib_cell_purpose -include hold [get_lib_cells "*/NBUFFX2_HVT */NBUFFX4_HVT */NBUFFX8_HVT"]
set_lib_cell_purpose -include hold [get_lib_cells "*/NBUFFX2_RVT */NBUFFX4_RVT */NBUFFX8_RVT"]

### set common setting
set_app_options -name clock_opt.hold.effort -value high
set_app_options -name time.remove_clock_reconvergence_pessimism -value true
set_scenario_status -active true *


### Report timing summary before psyn
report_qor -summary > reports/timing_qor_before_psyn.summary
report_timing -max_paths 10 -nosplit -transition_time -nets > reports/timing_before_psyn_setup.rpt
report_timing -max_paths 10 -nosplit -transition_time -nets -delay_type min > reports/timing_before_psyn_hold.rpt

#### Post cts optimization command:
clock_opt -from final_opto

save_block

##### Report timing 
report_qor -summary > reports/timing_qor_clock_opt_psyn.summary
report_timing -max_paths 10 -nosplit -transition_time -nets > reports/clock_opt_psyn_setup.rpt
report_timing -max_paths 10 -nosplit -transition_time -nets -delay_type min > reports/clock_opt_psyn_hold.rpt
###

create_abstract -read_only -timing_level full_interface

save_lib -all
close_lib
#exit









