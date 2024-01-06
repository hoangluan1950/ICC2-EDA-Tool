###################################
#     Floorplan Block design      #
#     SUNEDU-Le Thanh Tuan        #
###################################
### Load design setting
set step "floorplan"
set previous_step "import"

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


### Read Def and initialize floorplan
set boundary_def "/home/shtp/SUNEDU/PD_K2_EXAM_ThaiHoangLuan/Work/Design/Data_In/Block_shape/bslice.def"   ;# Def file released by partition owner
read_def $boundary_def
initialize_floorplan -keep_boundary  -core_offset {2 2 2 2} -use_site_row -flip_first_row true

### routing layer setting
set_attribute [get_site_defs unit] symmetry Y
set_attribute [get_site_defs unit] is_default true

set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8}] routing_direction vertical
set_ignored_layers -max_routing_layer M8

### Add routing blockage at area not place ports

### Place pin
set_individual_pin_constraints -length 1 -allowed_layers {M4 M5 M6 M7 M8} -ports [get_ports *]
set_individual_pin_constraints -length 1 -width 0.112 -allowed_layers {M4 M5 M6 M7} -ports [get_ports *clk]

place_pins -self

### Remove routing blockages
remove_routing_blockages *

### Create boundary placement blockage
set die_boundary [get_attribute [current_block ] boundary]
set smaller_die [resize_polygons -objects $die_boundary -size {-2 -2 -2 -2}]
set all_bbox [split_polygons [compute_polygons -objects1 $die_boundary -objects2  $smaller_die -operation NOT] -output poly_rect]
set i 0
foreach_in_collection box $all_bbox {
        set bbox [get_attribute $box bbox]
        create_placement_blockage -name boundary_hard_blockage_$i -boundary $bbox -type hard
        incr i
}


### Create voltage area ##

### Create placement blockage for voltage area
set voltage_area [get_voltage_areas -filter "name!=DEFAULT_VA"]
set i 0
 if {[sizeof_collection $voltage_area] >0} {
        foreach_in_collection va $voltage_area {
        set va_boundary [get_attribute $va effective_shapes]
        set va_boundary_incr [resize_polygons -objects $va_boundary -size {2 2 2 2}]
        set all_bbox [split_polygons [compute_polygons -objects1 $va_boundary_incr -objects2 $va_boundary -operation NOT] -output poly_rect]
        foreach_in_collection box $all_bbox {
        set bbox [get_attribute $box bbox]
        create_placement_blockage -name VA_hard_blockage_$i -boundary $bbox -type hard
        incr i
        }
        }
}


### Place macro


### add placement blockage for macro
set_fixed_objects [get_cell -phy -f "design_type==macro || design_type==module"]
## Hard blockage:
set all_macro_cell [get_cells -physical_context -filter "design_type==macro || design_type==module"]
if {[sizeof_collection $all_macro_cell ]>0} {
 set i 0
 foreach_in_collection cell $all_macro_cell {
        set bbox [get_attribute $cell bbox]
        set bbx_2 [get_attribute [resize_polygons -objects $bbox -size {2 2 2 2}] bbox]
        create_placement_blockage -name macro_hard_blockage_$i -boundary $bbx_2 -type hard
        incr i
 }
}

## Soft blockage
set all_macro_cell [get_cells -physical_context -filter "design_type==macro || design_type==module"]
if {[sizeof_collection $all_macro_cell ]>0} {
 set i 0
  foreach_in_collection cell $all_macro_cell {
       set bbox [get_attribute $cell bbox]
       set bbx_2 [get_attribute [resize_polygons -objects $bbox -size {7.5 7.5 7.5 7.5}] bbox]
       create_placement_blockage -name macro_soft_blockage_$i -boundary $bbx_2 -type soft
       incr i
  }
}

### Boundary routing blockage
 set die_boundary [get_attribute [current_block ] boundary]
 set smaller_die [resize_polygons -objects $die_boundary -size {-0.8 -0.8 -0.8 -0.8}]
 set all_bbox [split_polygons [compute_polygons -objects1 $die_boundary -objects2  $smaller_die -operation NOT] -output poly_rect]
foreach_in_collection box $all_bbox {
    set bbox [get_attribute $box bbox]
        create_routing_blockage -name_prefix boundary_routing_blk -boundary $bbox -layers [get_layers *]
}


## Remove module boundary
gui_explore_logic_hierarchy -remove


#### Save block
save_block

### output data:
## write lef of block, will be used later when needed
sh mkdir -p outputs/$step
create_frame -block_all true
write_lef outputs/$step/$DESIGN_NAME.lef
write_def outputs/$step/$DESIGN_NAME.def

## Create Abstract model, use for Top PnR
create_abstract -read_only -timing_level full_interface
save_lib
close_lib -all
exit


