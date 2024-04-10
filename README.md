The original Concept-Graphs website is:https://github.com/concept-graphs/concept-graphs

The original Grounded-Segment-Anything website is:https://github.com/IDEA-Research/Grounded-Segment-Anything#install-without-docker

Thanks so much for their efforts.

# Concept-Graphs + GSA

This is a docker file that contains both Concept-Graphs and Grounded-Segment-Anything for those who want to pursue the VLN research.

First, you need to clone this git project.
```
git clone https://github.com/Mercy2Green/Conceptgraph_GroundedSAM.git
```

Next, you will obtain a Dockerfile and a shell file. You can build this docker by using:
```
docker build -t conceptgraph:11.8.0-cudnn8-devel-ubuntu20.04 .
```

Once the build process is done, you can check if the image is ready to go.
```
docker run --gpus all -it conceptgraph:11.8.0-cudnn8-devel-ubuntu20.04
```

If there are no errors, you can begin to edit the shell file based on your PATH. You may need to change these PATHs in the shell file:
```
export CG_FOLDER=path/to/concept-graphs
export GSA_DIR=path/to/Grounded-Segment-Anything
export REPLICA_ROOT=path/to/replica_niceslam/Replica  
export REPLICA_SEMANTIC_ROOT=path/to/replica-semantic
export REPLICA_CONFIG_DIR=${CG_FOLDER}/conceptgraph/dataset/dataconfigs/replica
export TAG2TEXT_PATH=path/to/recognize-anything 
```

# Test the concept-graphs

Just follow the instructions of Concept-graphs to test this environment. Since this docker is using --mount to mount some folders(projects), you will need to download these folders(projects) on the Concept-Graphs website and the Grounded-Segment-Anything website. And you will need to download the check point files(.pth).
