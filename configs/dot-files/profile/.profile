#!/bin/bash

ssh-add ~/.ssh/github > /dev/null 2>&1
ssh-add ~/.ssh/gitlab > /dev/null 2>&1

OPENAI_API_KEY=$(cat ~/.ssh/openai-api-key)
LLM_NVIM_API_TOKEN=$(cat ~/.ssh/hugging-face-key)
OATMEAL_OPENAI_TOKEN=$OPENAI_API_KEY
CUDA_VISIBLE_DEVICES=0
MOZ_ENABLE_WAYLAND=1
MOZ_DBUS_REMOTE=1

export MOZ_ENABLE_WAYLAND
export MOZ_DBUS_REMOTE
export CUDA_VISIBLE_DEVICES
export OPENAI_API_KEY
export LLM_NVIM_API_TOKEN
export OATMEAL_OPENAI_TOKEN
