#########################################
#          Lab 2 - Floorplanning        #
#          SUNEDU/Le Thanh Tuan         #
#########################################

# B1. Copy lib from import design step, then open block:

set step "floorplan"
set previuos_step "import_design"

if {![file exist nlib]} {sh mkdir nlib} else {sh rm -rf nlib/* }
if {[file exist ../lab1_import_design/nlib/$previuos_step.nlib]} {
     sh cp -rf ../lab1_import_design/nlib/$previuos_step.nlib nlib/$step.nlib
} else {echo "Error: $previuos_step  does not exist \nPlease check data $previuos_step then retry" ; return }

####
open_lib nlib/$step.nlib
open_block ORCA_TOP
link


###
start_gui


## B2.  Create die and Core by 1 of 3 below methods

# Method 1: Load def file which contain block shape
read_def /home/shtp/SUNEDU/luan/lab2_floorplan/Data_In/Block_boundary.def
#read_def Block_boundary.def
initialize_floorplan -keep_boundary  -core_offset {2 2 2 2} -use_site_row -flip_first_row true 

# Method 2: reuse block cordinate
set block_shape {{1015.0800 690.8640} {1015.0800 0.0000} {0.0000 0.0000} {0.0000 596.9040} {118.8160 596.9040} {118.8160 690.8640}}

initialize_floorplan -boundary $block_shape -core_offset {2 2 2 2} -use_site_row -flip_first_row true

# Method 3: no boundary information, create a die with square shaoe, utilization 50%
initialize_floorplan -core_utilization 0.5 -core_offset {2 2 2 2} -use_site_row -flip_first_row true

# B3. Place Port and create terminal

## Add routing blockage to area dont want to place port
source Data_In/Routing_blockage_to_place_port.tcl

# set rule for terminal
set_individual_pin_constraints -length 1 -allowed_layers {M3 M4 M5} -ports [get_ports *]

# set double width for Clock terminal
set_individual_pin_constraints -length 1 -width 0.112 -allowed_layers {M3 M4 M5} -ports [get_ports *clk]

# place pin
place_pins -self
# remove routing blockage
remove_routing_blockages *


# B4. Create boundary placement blockage
set die_boundary [get_attribute [current_block ] boundary]
set smaller_die [resize_polygons -objects $die_boundary -size {-2 -2 -2 -2}]
set all_bbox [split_polygons [compute_polygons -objects1 $die_boundary -objects2  $smaller_die -operation NOT] -output poly_rect]
set i 0
foreach_in_collection box $all_bbox {
	set bbox [get_attribute $box bbox]
	create_placement_blockage -name boundary_hard_blockage_$i -boundary $bbox -type hard
	incr i
}

# B5. Create voltage area ##
source Data_In/ORCA_TOP_design_data/ORCA_TOP.VA.tcl

# B6. Create placement blockage for voltage area
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


# B7. place macro into correct voltage area
## Place by hand
## Note: All macro cell belong to a voltage area mus be placed inside that voltage area.
## To know macro cell of a voltage area, use command:
set PD_RISC_CORE_macro [ get_cells -physical_context -of_objects [get_voltage_areas PD_RISC_CORE] -filter "design_type==macro"]
change_selection $PD_RISC_CORE_macro ; # select macro cells of PD_RISC_CORE
gui_set_highlight_options -current_color purple ;# highlight to purple color
## Move macro of PD_RISC_CORE to inside of this voltage area.


## To place macro cell in same mod


## fix macro
set_fixed_objects [get_cell -phy -f "design_type==macro"]


# B8. Create placement hard blockage for macro
set all_macro_cell [get_cells -physical_context -filter "design_type==macro"]
if {[sizeof_collection $all_macro_cell ]>0} {
 set i 0
 foreach_in_collection cell $all_macro_cell {
	set bbox [get_attribute $cell bbox]
	set bbx_2 [get_attribute [resize_polygons -objects $bbox -size {2 2 2 2}] bbox]
	create_placement_blockage -name macro_hard_blockage_$i -boundary $bbx_2 -type hard
	incr i
 }
}

# B9. Create placement soft blockage for macro
set all_macro_cell [get_cells -physical_context -filter "design_type==macro"]
if {[sizeof_collection $all_macro_cell ]>0} {
 set i 0
  foreach_in_collection cell $all_macro_cell {
       set bbox [get_attribute $cell bbox]
       set bbx_2 [get_attribute [resize_polygons -objects $bbox -size {5 5 5 5}] bbox]
       create_placement_blockage -name macro_soft_blockage_$i -boundary $bbx_2 -type soft
       incr i
  }
}


# B10. create soft blockage in channel area, by hand


# B11. Create partial blockage at port with blockage ratio 50%


# B12. Create boundary routing blockage

 set die_boundary [get_attribute [current_block ] boundary]
 set smaller_die [resize_polygons -objects $die_boundary -size {-0.8 -0.8 -0.8 -0.8}]
 set all_bbox [split_polygons [compute_polygons -objects1 $die_boundary -objects2  $smaller_die -operation NOT] -output poly_rect]
foreach_in_collection box $all_bbox {
    set bbox [get_attribute $box bbox]
	create_routing_blockage -name_prefix boundary_routing_blk -boundary $bbox -layers [get_layers *]
}


# B13. Save design, write out data
gui_explore_logic_hierarchy -remove
save_block
save_lib

## Write out block boundary only
write_def -exclude {blockages bounds cells fills nets pg_metal_fills ports routing_rules rows_tracks  scanchains specialnets vias cut_metal}  Block_boundary.def

## Write out port and terminal only
write_floorplan -objects [get_ports *] -output port_dump

## Write out Voltage area only
write_floorplan -objects [get_voltage_areas *] -output VA_dump

## Write out macro placement only
write_floorplan -objects [get_cell -phy -f "design_type==macro"] -output macro_dump


stop_gui
exit



