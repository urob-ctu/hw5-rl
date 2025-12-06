ml PyTorch
ml JupyterNotebook
echo 'Loaded modules'
python -m venv gpufel-env
source gpufel-env/bin/activate
echo 'Activated virtual environment'
pip install --upgrade pip
echo 'Upgraded pip'
pip install -r requirements.txt
echo 'Installed required packages'
echo 'running tests'
python -m pytest -s


echo 'Starting Jupyter Notebook server'
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888
