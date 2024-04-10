#! /bin/bash

export MATTERPORT_DATA_DIR=/media/m2g/Data/Datasets/dataset/v1/unzipped
export MATTERPORT_SIMULATOR_DIR=/media/m2g/Data/Datasets/m2g_vln/Matterport3DSimulator_opencv4
export BEVBERT_DIR=/media/m2g/Data/Datasets/m2g_vln/VLN-BEVBert

export CG_FOLDER=/media/m2g/Data/Datasets/m2g_vln/concept-graphs
export GSA_DIR=/media/m2g/Data/Datasets/m2g_vln/Grounded-Segment-Anything
export REPLICA_ROOT=/media/m2g/Data/Datasets/replica_niceslam/Replica  
export REPLICA_SEMANTIC_ROOT=/media/m2g/Data/Datasets/replica-semantic
export REPLICA_CONFIG_DIR=${CG_FOLDER}/conceptgraph/dataset/dataconfigs/replica
export TAG2TEXT_PATH=/media/m2g/Data/Datasets/m2g_vln/recognize-anything 

# export REPLICA_CONFIG_PATH=/root/mount/concept-graphs/conceptgraph/dataset/dataconfigs/replica/replica.yaml  



# export MATTERPORT_SIMULATOR_DIR=/media/m2g/Data/Datasets/m2g_vln/Matterport3DSimulator
# export MATTERPORT_SIMULATOR_OPENCV4_DIR=/media/m2g/Data/Datasets/m2g_vln/Matterport3DSimulator_opencv4

docker run --gpus all -it\
    --mount type=bind,source=$MATTERPORT_DATA_DIR,target=/root/mount/Matterport3DSimulator/data/v1/scans \
    --mount type=bind,source=$MATTERPORT_SIMULATOR_DIR,target=/root/mount/Matterport3DSimulator \
    --mount type=bind,source=$BEVBERT_DIR,target=/root/mount/VLN-BEVBert \
    --mount type=bind,source=$GSA_DIR,target=/root/mount/Grounded-Segment-Anything \
    --mount type=bind,source=$REPLICA_ROOT,target=/root/mount/Replica \
    --mount type=bind,source=$REPLICA_SEMANTIC_ROOT,target=/root/mount/replica-semantic \
    --mount type=bind,source=$CG_FOLDER,target=/root/mount/concept-graphs \
    --mount type=bind,source=$REPLICA_CONFIG_DIR,target=/root/mount/conceptgraph/dataset/dataconfigs/replica \
    --mount type=bind,source=$TAG2TEXT_PATH,target=/root/mount/recognize-anything \
    conceptgraph:11.8.0-cudnn8-devel-ubuntu20.04    

#    mattersim:9.2-devel-ubuntu18.04
# python precompute_features/grid_mp3d_clip.py --scan_dir=/root/mount/Matterport3DSimulator/data/v1/scans

# mattersim:11.8.0-cudnn8-devel-ubuntu20.04

# docker run --gpus all -it\
#     --mount type=bind,source=$MATTERPORT_DATA_DIR,target=/root/mount/Matterport3DSimulator/data/v1/scans \
#     --mount type=bind,source=$MATTERPORT_SIMULATOR_DIR,target=/root/mount/Matterport3DSimulator \
#     --mount type=bind,source=$BEVBERT_DIR,target=/root/mount/VLN-BEVBert \
#     mattersim:11.8.0-cudnn8-devel-ubuntu20.04