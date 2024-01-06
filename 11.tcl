       current_scenario
       report_timing -max_paths 250 -slack_lesser_than 0 > timing_path.rpt
       report_timing -max_paths 2 -slack_lesser_than 0
       exec csh -c {less timing_path.rpt }
       exec csh -c {less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq  }
      exec csh -c {less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl  }
      source size_cell.tcl
      for {set i 0} {$i < 20} {incr i} {
	        report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	        set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	              exec csh -c $command
	        source size_cell.tcl     }
      for {set i 0} {$i < 20} {incr i} {
	                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                      exec csh -c $command
	                source size_cell.tcl     }
      for {set i 0} {$i < 20} {incr i} {
	                        report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                        set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                              exec csh -c $command
	                        source size_cell.tcl     }
      for {set i 0} {$i < 20} {incr i} {
	                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                                      exec csh -c $command
	                                source size_cell.tcl     }
      for {set i 0} {$i < 20} {incr i} {
	                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                                      exec csh -c $command
	                                source size_cell.tcl     }
      for {set i 0} {$i < 20} {incr i} {
		                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
		                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
		                                      exec csh -c $command
		                                source size_cell.tcl     }
      for {set i 0} {$i < 20} {incr i} {
			                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
			                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
			                                      exec csh -c $command
			                                source size_cell.tcl     }
      for {set i 0} {$i < 100} {incr i} {
				                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
				                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
				                                      exec csh -c $command
				                                source size_cell.tcl     }
      for {set i 0} {$i < 100} {incr i} {
					                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
					                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
					                                      exec csh -c $command
					                                source size_cell.tcl     }
      for {set i 0} {$i < 100} {incr i} {
						                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
						                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
						                                      exec csh -c $command
						                                source size_cell.tcl     }
      report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
      current_scenario
      exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }
      get_timing_paths -from bslice_post/s2_op2_reg[3][43]
      get_timing_paths -to bslice_post/s2_op2_reg[3][43]
      get_timing_paths -to bslice_post/s2_op2_reg[3][43] -delay_type min
      get_timing_paths -from bslice_post/s2_op2_reg[3][43]
      get_timing_paths -from bslice_post/s2_op2_reg[3][43]
      echo " foreach i { [exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }]} {get_timing_paths -from \$\i >> path } " > get_timing_path_script
      get_timing_paths -from bslice_post/s2_op1_reg[1][7]
      source get_timing_path_script
      exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }
      exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' } > endpoint
      source get_timing_path_script
      exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }
      exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "get_timing_paths -from " $2}' }
      exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "get_timing_paths -from " $2">> path" }' }
      exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "get_timing_paths -from " $2" >> path" }' }
      source get_timing_path_script
      exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path}
      exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path|sed 's/_slack_/\t/g' }
      exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path|sed 's/_slack_/  /g' }
      exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path|sed 's/_slack_/  /g'|sed 's/\}//g' }
      exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.09' }
      exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.09 {print $1 }' }
      exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.09 {print $1 }' } > endpoint_met
      exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.09 {print $1"/CLK" }' } > endpoint_met
      exec csh -c {less endpoint_met }
      exec csh -c {less endpoint_met |awk '{print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT "$0 } ' }
      exec csh -c {less endpoint_met |awk '{print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT "$0 } ' } > add_INV_script
      source add_INV_script
     report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
     current_scenario
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}'|awk ' ! /bslice_post\/s3_op2_reg\[2\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[3\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[1\]\[63\]/'|awk '! /bslice_post\/s3_op2_reg\[1\]\[62\]/'|awk '! /bslice_post\/s3_op2_reg\[0\]\[63\]/'  } > endpoint_met
     echo " foreach i { [exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}'|awk ' ! /bslice_post\/s3_op2_reg\[2\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[3\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[1\]\[63\]/'|awk '! /bslice_post\/s3_op2_reg\[1\]\[62\]/'|awk '! /bslice_post\/s3_op2_reg\[0\]\[63\]/'  } ] } {get_timing_paths -from \$\i >> path_2 } "
     echo " foreach i { [exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}'|awk ' ! /bslice_post\/s3_op2_reg\[2\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[3\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[1\]\[63\]/'|awk '! /bslice_post\/s3_op2_reg\[1\]\[62\]/'|awk '! /bslice_post\/s3_op2_reg\[0\]\[63\]/'  } ] } {get_timing_paths -from \$\i >> path_2 } " > get_timing_path_script
     source get_timing_path_script
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}'|awk ' ! /bslice_post\/s3_op2_reg\[2\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[3\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[1\]\[63\]/'|awk '! /bslice_post\/s3_op2_reg\[1\]\[62\]/'|awk '! /bslice_post\/s3_op2_reg\[0\]\[63\]/'  }
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}'|awk ' ! /bslice_post\/s3_op2_reg\[2\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[3\]\[63\]/'|awk ' ! /bslice_post\/s3_op2_reg\[1\]\[63\]/'|awk '! /bslice_post\/s3_op2_reg\[1\]\[62\]/'|awk '! /bslice_post\/s3_op2_reg\[0\]\[63\]/'  } > endpoint
     exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path_2|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.05 {print $1"/CLK" }' } > endpoint_met
     exec csh -c {less endpoint_met |awk '{print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT "$0 } ' }
     exec csh -c {less endpoint_met |awk '{print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT "$0 } ' } > add_INV_script
     source add_INV_script
     for {set i 0} {$i < 20} {incr i} {
	                        report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                        set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                              exec csh -c $command
	                        source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
		                        report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
		                        set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
		                              exec csh -c $command
		                        source size_cell.tcl     }
     report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
     current_scenario
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "get_timing_paths -from " $2" >> path_3" }' }
     echo " foreach i { [exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }]} {get_timing_paths -from \$\i >> path_3 } " > get_timing_path_script
     echo " foreach i { [exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }]} {get_timing_paths -from \$\i >> path_3 } " > get_timing_path_script

     source get_timing_path_script
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' } >  endpoint
     exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.09 {print $1"/CLK" }' } > endpoint_met
     exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path_3|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.04 {print $1"/CLK" }' }
     exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path_3|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.02 {print $1"/CLK" }' }
     exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path_3|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.02 {print $1"/CLK" }' } > endpoint_met
     exec csh -c {less endpoint_met |awk '{print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT "$0 } ' } > add_INV_script
     source add_INV_script
     for {set i 0} {$i < 20} {incr i} {
	                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                                                      exec csh -c $command
	                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
		                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
		                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
		                                                      exec csh -c $command
		                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
			                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
			                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
			                                                      exec csh -c $command
			                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
				                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
				                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
				                                                      exec csh -c $command
				                                                source size_cell.tcl     }
     report_timing -max_paths 100 -slack_lesser_than 0 > timing_path.rpt
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' } > endpoint
     echo " foreach i { [exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }]} {get_timing_paths -from \$\i >> path_4 } " > get_timing_path_script
     source get_timing_path_script
     exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path_3|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.02 {print $1"/CLK" }' }
     exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path_3|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.02 {print $1"/CLK" }' } > endpoint_met
     exec csh -c {less endpoint_met |awk '{print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT "$0 } ' } > add_INV_script
     source add_INV_script
     for {set i 0} {$i < 20} {incr i} {
	                                                        report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                                                        set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                                                              exec csh -c $command
	                                                        source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
		                                                        report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
		                                                        set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
		                                                              exec csh -c $command
		                                                        source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
			                                                        report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
			                                                        set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
			                                                              exec csh -c $command
			                                                        source size_cell.tcl     }
     report_timing -max_paths 100 -slack_lesser_than 0 > timing_path.rpt
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' } > endpoint
     echo " foreach i { [exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }]} {get_timing_paths -from \$\i >> path_5 } " > get_timing_path_script
     source get_timing_path_script
     exec csh -c {awk 'FNR==NR {endpoint[NR]=$1; next} {print endpoint[FNR],$1}' endpoint path_3|sed 's/_slack_/  /g'|sed 's/\}//g'|awk '$3>0.02 {print $1"/CLK" }' } > endpoint_met
     exec csh -c {less endpoint_met |awk '{print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT "$0 } ' } > add_INV_script
     source add_INV_script
     for {set i 0} {$i < 20} {incr i} {
	                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                                                                      exec csh -c $command
	                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
		                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
		                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
		                                                                      exec csh -c $command
		                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
			                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
			                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
			                                                                      exec csh -c $command
			                                                                source size_cell.tcl     }
     report_timing -max_paths 37 > rpt
     size_cell bslice_pre/gre_d_INV_7272_inst_73938 INVX16_LVT
     for {set i 0} {$i < 20} {incr i} {
				                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
				                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
				                                                                      exec csh -c $command
				                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
					                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
					                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
					                                                                      exec csh -c $command
					                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
						                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
						                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
						                                                                      exec csh -c $command
						                                                                source size_cell.tcl     }
     report_timing -max_paths 100 -slack_lesser_than 0 > timing_path.rpt
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print $2}' }
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT  "$2}' }
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT  "$2}' } > add_INV_script
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT  "$2}' }
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT  "$2"/CLK"}' }
     exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT  "$2"/CLK"}' } > add_INV_script
     source add_INV_script
     for {set i 0} {$i < 20} {incr i} {
						                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
						                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
						                                                                      exec csh -c $command
						                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
							                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
							                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
							                                                                      exec csh -c $command
							                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
								                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
								                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
								                                                                      exec csh -c $command
								                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
									                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
									                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
									                                                                      exec csh -c $command
									                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
										                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
										                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
										                                                                      exec csh -c $command
										                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
											                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
											                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
											                                                                      exec csh -c $command
											                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
												                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
												                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
												                                                                      exec csh -c $command
												                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
													                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
													                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
													                                                                      exec csh -c $command
													                                                                source size_cell.tcl     }
     add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT bslice_pre/s1_op1_reg[3][20]/CLK
     for {set i 0} {$i < 20} {incr i} {
															                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
															                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
															                                                                      exec csh -c $command
															                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
																                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
																                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
																                                                                      exec csh -c $command
																                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
																	                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
																	                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
																	                                                                      exec csh -c $command
																	                                                                source size_cell.tcl     }
     for {set i 0} {$i < 20} {incr i} {
																		                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
																		                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
																		                                                                      exec csh -c $command
																		                                                                source size_cell.tcl     }


for {set i 0} {$i < 20} {incr i} {
                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
                                                                                                                                                                                                                      exec csh -c $command
                                                                                                                                                                                                                source size_cell.tcl     }
report_qor -summary
report_timing -max_paths 100 -slack_lesser_than 0
add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT bslice_post/s2_op1_reg[1][13]/CLK
add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT bslice_post/s2_op1_reg[1][56]/CLK
for {set i 0} {$i < 20} {incr i} {
	                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
	                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
	                                                                                                                                                                                                                      exec csh -c $command
	                                                                                                                                                                                                                source size_cell.tcl     }
report_qor -summary
legalize_placement
route_eco
route_detail
report_qor -summary
report_timing -max_paths 100 -slack_lesser_than 0 > timing_path.rpt
exec csh -c {less timing_path.rpt|awk '/Endpoint/ {print "add_buffer -new_net_names luan_net -new_cell_names luan_cell -inverter_pair -lib_cell saed32_rvt|saed32_rvt_std/INVX4_RVT  "$2"/CLK"}' } > add_INV_script
source add_INV_script
for {set i 0} {$i < 20} {incr i} {
		                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
		                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
		                                                                                                                                                                                                                      exec csh -c $command
		                                                                                                                                                                                                                source size_cell.tcl     }
for {set i 0} {$i < 20} {incr i} {
			                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
			                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
			                                                                                                                                                                                                                      exec csh -c $command
			                                                                                                                                                                                                                source size_cell.tcl     }
report_qor -summary
for {set i 0} {$i < 20} {incr i} {
				                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
				                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
				                                                                                                                                                                                                                      exec csh -c $command
				                                                                                                                                                                                                                source size_cell.tcl     }
for {set i 0} {$i < 20} {incr i} {
					                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
					                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
					                                                                                                                                                                                                                      exec csh -c $command
					                                                                                                                                                                                                                source size_cell.tcl     }
for {set i 0} {$i < 20} {incr i} {
						                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
						                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
						                                                                                                                                                                                                                      exec csh -c $command
						                                                                                                                                                                                                                source size_cell.tcl     }
legalize_placement
route_eco
route_detail
report_qor -summary
for {set i 0} {$i < 20} {incr i} {
							                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
							                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
							                                                                                                                                                                                                                      exec csh -c $command
							                                                                                                                                                                                                                source size_cell.tcl     }
for {set i 0} {$i < 20} {incr i} {
								                                                                                                                                                                                                                report_timing -max_paths 200 -slack_lesser_than 0 > timing_path.rpt
								                                                                                                                                                                                                                set command { less timing_path.rpt|awk '/RVT/ || /HVT/' |awk '/\/Y/'|awk '{if ($3>0.05) {print $1,$2}} ' | sed 's/\/Y//g' |sed 's/(//g'|sed 's/)//g'|sed 's/RVT/LVT/g'|sed 's/HVT/LVT/g'|awk '{print "size_cell "$0}'|sort|uniq > size_cell.tcl }
								                                                                                                                                                                                                                      exec csh -c $command
								                                                                                                                                                                                                                source size_cell.tcl     }
report_qor -summary
legalize_placement
route_eco
route_detail
report_qor -summary
save_lib
																										
