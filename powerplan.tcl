################################
#     Lab 3  - Powerplan       #
#                              #
################################

# B1. Copy lib from floorplan step, then open block

set step "powerplan"
set previuos_step "floorplan"

if {![file exist nlib]} {sh mkdir nlib} else {sh rm -rf nlib/* }
if {[file exist ../lab2_floorplan/nlib/$previuos_step.nlib]} {
     sh cp -rf ../lab2_floorplan/nlib/$previuos_step.nlib nlib/$step.nlib
} else {echo "Error: $previuos_step  does not exist \nPlease check data $previuos_step then retry" ; return }

####
open_lib nlib/$step.nlib
open_block ORCA_TOP
link


###
start_gui

# B2. Source power script to build power mesh
source -echo scripts/pns.tcl


# B3. Check PG connectivity
check_pg_connectivity

# B4. Check PG missing via
check_pg_missing_vias

# B5. Check PG drc
check_pg_drc


save_block
# B6.  Write floorplan for later re-use in ICC2
 write_floorplan -net_types {power ground} \
   -include_physical_status {fixed locked} \
   -read_def_options {-add_def_only_objects all -no_incremental} \
   -force -output ORCA_TOP.fp/

# B7. Write floorplan for DCG:
 write_floorplan -net_types {power ground} \
   -include_physical_status {fixed locked} \
   -format icc \
   -force -output ORCA_TOP.fp.dc

# B8. Save data and finish
save_block
save_lib
stop_gui
exit
