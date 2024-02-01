#!/bin/bash

ssh-add ~/.ssh/github > /dev/null 2>&1
ssh-add ~/.ssh/gitlab > /dev/null 2>&1

OPENAI_API_KEY=$(cat ~/.ssh/openai-api-key)
LLM_API_KEY=$(cat ~/.ssh/perplexity-token)
LLM_NVIM_API_TOKEN=$(cat ~/.ssh/hugging-face-key)
OATMEAL_OPENAI_TOKEN=$OPENAI_API_KEY
MOZ_TOKEN=$(cat ~/.ssh/moz_token)
CUDA_HOME="/opt/cuda"
OLLAMA_MODELS=/home/ollama
MOZ_ENABLE_WAYLAND=1
MOZ_DBUS_REMOTE=1
GTK_USE_PORTAL=1

export GTK_USE_PORTAL
export MOZ_TOKEN
export MOZ_ENABLE_WAYLAND
export MOZ_DBUS_REMOTE
export CUDA_VISIBLE_DEVICES
export CUDA_HOME
export OLLAMA_MODELS
export OPENAI_API_KEY
export LLM_API_KEY
export LLM_NVIM_API_TOKEN
export OATMEAL_OPENAI_TOKEN
