###########################################
##     Lab 8  - Route                     #
##     SUNEDU - Le Thanh Tuan             #
###########################################
set step "routeOpt"
set previuos_step "route"

if {![file exist nlib]} {sh mkdir nlib} else {sh rm -rf nlib/* }
if {[file exist ../lab7_route/nlib/$previuos_step.nlib]} {
   sh cp -rf ../lab7_route/nlib/$previuos_step.nlib nlib/$step.nlib
} else {echo "Error: $previuos_step  does not exist \nPlease check data $previuos_step then retry" ;return }
sh mkdir -p reports/

####
open_lib nlib/$step.nlib
open_block ORCA_TOP
link



#############################################################################
#      Routing settings
#############################################################################
##      Antenna
source -echo ../ref/tech/saed32nm_ant_1p9m.tcl
report_app_options route.detail.*antenna*
set_app_options -list {
  route.common.post_detail_route_redundant_via_insertion medium
  route.common.threshold_noise_ratio 0.25 }

source -echo scripts/redundant_via_rules.tcl

#Set application options for the specific routers
set_app_options -list {
  route.global.timing_driven true
  route.global.crosstalk_driven false
  route.track.timing_driven true
  route.track.crosstalk_driven true
  route.detail.timing_driven true
  route.detail.force_max_number_iterations false }


set_app_options -list {time.si_enable_analysis true}

report_qor -summary > reports/before_routeOpt_qor.summary

####################################
# route opt
route_opt

save_block -as done_route_opt

report_qor -summary > reports/routeOpt_qor.summary
report_timing -max_paths 10 -nosplit -derate -nets -transition_time > reports/routeOpt_setup.rpt
report_timing -max_paths 10 -nosplit -derate -nets -transition_time -delay_type min > reports/routeOpt_hold.rpt

####################################
#### Excercise 
# 1. Check short and drc by error browser 
# 2. Check timing qor summary, compare with summary before route Opt
# 3. Check remain timing violation in design, and fix it manually if any


### ENS Route Opt stage

## Check design
# LVS
check_lvs 
# Antenna, short, drc
check_routes
#

save_block

close_lib -all
exit


