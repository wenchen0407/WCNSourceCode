#!/bin/bash

. para.cfg



for lp_sample in $LP_SAMPLE_TIMES
do
{
	for scheme in $SCHEME
	do
	{
		for add_method in $ADD_METHOD
		do
		{
			for startnode in $STARTNODES
			do
			{
				for alpha in $ALPHA
				do
				{
					for control_scheme in $CONTROL_SCHEME
					#for alpha in $ALPHA
					do
					{
						MATLAB_FOLDER=$HOME_DIR$control_scheme"_"$scheme"/script"
						if [ $scheme == 'clAlpha' ] || [ $scheme == 'Alpha' ]; then
							echo $scheme
							cd $MATLAB_FOLDER
							./run.sh $scheme $lp_sample $control_scheme"_"$scheme $FAULT_SEED $alpha $add_method $startnode

						elif [ $scheme == 'static' ]; then
							echo $scheme
							echo $startnode
							cd $MATLAB_FOLDER
							./run.sh $scheme $startnode $control_scheme"_"$scheme $FAULT_SEED '' $add_method $startnode
						else
							echo $scheme
							cd $MATLAB_FOLDER
							./run.sh $scheme $lp_sample $control_scheme"_"$scheme $FAULT_SEED '' $add_method $startnode

						fi	

					}
					done
				}
				done
	
			}
			done
		}
		done
	}
	done
}
done

#cd $BASE_DIR
cd $CURR_DIR
./matlab_rerun.sh




