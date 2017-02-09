#!/bin/bash

#rm result.txt send.txt rev.txt noise_generation_distribution.txt network_health.txt link_prob.txt

#TOPO_FILE='generateTopoFile.cc'
START_RSSI='-60'
START_NODES=$1
START_K=$2

#SCHEME='MICD Alpha directJump static'
SCHEME=$3
#LP_SAMPLE_TIMES='10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200'
#TOPO_SAMPLE_TIMES='10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200'
LP_SAMPLE_TIMES=$4
LP_SEED='1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20'
#LP_SEED='1'
BASE_DIR=$HOME/
DATA_FILE_PATH=$BASE_DIR"paper2_result"

FAULT_SEED=$5

Alpha=$6

ADD_METHOD=$7

FAULT_MODEL=$8

if [ $ADD_METHOD == '1' ]; then
	TOPO_FILE='generateUpTopoFile.cc'
elif [ $ADD_METHOD == '2' ]; then
	TOPO_FILE='generateDownTopoFile.cc'
else
	TOPO_FILE='generateRandomTopoFile.cc'
fi

for fault_seed in $FAULT_SEED
do 
{
	FAULT_MODEL_PATH=$DATA_FILE_PATH/"fault_model_"$fault_seed
	#echo $FAULT_MODEL_PATH
	for scheme in $SCHEME
	do
	{
		file_path=$BASE_DIR"paper2_experiment_"$scheme
		#echo $file_path
		cd $file_path
		rm control_input_file.txt node_change_log.txt noise_record.txt delay.txt result.txt send.txt rev.txt noise_generation_distribution.txt network_health.txt link_prob.txt sensor_data.txt
		make micaz sim
		g++ $TOPO_FILE
	
		for lp_sample in $LP_SAMPLE_TIMES
		do
		{
			topo_sample=$lp_sample
			data_directory=$FAULT_MODEL_PATH/"scheme"$scheme$Alpha"_lpSample"$lp_sample"_topoSample"$topo_sample"_ADD"$ADD_METHOD"_start"$START_NODES
			echo $data_directory

			mkdir -p $data_directory

			for lp_seed in $LP_SEED
			do
			{
				#The code begins for innest loop
				
				
				file_name=$lp_seed
				
				# create a simu.cfg file
				./script/simu_setup.sh $lp_sample $topo_sample $Alpha $ADD_METHOD $data_directory/$lp_seed $lp_seed 

				./a.out $START_NODES $START_K $lp_seed
				python tossim-main.py $START_RSSI $FAULT_SEED $FAULT_MODEL

				python $file_path/"script"/"getMean.py" $data_directory/$file_name"_control_input.txt" $data_directory/$file_name"_curr_node.txt" $data_directory/"average_result.txt"
			}
			done
		}
		done

	}
	done
}
done


#cd /Users/wangwenchen/wcps_apps/stepF_HX/script/

#./run.sh $SCHEME $LP_SAMPLE_TIMES stepF_HX $FAULT_SEED

#python3 analyse_control_result.py "/Users/wangwenchen/github/paper2_result/fault_model_"$FAULT_SEED"/scheme"$SCHEME"_lpSample"$LP_SAMPLE_TIMES"_topoSample"$LP_SAMPLE_TIMES/ "/Users/wangwenchen/github/paper2_result/fault_model_"$FAULT_SEED"/" $5


