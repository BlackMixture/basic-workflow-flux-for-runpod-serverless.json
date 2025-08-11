FROM runpod/worker-comfyui:5.1.0

# 1) Download the correct single-file Flux checkpoint (includes encoders)
RUN comfy model download
  --url https://huggingface.co/Comfy-Org/flux1-dev/resolve/main/flux1-dev-fp8.safetensors
  --relative-path models/checkpoints
  --filename flux1-dev-fp8.safetensors
