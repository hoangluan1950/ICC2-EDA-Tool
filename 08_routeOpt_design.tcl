###################################
#     RouteOpt Block design       #
#     SUNEDU-Le Thanh Tuan        #
###################################
### Load design setting
set step "routeOpt"
set previous_step "route"

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


##################################
source ./rm_setup/icc2_pnr_setup.tcl

############################################################################
#      Routing settings
#############################################################################
##      Antenna
source -echo rm_setup/saed32nm_ant_1p9m.tcl
report_app_options route.detail.*antenna*

set_app_options -list {
  route.common.post_detail_route_redundant_via_insertion medium
  route.common.threshold_noise_ratio 0.25
}

source -echo ./rm_setup/redundant_via_rules.tcl

# Set application options for the specific routers
set_app_options -list {
    route.global.timing_driven true
    route.global.crosstalk_driven false
    route.track.timing_driven true
    route.track.crosstalk_driven true
    route.detail.timing_driven true
    route.detail.force_max_number_iterations false 
}

set_app_options -list {time.si_enable_analysis true}

report_qor -summary > reports/before_routeOpt_qor.summary

### RouteOp

route_opt
#route_opt
#route_opt

save_block

report_qor -summary > reports/routeOpt_qor.summary
report_timing -max_paths 10 -nosplit -derate -nets -transition_time > reports/routeOpt_setup.rpt
report_timing -max_paths 10 -nosplit -derate -nets -transition_time -delay_type min > reports/routeOpt_hold.rpt

### create ABS
create_abstract -read_only -timing_level full_interface

save_lib -all
close_lib
#exit









