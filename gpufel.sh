# 1. Create a directory for yourself in scratch
mkdir -p /mnt/scratch/temporary/$USER/vscode-server
mkdir -p /mnt/scratch/temporary/$USER/cache
mkdir -p /mnt/scratch/temporary/$USER/envs
mkdir -p /mnt/scratch/temporary/$USER/dotfiles_storage/cache

# Force pip to use scratch for cache
export XDG_CACHE_HOME="/mnt/scratch/temporary/$USER/dotfiles_storage/cache"
export PIP_CACHE_DIR="$XDG_CACHE_HOME/pip"

# 2. Clean up old environments
rm -rf /mnt/scratch/temporary/$USER/envs/gpufel-env
rm -f ./gpufel-env

# 3. Create Symbolic Links (The Magic Step)
# CRITICAL: Remove the folder from HOME first, otherwise linking fails
rm -rf ~/.vscode-server 
ln -s /mnt/scratch/temporary/$USER/vscode-server ~/.vscode-server

# 4. Load Modules
# If this crashes with "Illegal Instruction", switch to: PyTorch/2.1.2-foss-2023a-CUDA-12.1.1
ml OpenSSL
ml PyTorch/2.3.0-foss-2023b-CUDA-12.4.0 
echo 'Loaded modules'

# 5. Create Env
python -m venv --system-site-packages /mnt/scratch/temporary/$USER/envs/gpufel-env
ln -s /mnt/scratch/temporary/$USER/envs/gpufel-env ./gpufel-env
source /mnt/scratch/temporary/$USER/envs/gpufel-env/bin/activate
echo 'Activated virtual environment'

# 6. Install
# Added --no-cache-dir as double safety
pip install --upgrade pip --no-cache-dir
pip install -r gpufel_reqs.txt --no-cache-dir

echo 'Installed required packages'
echo 'running tests'

python -m pytest -s

echo 'Starting Jupyter Notebook server'
# Unset EGL so Jupyter can use the window if needed
unset MUJOCO_GL
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888