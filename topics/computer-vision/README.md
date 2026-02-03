# Computer Vision: YOLO Evolution & Defect Detection

A structured learning project covering the complete YOLO family (v1 to YOLO26) and industrial defect detection, targeting Corning interview preparation.

## Learning Path

| Phase | Focus | Papers | Implementation |
|-------|-------|--------|----------------|
| 1. Foundations | Single-stage detection | YOLOv1, YOLOv2 | YOLO from scratch in PyTorch |
| 2. Maturity | Backbone & neck evolution | YOLOv3, YOLOv4, YOLOv5 | Darknet-53 + FPN/PANet |
| 3. Industrial | Modern architecture | YOLOv6, YOLOv7, YOLOv8 | Anchor-free training + NEU defect |
| 4. Frontier | Latest innovations | YOLOv9-v12, YOLO26 | Attention, NMS-free, benchmark |
| 5. Defect Detection | Industrial application | U-Net, PatchCore, MVTec AD | Full detection pipeline |

## Structure

```
computer-vision/
├── papers/          # Research papers (PDF)
├── notes/           # Reading notes (Markdown)
├── experiments/     # Implementation code
├── datasets/        # Training data (gitignored)
├── docs/            # Reference documents
├── resources/       # Learning resources
└── scripts/         # Utility scripts
```

## Quick Start

```bash
# Download all papers
make papers

# Start learning from Phase 1!
```

## Papers

### YOLO Family

1. **YOLOv1** - [arXiv:1506.02640](https://arxiv.org/abs/1506.02640) - You Only Look Once (2016)
2. **YOLOv2** - [arXiv:1612.08242](https://arxiv.org/abs/1612.08242) - YOLO9000: Better, Faster, Stronger (2017)
3. **YOLOv3** - [arXiv:1804.02767](https://arxiv.org/abs/1804.02767) - An Incremental Improvement (2018)
4. **YOLOv4** - [arXiv:2004.10934](https://arxiv.org/abs/2004.10934) - Optimal Speed and Accuracy (2020)
5. **YOLOv5** - [Ultralytics](https://github.com/ultralytics/yolov5) - No official paper (2020)
6. **YOLOv6** - [arXiv:2209.02976](https://arxiv.org/abs/2209.02976) - A Single-Stage Framework (2022)
7. **YOLOv7** - [arXiv:2207.02696](https://arxiv.org/abs/2207.02696) - Trainable BoF Sets New SOTA (2022)
8. **YOLOv8** - [Ultralytics](https://github.com/ultralytics/ultralytics) - No official paper (2023)
9. **YOLOv9** - [arXiv:2402.13616](https://arxiv.org/abs/2402.13616) - PGI & GELAN (2024)
10. **YOLOv10** - [arXiv:2405.14458](https://arxiv.org/abs/2405.14458) - Real-Time End-to-End (2024)
11. **YOLOv11** - [Ultralytics](https://github.com/ultralytics/ultralytics) - No official paper (2024)
12. **YOLOv12** - [arXiv:2502.12524](https://arxiv.org/abs/2502.12524) - Attention-Centric (2025)
13. **YOLO26** - [Ultralytics](https://docs.ultralytics.com/models/yolo26/) - No official paper (2026)

### Defect Detection

14. **U-Net** - [arXiv:1505.04597](https://arxiv.org/abs/1505.04597) - Convolutional Networks for Biomedical Image Segmentation (2015)
15. **MVTec AD** - [arXiv:1907.08218](https://arxiv.org/abs/1907.08218) - A Comprehensive Real-World Dataset (2019)
16. **PatchCore** - [arXiv:2106.08265](https://arxiv.org/abs/2106.08265) - Towards Total Recall in Industrial Anomaly Detection (2022)
17. **Glass Defect YOLO** - [arXiv:2502.07592](https://arxiv.org/abs/2502.07592) - YOLO for Optical Lens Defect Detection (2025)

## Reference Repositories

- [ultralytics/ultralytics](https://github.com/ultralytics/ultralytics) - YOLOv5/v8/v11/YOLO26
- [pjreddie/darknet](https://github.com/pjreddie/darknet) - Original YOLOv1-v3
- [AlexeyAB/darknet](https://github.com/AlexeyAB/darknet) - YOLOv4
- [sunsmarterjie/yolov12](https://github.com/sunsmarterjie/yolov12) - YOLOv12
- [openvinotoolkit/anomalib](https://github.com/openvinotoolkit/anomalib) - Anomaly detection library
