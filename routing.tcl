###########################################
##     Lab 7  - Route                     #
##                                        #
###########################################

set step "route"
set previuos_step "post_cts"

if {![file exist nlib]} {sh mkdir nlib} else {sh rm -rf nlib/* }
if {[file exist ../lab6_post_cts/nlib/$previuos_step.nlib]} {
   sh cp -rf ../lab6_post_cts/nlib/$previuos_step.nlib nlib/$step.nlib
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

#      Set application options for the specific routers
set_app_options -list {
  route.global.timing_driven true
  route.global.crosstalk_driven false
  route.track.timing_driven true
  route.track.crosstalk_driven true
  route.detail.timing_driven true
  route.detail.force_max_number_iterations false }



#############################################################################
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
  route.common.separate_tie_off_from_secondary_pg true }

if {[get_routing_rules -quiet VDDwide] != ""} {remove_routing_rules VDDwide }
create_routing_rule VDDwide -widths {M1 0.1 M2 0.1 M3 0.1} -taper_distance 0.2
set_routing_rule -rule VDDwide -min_routing_layer M2 -min_layer_mode allow_pin_connection -max_routing_layer M3 [get_nets VDD]

route_group -nets {VDD}

save_block -as done_2nd_pg

####################################
####################################
### Excercise 2:
# 1. Select and highlight all level shifter cell by command:
#    change_selection [get_cells -physical_context -filter "ref_name=~LS*"]
# 2. Check all power pin of some level shifter cell, and name of net connect to all power pins
# 3. Check and compare shape/vias of net VDDconnect to pin VDDL of level shiter, show the difference.
# 4. Give conclusion: what 2nd_pg routing step has done ??


#############################################################################
## Auto Routing fr remain nets
#############################################################################
set_ignored_layers -min_routing_layer M2 -max_routing_layer M8
route_auto

set_app_options -list {time.si_enable_analysis true}

save_block -as done_route_auto

report_qor -summary > reports/${step}.qor.summary
report_timing -max_paths 10 -nosplit -derate -nets > reports/${step}.setup.rpt
report_timing -max_paths 10 -nosplit -derate -nets -delay_type min > reports/${step}.hold.rpt


####################################
#### Excercise 3:
# 1. Check short and drc by error browser 
# 2. Check setup violated paths, compare this path in psyn design, investigate the reason cause this violation
# 3. Rerun routing stip, add command: set_ignored_layers -min_routing_layer M2 -max_routing_layer M8 before route_auto command, then check short

### ENS Routing stage

#
