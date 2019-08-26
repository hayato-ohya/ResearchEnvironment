FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
ARG PYTHON_VERSION=3.6
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	cmake \
	git \
	curl \
	vim \
	ca-certificates \
	openssh-server \
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
	jupyter \
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
RUN conda install -c conda-forge librosa

# SSH Configuration
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd  # Password
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
