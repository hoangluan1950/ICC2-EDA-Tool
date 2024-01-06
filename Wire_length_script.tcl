###	Real wire
foreach_in_collection net [get_net -p -o [get_port -f "port_type==signal"]] {
set vr_length [get_att [get_net -p $net ] vr_length]
echo "[get_object_name $net] \t $vr_length"
} > vr_length_to_port.rpt
 
####	Virtual wire
foreach_in_collection net [get_net -p -o [get_port -f "port_type==signal"]] {
set dr_length [get_att [get_net -p $net ] dr_length]
echo "[get_object_name [get_net $net]] \t $dr_length"
} > dr_length_to_port.rtp
 
###	Detour
awk 'FNR==NR {dr_length_to_port_rtp[FNR]=$1; vr_length_to_port_rpt[FNR]=$2; next} {print dr_length_to_port_rtp[FNR], vr_length_to_port_rpt[FNR]/$2}' dr_length_to_port.rtp vr_length_to_port.rpt > Detour_net_to_port.rpt 
