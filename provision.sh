#!/bin/bash
set -euxo pipefail
cd /workspace/stable-diffusion-webui

# 1) Download SDXL porn + fallback photoreal model
mkdir -p models/Stable-diffusion
aria2c -c -x16 -s16 -k1M \
  -o pornworks_sdxl.safetensors \
  "https://huggingface.co/John6666/pornworks-real-porn-v03-sdxl/resolve/main/pornworks_real_porn_v03_sdxl.safetensors?token=$HF_TOKEN"
aria2c -c -x16 -s16 -k1M \
  -o realisticVisionV60B1.safetensors \
  "https://huggingface.co/SG161222/Realistic_Vision_V6.0_B1_noVAE/resolve/main/realisticVisionV60B1_v51HyperVAE.safetensors?token=$HF_TOKEN"

# 2) Grab AnimateDiff motion model for SDXL
mkdir -p models/AnimateDiff
wget -qO models/AnimateDiff/mm_sd_v14.ckpt \
  https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v14.ckpt

# 3) Install DreamBooth LoRA + AnimateDiff extensions
cd extensions
git clone --depth 1 https://github.com/d8ahazard/sd_dreambooth_extension.git
git clone --depth 1 https://github.com/continue-revolution/sd-webui-animatediff.git

# 4) Auto‑shutdown after 3 h to protect wallet
shutdown -h +180
