# Matterport3DSimulator
# Requires nvidia gpu with driver 396.37 or higher

# m2g@m2g:~$ docker run --gpus all --rm -it -v source=$MATTERPORT_DATA_DIR,target=/root/mount/Matterport3DSimulator/data/v1/scans --volume `pwd`:/root/mount/Matterport3DSimulator mattersim:9.2-devel-ubuntu18.04


FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

SHELL ["/bin/bash", "-c"]

# Arguments to build Docker Image using CUDA

# Install a few libraries to support both EGL and OSMESA options
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget doxygen curl libjsoncpp-dev libepoxy-dev libglm-dev libosmesa6 libosmesa6-dev libglew-dev libopencv-dev python3-setuptools python3-dev python3-pip

RUN apt-get install -y python-is-python3 git

# Install miniconda python38

RUN wget -O miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py38_23.11.0-2-Linux-x86_64.sh

RUN /bin/bash miniconda.sh -b -p /opt/conda
RUN rm miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda update -y -n base -c defaults conda

# Concept graph requirements

RUN conda create -y -n conceptgraph anaconda python=3.10 cmake=3.14.0
RUN echo "source activate conceptgraph" >> ~/.bashrc
RUN source activate conceptgraph && conda env config vars set CUDA_HOME=/usr/local/cuda-11.8
RUN source activate conceptgraph && conda env config vars set AM_I_DOCKER=Yes
RUN source activate conceptgraph && conda env config vars set BUILD_WITH_CUDA=True


RUN source activate conceptgraph && \
    pip3 install tyro open_clip_torch wandb h5py openai hydra-core distinctipy && \
    pip3 install ultralytics && \
    pip3 install numpy pandas networkx==2.2 opencv-python

RUN source activate conceptgraph && \
    conda install -y -c fvcore -c iopath -c conda-forge fvcore iopath && \
    conda install -y -c bottler nvidiacub

RUN source activate conceptgraph &&\
    conda install -y -c pytorch faiss-cpu=1.7.4 mkl=2021 blas=1.0=mkl && \
    conda install -y pytorch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 pytorch-cuda=11.8 -c pytorch -c nvidia

RUN source activate conceptgraph && \
    conda install -y pytorch3d -c pytorch3d

RUN source activate conceptgraph && \
    git clone https://github.com/Mercy2Green/Chamferdist_c17.git --recursive && \
    cd ./Chamferdist_c17 && pip3 install . && cd ..

RUN source activate conceptgraph && \
    git clone https://github.com/gradslam/gradslam.git --recursive && \
    cd gradslam && git checkout conceptfusion && pip3 install . && cd ..

# Grounded-SAM Env

# RUN source activate conceptgraph && \
#     conda install -y -c conda-forge cudatoolkit-dev

# ENV CUDA_HOME=/opt/conda/envs/conceptgraph

RUN source activate conceptgraph && \
    git clone https://github.com/IDEA-Research/Grounded-Segment-Anything.git --recursive

RUN source activate conceptgraph && \   
    cd ./Grounded-Segment-Anything && \
    python3 -m pip install --no-cache-dir -e segment_anything && cd ..

RUN source activate conceptgraph && \ 
    cd ./Grounded-Segment-Anything && \
    python3 -m pip install --no-cache-dir wheel && \
    python3 -m pip install --no-cache-dir --no-build-isolation -e GroundingDINO && cd ..

RUN source activate conceptgraph && \
    python3 -m pip install --upgrade diffusers[torch] \
    pycocotools==2.0.6 matplotlib==3.5.3 \
    onnxruntime==1.14.1 onnx==1.13.1 ipykernel==6.16.2 scipy gradio openai
    # git submodule update --init --recursive && \
    # cd grounded-sam-osx && bash install.sh

RUN source activate conceptgraph && \
    git clone https://github.com/xinyu1205/recognize-anything.git --recursive && \
    cd ./recognize-anything && \
    pip3 install -r ./requirements.txt && \
    pip3 install --upgrade setuptools pip install -e . && cd ..

# RUN source activate conceptgraph && conda env config vars set GSA_PATH=/Grounded-Segment-Anything
ENV GSA_PATH=/Grounded-Segment-Anything

# Concept Graphs code

RUN source activate conceptgraph && \
    git clone https://github.com/concept-graphs/concept-graphs.git && \
    cd concept-graphs && \
    pip install -e . && cd ..

# LLaVA
RUN source activate conceptgraph && \
    git clone https://github.com/haotian-liu/LLaVA.git && \
    cd LLaVA && \
    pip3 install --upgrade pip && \
    pip3 install -e . && \
    pip3 install -e ".[train]" && \
    pip3 install flash-attn --no-build-isolation