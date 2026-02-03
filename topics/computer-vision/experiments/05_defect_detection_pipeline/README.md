# Phase 5: Industrial Defect Detection Pipeline

## Experiment Goal

Build a complete industrial defect detection system combining YOLO detection, U-Net segmentation, and anomaly detection methods. This is the capstone phase that directly targets Corning interview preparation.

## Covered Papers

| Paper | Key Contribution |
|-------|-----------------|
| **U-Net** (2015) | Encoder-decoder with skip connections for pixel-level segmentation |
| **MVTec AD** (2019) | Comprehensive real-world anomaly detection benchmark dataset |
| **PatchCore** (2022) | Memory bank-based anomaly detection, near-perfect MVTec AD results |
| **Glass Defect YOLO** (2025) | YOLO applied to optical lens surface defect detection |

## Implementation Steps

### Part A: U-Net Segmentation
1. Implement U-Net from scratch in PyTorch (encoder-decoder + skip connections)
2. Train on MVTec AD segmentation masks (e.g., carpet, leather texture categories)
3. Implement Attention U-Net variant with attention gates
4. Compute Dice coefficient and pixel-level IoU metrics
5. Visualize segmentation results overlaid on defect images

### Part B: Anomaly Detection
1. Implement PatchCore: feature extraction with pre-trained backbone + coreset subsampling
2. Run PatchCore on MVTec AD (15 categories)
3. Study unsupervised vs supervised tradeoff: PatchCore needs only normal samples
4. Compute AUROC and per-pixel AUPRO metrics
5. Compare PatchCore vs YOLO-based detection on the same categories

### Part C: YOLO Defect Detection Pipeline
1. Train YOLO (best version from Phase 4 benchmark) on NEU Surface Defect Dataset
2. Simulate glass defect data using augmentation techniques:
   - CutPaste for synthetic bubble/scratch generation
   - GLASS framework concepts for weak defect synthesis
3. Build hybrid pipeline: anomaly detection (PatchCore) for coarse screening → YOLO for defect classification
4. Add U-Net segmentation for precise defect area measurement

### Part D: Deployment & Optimization
1. Export best model to ONNX → TensorRT (FP16/INT8 quantization)
2. Benchmark inference speed on available hardware
3. Build end-to-end pipeline: image input → preprocessing → inference → classification → visualization
4. Measure throughput: images per second for simulated production line

## Key Learning Points

- **U-Net architecture**: Why skip connections are essential for precise localization in segmentation
- **Supervised vs unsupervised**: YOLO needs labeled defect data; PatchCore only needs normal samples — tradeoff for high-yield production
- **Data synthesis**: How to generate training data when real defect samples are scarce (Corning's core challenge)
- **Hybrid pipeline**: Combining anomaly detection + object detection + segmentation for comprehensive inspection
- **Quantization impact**: How FP16/INT8 affects accuracy vs speed for industrial deployment
- **Pixel-level measurement**: Using U-Net to measure exact defect area (critical for quality grading)

## Datasets

| Dataset | Size | Content | Use Case |
|---------|------|---------|----------|
| MVTec AD | ~5GB | 15 categories, normal + anomaly | Anomaly detection + segmentation |
| NEU Surface Defect | ~20MB | 6 steel defect types, 1800 images | YOLO detection training |
| DAGM 2007 | ~500MB | Synthetic industrial textures | Additional defect detection |

## Corning Interview Alignment

| Interview Dimension | Relevance |
|--------------------|-----------|
| **Physical sensitivity** | Understanding transparent material inspection challenges (glass bubbles, inclusions, scratches) |
| **Algorithm depth** | Hybrid pipeline design: anomaly detection + detection + segmentation |
| **Data imbalance** | Demonstrate solutions for Corning's high-yield scenario (few defect samples) |
| **Small target detection** | Glass micro-bubbles and thin scratches require specialized techniques |
| **Pixel-level analysis** | U-Net segmentation for precise defect area measurement (Corning's quality control requirement) |
| **Engineering deployment** | TensorRT quantization, throughput benchmarking, production-ready pipeline |
| **MLOps awareness** | Understanding model lifecycle: training → deployment → monitoring → retraining |
