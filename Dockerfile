FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
ARG PYTHON_VERSION=3.6
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	cmake \
	git \
	curl \
	vim \
	ca-certificates \
	libjpeg-dev \
	libpng-dev &&\
	rm -rf /var/lib/apt/lists/*

# Conda / Pytorch
RUN curl -o ~/miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
	chmod +x ~/miniconda.sh && \
	~/miniconda.sh -b -p /opt/conda && \
     	rm ~/miniconda.sh && \
     	/opt/conda/bin/conda install -y python=$PYTHON_VERSION \
	numpy \
	pyyaml \
	scipy \
	ipython \
	mkl \
	mkl-include \
	ninja \
	cython \
	pandas \
	scikit-learn \
	matplotlib \
	typing && \
     	/opt/conda/bin/conda install pytorch torchvision cudatoolkit=10.0 -c pytorch  && \
     	/opt/conda/bin/conda clean -ya

ENV PATH /opt/conda/bin:$PATH

# Other libraries
RUN pip install ffmpeg
RUN pip install keras tensorflow-gpu
RUN pip install chainer cupy-cuda100
RUN conda install -y -c conda-forge opencv
RUN pip install librosa
