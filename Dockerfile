FROM runpod/worker-comfyui:5.1.0

# 1) Download the correct single-file Flux checkpoint (includes encoders)
RUN comfy model download \
  --url https://huggingface.co/Comfy-Org/flux1-dev/resolve/main/flux1-dev-fp8.safetensors \
  --relative-path models/checkpoints \
  --filename flux1-dev-fp8.safetensors

# 2) Verify the file is actually a safetensors file (simple header check)
RUN python - <<'PY'\nimport os, sys\np='/comfyui/models/checkpoints/flux1-dev-fp8.safetensors'\nassert os.path.exists(p), 'file missing'\n# safetensors header starts with JSON size in first 8 bytes; a tiny sanity check:\nwith open(p,'rb') as f:\n    hdr=f.read(64)\n    assert len(hdr)>=8, 'truncated download'\nprint('OK: exists & has header bytes. Size:', os.path.getsize(p))\nPY
