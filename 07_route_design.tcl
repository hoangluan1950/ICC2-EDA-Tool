###################################
#     Route Block design          #
#     SUNEDU-Le Thanh Tuan        #
###################################
### Load design setting
set step "route"
set previous_step "post_cts"

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
  route.common.threshold_noise_ratio 0.25 }

source -echo rm_setup/redundant_via_rules.tcl

#Set application options for the specific routers
set_app_options -list {
    route.global.timing_driven true
    route.global.crosstalk_driven false
    route.track.timing_driven true
    route.track.crosstalk_driven true
    route.detail.timing_driven true
    route.detail.force_max_number_iterations false 
}

############################################################################
# Pre check error
set_app_options -name route.common.verbose_level -value 1

#############################################################################
## Secondary PG Routing
#############################################################################
#      Check the power supplies
report_power_domains
#      Set application options that are common to all route operations 
set_app_options -list {
  route.common.number_of_secondary_pg_pin_connections 2
  route.common.separate_tie_off_from_secondary_pg true 
}

if {[get_routing_rules -quiet VDDwide] != ""} {remove_routing_rules VDDwide }
 create_routing_rule VDDwide -widths {M1 0.1 M2 0.1 M3 0.1} -taper_distance 0.2
 set_routing_rule -rule VDDwide -min_routing_layer M2 -min_layer_mode allow_pin_connection -max_routing_layer M3 [get_nets VDD_HIGH]

route_group -nets {VDD_HIGH}

save_block -as done_2nd_pg


############################################################################
## Auto Routing fr remain nets
#############################################################################
set_ignored_layers -min_routing_layer M2 -max_routing_layer M8
route_auto

set_app_options -list {time.si_enable_analysis true}

save_block

report_qor -summary > reports/${step}.qor.summary
report_timing -max_paths 10 -nosplit -derate -nets > reports/${step}.setup.rpt
report_timing -max_paths 10 -nosplit -derate -nets -delay_type min > reports/${step}.hold.rpt
###

create_abstract -read_only -timing_level full_interface

save_lib -all
close_lib
#exit









