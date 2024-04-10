#! /bin/bash

export CG_FOLDER=path/to/concept-graphs
export GSA_DIR=path/to/Grounded-Segment-Anything
export REPLICA_ROOT=path/to/replica_niceslam/Replica  
export REPLICA_SEMANTIC_ROOT=path/to/replica-semantic
export REPLICA_CONFIG_DIR=${CG_FOLDER}/conceptgraph/dataset/dataconfigs/replica
export TAG2TEXT_PATH=path/to/recognize-anything 

docker run --gpus all -it\
    --mount type=bind,source=$GSA_DIR,target=/root/mount/Grounded-Segment-Anything \
    --mount type=bind,source=$REPLICA_ROOT,target=/root/mount/Replica \
    --mount type=bind,source=$REPLICA_SEMANTIC_ROOT,target=/root/mount/replica-semantic \
    --mount type=bind,source=$CG_FOLDER,target=/root/mount/concept-graphs \
    --mount type=bind,source=$REPLICA_CONFIG_DIR,target=/root/mount/conceptgraph/dataset/dataconfigs/replica \
    --mount type=bind,source=$TAG2TEXT_PATH,target=/root/mount/recognize-anything \
    conceptgraph:11.8.0-cudnn8-devel-ubuntu20.04    
