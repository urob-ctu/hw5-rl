# 1. Create a directory for yourself in scratch
mkdir -p /mnt/scratch/temporary/$USER/vscode-server
mkdir -p /mnt/scratch/temporary/$USER/cache
mkdir -p /mnt/scratch/temporary/$USER/envs

# 2. Delete existing heavy folders in HOME (Make sure you don't need data from them)
rm -rf ~/.vscode-server
rm -rf ~/.cache
# (Don't delete your current project source code, just the envs)

# 3. Create Symbolic Links (The Magic Step)
ln -s /mnt/scratch/temporary/$USER/vscode-server ~/.vscode-server
ln -s /mnt/scratch/temporary/$USER/cache ~/.cache

# 4. Create your virtual environment DIRECTLY in scratch
python3 -m venv /mnt/scratch/temporary/$USER/envs/gpufel-env

# 5. Create a convenient link to the env in your project folder
ln -s /mnt/scratch/temporary/$USER/envs/gpufel-env ./gpufel-env


ml PyTorch
ml JupyterNotebook
echo 'Loaded modules'
python -m venv --system-site-packages /mnt/scratch/temporary/$USER/envs/gpufel-env
source /mnt/scratch/temporary/$USER/envs/gpufel-env/bin/activate
echo 'Activated virtual environment'
pip install --upgrade pip
pip install -r requirements.txt

echo 'Installed required packages'
echo 'running tests'
python -m pytest -s


echo 'Starting Jupyter Notebook server'
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888
