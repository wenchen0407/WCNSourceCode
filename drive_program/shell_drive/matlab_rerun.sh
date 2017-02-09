#!/bin/bash

. para.cfg


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
						for control_scheme in $CONTROL_SCHEME
						do
						{
							
							file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme$alpha"_lpSample"$lp_sample"_topoSample"$lp_sample"_ADD"$add_method"_start"$startnode"/"
							#file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme$alpha"_lpSample"$lp_sample"_topoSample"$lp_sample"_ADD"$add_method"/"
							file_res=$file_path"rms_"$control_scheme"control_result.txt"
							rm $file_res
							for run in $RUNS
							do
							{
								filename=$file_path$run"_"$control_scheme"_"$scheme"control_output.txt"

								#read filename
								python getMean.py $filename $file_res

							}
							done
							nickname=''
							if [ $add_method == '1' ]; then
								nickname='bottom->top'
							elif [ $add_method == '2' ]; then
								nickname='top->bottom'
							else
								nickname='random'
							fi

							python3 getControlRes.py $file_res $BASE_DIR"fault_model_"$FAULT_SEED"/rms_"$control_scheme"control_result.txt" $scheme$alpha $lp_sample $nickname $startnode		
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
					for control_scheme in $CONTROL_SCHEME
					do
					{
						file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme$startnode"_ADD"$add_method"/"
						file_res=$file_path'rms_'$control_scheme'control_result.txt'
						rm $file_res
						for run in $RUNS
						do
						{
							#filename=$file_path$run"_"$control_scheme"control_output.txt"
							filename=$file_path$run"_"$control_scheme"_"$scheme"control_output.txt"

							#read filename
							python getMean.py $filename $file_res

						}
						done
						#nickname=$scheme'LP'$lp_sample'ADD'$add_method
						if [ $add_method == '1' ]; then
							nickname="bottom->top"
						elif [ $add_method == '2' ]; then
							nickname="top->bottom"
						else
							nickname="random"
						fi

						python3 getControlRes.py $file_res $BASE_DIR"fault_model_"$FAULT_SEED"/rms_"$control_scheme"control_result.txt" $scheme $startnode $nickname $startnode
		
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
					for control_scheme in $CONTROL_SCHEME
					do
					{
						file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme"_lpSample"$lp_sample"_topoSample"$lp_sample"_ADD"$add_method"_start"$startnode"/"
						#file_path=$BASE_DIR"fault_model_"$FAULT_SEED"/scheme"$scheme"_lpSample"$lp_sample"_topoSample"$lp_sample"_ADD"$add_method"/"
						file_res=$file_path'rms_'$control_scheme'control_result.txt'
						rm $file_res
						for run in $RUNS
						do
						{
							#filename=$file_path$run"_"$control_scheme"control_output.txt"
							filename=$file_path$run"_"$control_scheme"_"$scheme"control_output.txt"

							#read filename
							python getMean.py $filename $file_res

						}
						done
						#nickname=$scheme'LP'$lp_sample'ADD'$add_method
						if [ $add_method == '1' ]; then
							nickname="bottom->top"
						elif [ $add_method == '2' ]; then
							nickname="top->bottom"
						else
							nickname="random"
						fi

						python3 getControlRes.py $file_res $BASE_DIR"fault_model_"$FAULT_SEED"/rms_"$control_scheme"control_result.txt" $scheme $lp_sample $nickname $startnode
	
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

