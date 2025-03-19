#!/bin/bash

# Get the GPU index of the eGPU (replace "GeForce RTX 3090" if necessary)
GPU_UUID=$(nvidia-smi -L | grep "GeForce RTX 3090" | cut -d'(' -f2 | cut -d')' -f1 | cut -c6- | xargs)

# Set the compute mode
nvidia-smi -c 3 -i ${GPU_UUID}
