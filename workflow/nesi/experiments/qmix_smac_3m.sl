#!/bin/bash -e

#SBATCH --account uoa02776
#SBATCH --time 4:00:00
#SBATCH --mem 100G
#SBATCH --cpus-per-task 36
#SBATCH --partition large

#SBATCH --chdir	/nesi/project/uoa02776/pymarl
#SBATCH --job-name pymarl
#SBATCH --output /nesi/project/uoa02776/pymarl-util/workflow/nesi/logs/pymarl.%j.out
#SBATCH --error /nesi/project/uoa02776/pymarl-util/workflow/nesi/logs/pymarl.%j.err
#SBATCH --profile task

# required to run on GPU
#module load CUDA/10.0.130
module load gcc/6.3.0
module load cuda91/toolkit/9.1.85

# load the python environment
source /nesi/project/uoa02776/conda.rc
conda activate pymarl

# settings
map=3m
config=qmix_smac.yaml

# replace batch_size_run with the number of cpus
cpus=$SLURM_CPUS_PER_TASK
nesi_config=${config%.*}_nesi_${cpus}
sed src/config/algs/$config -e "s/batch_size_run.*/batch_size_run: $cpus/" > src/config/algs/${nesi_config}.yaml

# run the workflow
srun python -u src/main.py --config=$nesi_config --env-config=sc2 with env_args.map_name=$map
