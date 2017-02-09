#!/bin/bash

. para.cfg
. ../global.cfg
#BASE_DIR='/afs/cs.pitt.edu/usr0/wangwenchen/paper2_result/data_faultModel2/'
para=1
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

						python3 getNetworkRes.py $file_res $BASE_DIR"/network_result_revised.txt" $scheme$alpha $lp_sample $nickname $startnode
						rm $file_path"avg_delay_energy.txt"	
						for run in $RUNS
						do
						{
							file1=$file_path$run"_control_input.txt"
							file2=$file_path$run"_curr_node.txt"
							write_file1=$file_path$run"_delay.txt"
							write_file2=$file_path$run"_energy.txt"
							avg_file=$file_path"avg_delay_energy.txt"

							rm $write_file1
							rm $write_file2

						
							python analyse_delay.py $file1 $file2 $write_file1 $write_file2 
							python getMeanDelayEnergy.py $write_file1 $write_file2 $avg_file
						}
						done
						
						file_res1=$file_path"avg_delay_energy.txt"
						nickname=''
						if [ $add_method == '1' ]; then
							nickname='bottom->top'
						elif [ $add_method == '2' ]; then
							nickname='top->bottom'
						else
							nickname='random'
						fi

						python3 getEnergyRes.py $file_res1 $BASE_DIR"/delay_energy_revised.txt" $scheme$alpha $lp_sample $nickname $startnode

						
						
						
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

					python3 getNetworkRes.py $file_res $BASE_DIR"/network_result_revised.txt" $scheme $startnode $nickname $startnode
					rm $file_path"avg_delay_energy.txt"	

					for run in $RUNS
					do
					{
						file1=$file_path$run"_control_input.txt"
						file2=$file_path$run"_curr_node.txt"
						write_file1=$file_path$run"_delay.txt"
						write_file2=$file_path$run"_energy.txt"
						avg_file=$file_path"avg_delay_energy.txt"

						rm $write_file1
						rm $write_file2
					
						python analyse_delay.py $file1 $file2 $write_file1 $write_file2
						python getMeanDelayEnergy.py $write_file1 $write_file2 $avg_file

					}
					done

					file_res1=$file_path"avg_delay_energy.txt"
					nickname=''
					if [ $add_method == '1' ]; then
						nickname='bottom->top'
					elif [ $add_method == '2' ]; then
						nickname='top->bottom'
					else
						nickname='random'
					fi

					python3 getEnergyRes.py $file_res1 $BASE_DIR"/delay_energy_revised.txt" $scheme $lp_sample $nickname $startnode

	
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

					python3 getNetworkRes.py $file_res $BASE_DIR"/network_result_revised.txt" $scheme $lp_sample $nickname $startnode
					rm $file_path"avg_delay_energy.txt"	
					for run in $RUNS
					do
					{
						file1=$file_path$run"_control_input.txt"
						file2=$file_path$run"_curr_node.txt"
						write_file1=$file_path$run"_delay.txt"
						write_file2=$file_path$run"_energy.txt"
						avg_file=$file_path"avg_delay_energy.txt"

						rm $write_file1
						rm $write_file2
					
						python analyse_delay.py $file1 $file2 $write_file1 $write_file2
						python getMeanDelayEnergy.py $write_file1 $write_file2 $avg_file
					}
					done



					file_res1=$file_path"avg_delay_energy.txt"
					nickname=''
					if [ $add_method == '1' ]; then
						nickname='bottom->top'
					elif [ $add_method == '2' ]; then
						nickname='top->bottom'
					else
						nickname='random'
					fi

					python3 getEnergyRes.py $file_res1 $BASE_DIR"/delay_energy_revised.txt" $scheme $lp_sample $nickname $startnode
				
				}
				done
				
			}
		    done
		fi
	}
	done
}
done

