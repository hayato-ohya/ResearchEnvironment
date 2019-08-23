# Research Environment for Machine Learning (Deep Learning)
This Docker file is to build my research environment using nvidia-docker.  
The environment includes many deep learning frameworks and is basically based on conda.  
This Docker image includes following libraries.

## Deep Learning Frameworks
* TensorFlow
* PyTorch
* Chainer / CuPy
* Keras

## Other Libraries
* NumPy
* SciPy
* Matplotlib
* scikit-learn
* Pandas
* FFMpeg
* OpenCV
* LibROSA
etc.

## Usage
### Build
`
sudo docker build -t test/default-dl-image .
`

### Run
`
sudo docker run --gpus all  --rm --name test_container -it test/default-dl-image /bin/bash
`

## Version
Ubuntu: 18.04  
CUDA: 10.0  
cuDNN: 7.0  
Python: 3.6  
