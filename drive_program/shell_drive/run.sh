#!/bin/bash

. para.cfg

for scheme in $SCHEME
do
{
	run_dir=$HOME_DIR"paper2_experiment_"$scheme"/script"

	for add_method in $ADD_METHOD
	do
	{
		for startnode in $STARTNODES
		do
		{
			#for fault_file in $FAULT_FILE
			#do
			#{
			fault_file="faultModel_"$FAULT_FILE".txt"
			if [ $((startnode < 30)) == '1' ]; then
				start_k='1'
			elif [ $((startnode >= 30)) == '1' ] && [ $((startnode < 39)) == '1' ]; then
				start_k='2'
			elif [ $((startnode >=39)) == '1' ] && [ $((startnode <=47)) == '1' ]; then
				start_k='3'
			else
				start_k='4'
			fi

			echo $startnode
			echo $start_k
		
			if [ $scheme == 'static' ]; then
				cd $run_dir
				./run.sh $startnode $start_k $scheme $FAULT_SEED $add_method $fault_file
			else
				for lp_sample in $LP_SAMPLE_TIMES
				do
				{
					if [ $scheme == 'clAlpha' ] || [ $scheme == 'Alpha' ]; then
		
						for alpha in $ALPHA
						do
						{
							cd $run_dir
							./run.sh $startnode $start_k $scheme $lp_sample $FAULT_SEED $alpha $add_method $fault_file
		
						}
						done
					else
						cd $run_dir
						./run.sh $startnode $start_k $scheme $lp_sample $FAULT_SEED $add_method $fault_file
					fi


				}
				done
			fi
	
			#}
			#done
		}
		done
	}
	done
}
done

cd $BASE_DIR
./delay_energy_rerun.sh


