# CLAUDE.md - Computer Vision

This file provides guidance to Claude Code when working with the Computer Vision topic.

## Topic Overview

A structured learning project for YOLO evolution and industrial defect detection, targeting Corning interview preparation. Progressing through 5 phases:

1. **Foundations** - YOLOv1/v2 from scratch in PyTorch
2. **Maturity** - YOLOv3/v4/v5 backbone & FPN evolution
3. **Industrial** - YOLOv6/v7/v8 anchor-free & industrial training
4. **Frontier** - YOLOv9/v10/v11/v12/YOLO26 latest innovations
5. **Defect Detection** - MVTec AD + U-Net segmentation + anomaly detection pipeline

## Commands

```bash
# From this directory (topics/computer-vision/)
make papers                      # Download all 14 papers from arXiv

# From project root
make lint                        # Run ruff check --fix + format
make test                        # Run pytest -v
```

## Structure

- `experiments/01_yolo_from_scratch/` - Phase 1: YOLOv1/v2 PyTorch implementation
- `experiments/02_yolo_darknet_fpn/` - Phase 2: Darknet-53 + FPN/PANet
- `experiments/03_modern_yolo_training/` - Phase 3: v6-v8 industrial training + NEU dataset
- `experiments/04_yolo_latest_eval/` - Phase 4: v9-v12 + YOLO26 benchmark
- `experiments/05_defect_detection_pipeline/` - Phase 5: YOLO + U-Net + anomaly detection
- `papers/` - Research papers organized by phase (PDFs gitignored)
- `notes/` - Reading notes organized by phase
- `docs/` - Reference documents (Corning learning path)
- `datasets/` - Training data (gitignored, large files)
- `scripts/` - Utility scripts (download_papers.sh)

## Key Reference Repositories

When implementing experiments, reference these codebases:
- Phase 1-2: `pjreddie/darknet` (original YOLO), `AlexeyAB/darknet` (YOLOv4)
- Phase 3-4: `ultralytics/ultralytics` (v5/v8/v11/YOLO26), `sunsmarterjie/yolov12`
- Phase 5: `amazon-science/patchcore-inspection`, `openvinotoolkit/anomalib`

## Corning Interview Alignment

This topic directly prepares for Corning vision/AI engineer interviews:
- **Algorithm depth**: Explain each YOLO version's core innovation
- **Small target detection**: FPN, multi-scale, anchor-free techniques
- **Data imbalance**: GLASS, GAN augmentation, focal loss
- **Engineering deployment**: TensorRT, ONNX export, inference benchmarking
- **Pixel-level analysis**: U-Net segmentation for precise defect measurement
