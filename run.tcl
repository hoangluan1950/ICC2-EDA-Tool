###########################################
##     Lab 6  - Post CTS Optimization     #
##     SUNEDU - Le Thanh Tuan             #
###########################################

set step "post_cts"
set previuos_step "cts"

if {![file exist nlib]} {sh mkdir nlib} else {sh rm -rf nlib/* }
if {[file exist ../lab5_cts/nlib/$previuos_step.nlib]} {
   sh cp -rf ../lab5_cts/nlib/$previuos_step.nlib nlib/$step.nlib
} else {echo "Error: $previuos_step  does not exist \nPlease check data $previuos_step then retry" ;return }
sh mkdir -p reports/

####
open_lib nlib/$step.nlib
open_block ORCA_TOP
link
      
###
##### Clock setting
synthesize_clock_trees -propagate_only  ;# active clock propagated 
compute_clock_latency                   ;# compute clock latency for virtual clock
mark_clock_trees -fix_sinks -dont_touch ;# fix clock tree


##### set cell type for hold fix
set_lib_cell_purpose -exclude hold [get_lib_cells]
set_lib_cell_purpose -include hold [get_lib_cells "*/NBUFFX2_HVT */NBUFFX4_HVT */NBUFFX8_HVT"]
set_lib_cell_purpose -include hold [get_lib_cells "*/NBUFFX2_RVT */NBUFFX4_RVT */NBUFFX8_RVT"]


#### set common setting
set_app_options -name clock_opt.hold.effort -value high
set_app_options -name time.remove_clock_reconvergence_pessimism -value true
set_scenario_status -active true *


#### Report timing summary before psyn
report_qor -summary > reports/timing_qor_before_psyn.summary
report_timing -max_paths 10 -nosplit -transition_time -nets > reports/timing_before_psyn_setup.rpt
report_timing -max_paths 10 -nosplit -transition_time -nets -delay_type min > reports/timing_before_psyn_hold.rpt

#### Post cts optimization command:
clock_opt -from final_opto

save_block -as done_clock_opt_psyn
save_block

##### Report timing 
report_qor -summary > reports/timing_qor_clock_opt_psyn.summary
report_timing -max_paths 10 -nosplit -transition_time -nets > reports/clock_opt_psyn_setup.rpt
report_timing -max_paths 10 -nosplit -transition_time -nets -delay_type min > reports/clock_opt_psyn_hold.rpt
###

#######################################
# Excercise: 
# 1. Compare qor summary report before psyn and after psyn
# 2. Check violated setup timing path before psyn, verify that path after psyn to know whether psyn can fix the timing or not, and how tool fix that violation.
# 2. Check violated hold timing path before psyn, verify that path after psyn to know whether psyn can fix the timing or not, and how tool fix that violation.

### END

