### Add boundary buffer
set port [get_port -f "port_type==signal" ]
set port_ISO [get_port -o [get_net -o [get_cells -p -o [ get_net -p -o [get_ports *]] -f "ref_name=~ISO*"] ]]
set port_no_ISO [remove_from_collection $port $port_ISO]
set port_no_ISO_no_clk [remove_from_collection $port_no_ISO clk]
add_buffer -new_net_names boundary_net -new_cell_names boundary_buffer -lib_cell saed32_rvt|saed32_rvt_std/NBUFFX4_RVT $port_no_ISO_no_clk
add_buffer -inverter_pair -new_net_names boundary_net -new_cell_names boundary_buffer -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT [get_port clk]
magnet_placement -cells [get_cells -p *boundary_buffer*] $port_no_ISO
set_attribute [get_cells -p *boundary_buffer*] -name physical_status -value legalize_only
set_size_only [get_cells -p *boundary_buffer*] 
legalize_placement

 
### Add guide buffer
set pin [get_pins -p -o [get_cells -p -f "design_type==macro"] -f "port_type==signal && direction==out"]
add_buffer -new_net_names guide_net -new_cell_names guide_buffer -lib_cell saed32_rvt|saed32_rvt_std/NBUFFX4_RVT $pin
magnet_placement -cells [get_cells -p *guide_buffer*] $pin
set_attribute [get_cells -p *guide_buffer*] -name physical_status -value legalize_only
set_size_only [get_cells -p *guide_buffer*]
legalize_placement

