##################################
#     Chip Finish Block design   #
#     SUNEDU-Le Thanh Tuan       #
##################################
### Load design setting
set step "chip_finish"
set previous_step "routeOpt"

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

####################
# Remove filler
if {[sizeof_collection [get_cells -physical_context xofiller* -q]]>0} {
   remove_cell [get_cells -physical_context xofiller*]
}

####################
# Filler cell insertion
set SH_FILLERS "*/SHFILL128_HVT */SHFILL64_HVT */SHFILL3_HVT */SHFILL2_HVT */SHFILL1_HVT */SHFILL2_RVT */SHFILL1_RVT"
create_stdcell_fillers -lib_cells $SH_FILLERS
connect_pg_net

####################
# ICV In-Design DRC 
set_app_options -name signoff.check_drc.runset              -value ./ref/icv_runsets/saed32nm_1p9m_drc_rules.rs
set_app_options -name signoff.check_drc.max_errors_per_rule -value 1000
set_app_options -name signoff.check_drc.run_dir             -value "z_icvDRC_run"

# To reduce runtime, we only check a few layers
signoff_check_drc -select_rules { "M2*" "M3*" "M4*" "M5*" "M6*" }
save_lib

## set_app_options -name signoff.fix_drc.init_drc_error_db -value "z_icvDRC_run"
## signoff_fix_drc -select_rules { "M2*" "M3*" "M4*" "M5*" "M6*" }


####################
# ICV In-Design Metal Fill

set_app_options -name signoff.create_metal_fill.runset -value ./ref/icv_runsets/saed32nm_1p9m_mfill_rules.rs

signoff_create_metal_fill

# Or to perform track fill:
# signoff_create_metal_fill -track_fill generic 

save_block

## output data



#close_lib -all
#exit







