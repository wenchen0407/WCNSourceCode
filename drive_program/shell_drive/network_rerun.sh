#!/bin/bash

. para1.cfg


for scheme in $SCHEME
do
{
	for lp_sample in $LP_SAMPLE_TIMES
	do
	{
		if [ $scheme == 'Alpha' ] || [ $scheme == 'clAlpha' ]; then
			for alpha in $ALPHA
			do
			{
				for add_method in $ADD_METHOD
				do
				{
					for startnode in $STARTNODES
					do
					{
						#file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme$alpha"_lpSample"$lp_sample"_topoSample"$lp_sample"_ADD"$add_method"/"
						file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme$alpha"_lpSample"$lp_sample"_topoSample"$lp_sample"_ADD"$add_method"_start"$startnode"/"
						file_res=$file_path"average_result.txt"

						nickname=''
						if [ $add_method == '1' ]; then
							nickname='bottom->top'
						elif [ $add_method == '2' ]; then
							nickname='top->bottom'
						else
							nickname='random'
						fi

						python3 getNetworkRes.py $file_res $BASE_DIR"fault_model_"$FAULT_SEED"/network_result_revised.txt" $scheme$alpha $lp_sample $nickname $startnode
						
						for run in $RUNS
						do
						{
							file1=$file_path$run"_control_input.txt"
							file2=$file_path$run"_curr_node.txt"
							write_file1=$file_path$run"_newNH.txt"
							write_file2=$file_path$run"_costF.txt"
						
							python analyse_nh.py $file1 $file2 $write_file1 $write_file2 $theta
						}
						done
						
						
						
					}
					done
				}
				done
				
			}
			done
	
		elif [ $scheme == 'static' ]; then
			
			for add_method in $ADD_METHOD
			do
			{
				for startnode in $STARTNODES
				do
				{
					file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme$startnode"_ADD"$add_method"/"
					file_res=$file_path'average_result.txt'

					#nickname=$scheme'LP'$lp_sample'ADD'$add_method
					if [ $add_method == '1' ]; then
						nickname="bottom->top"
					elif [ $add_method == '2' ]; then
						nickname="top->bottom"
					else
						nickname="random"
					fi

					python3 getNetworkRes.py $file_res $BASE_DIR"fault_model_"$FAULT_SEED"/network_result_revised.txt" $scheme $startnode $nickname $startnode
				
					for run in $RUNS
					do
					{
						file1=$file_path$run"_control_input.txt"
						file2=$file_path$run"_curr_node.txt"
						write_file1=$file_path$run"_newNH.txt"
						write_file2=$file_path$run"_costF.txt"
					
						python analyse_nh.py $file1 $file2 $write_file1 $write_file2 $theta
					}
					done
	
				}
				done
			}
		    done
		else
			for add_method in $ADD_METHOD
			do
			{
				for startnode in $STARTNODES
				do
				{
					#file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme"_lpSample"$lp_sample"_topoSample"$lp_sample"_ADD"$add_method"/"
					file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme"_lpSample"$lp_sample"_topoSample"$lp_sample"_ADD"$add_method"_start"$startnode"/"
					file_res=$file_path'average_result.txt'

					#nickname=$scheme'LP'$lp_sample'ADD'$add_method
					if [ $add_method == '1' ]; then
						nickname="bottom->top"
					elif [ $add_method == '2' ]; then
						nickname="top->bottom"
					else
						nickname="random"
					fi

					python3 getNetworkRes.py $file_res $BASE_DIR"fault_model_"$FAULT_SEED"/network_result_revised.txt" $scheme $lp_sample $nickname $startnode
				
					for run in $RUNS
					do
					{
						file1=$file_path$run"_control_input.txt"
						file2=$file_path$run"_curr_node.txt"
						write_file1=$file_path$run"_newNH.txt"
						write_file2=$file_path$run"_costF.txt"
					
						python analyse_nh.py $file1 $file2 $write_file1 $write_file2 $theta
					}
					done
				
				}
				done
				
			}
		    done
		fi
	}
	done
}
done

