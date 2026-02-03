# Phase 2: YOLO Backbone & Neck Evolution

## Experiment Goal

Understand the evolution from Darknet-19 to CSPDarknet-53, and how Feature Pyramid Networks (FPN) and PANet enable multi-scale detection. This phase covers the "maturity era" of YOLO (v3-v5).

## Covered Papers

| Paper | Key Contribution |
|-------|-----------------|
| **YOLOv3** (2018) | Darknet-53 backbone, FPN multi-scale prediction, residual connections |
| **YOLOv4** (2020) | CSPDarknet-53, SPP, PANet, Bag of Freebies/Specials, Mosaic augmentation |
| **YOLOv5** (2020) | Engineering refinements, AutoAnchor, Focus layer, ecosystem maturity |

## Implementation Steps

### Backbone Evolution
1. Implement Darknet-53 with residual blocks in PyTorch
2. Implement CSP (Cross Stage Partial) connection from YOLOv4
3. Compare feature extraction capabilities: Darknet-19 vs Darknet-53 vs CSPDarknet

### Neck Architecture
1. Implement FPN (Feature Pyramid Network) for YOLOv3's 3-scale prediction
2. Implement PANet (Path Aggregation Network) bidirectional feature fusion
3. Implement SPP (Spatial Pyramid Pooling) module
4. Visualize feature maps at different scales

### Data Augmentation (Bag of Freebies)
1. Implement Mosaic augmentation (4 images stitched together)
2. Implement CutMix and MixUp
3. Add label smoothing
4. Benchmark augmentation impact on small datasets

### Baseline Comparison
1. Use Ultralytics YOLOv5 as a training baseline on COCO128
2. Compare custom Darknet-53+FPN vs YOLOv5 out-of-the-box performance

## Key Learning Points

- **Backbone depth matters**: Darknet-53's residual connections enable much deeper feature extraction than Darknet-19
- **FPN vs PANet**: FPN is top-down only; PANet adds bottom-up path for better low-level feature propagation
- **CSP structure**: Splits feature maps to reduce computation while maintaining gradient flow
- **Bag of Freebies**: Free accuracy gains through training tricks (augmentation, label smoothing) with zero inference cost
- **Mosaic augmentation**: Especially important for industrial scenarios with limited training data

## Corning Interview Alignment

| Interview Dimension | Relevance |
|--------------------|-----------|
| **Algorithm depth** | Explain backbone evolution and why deeper networks with residual connections extract better features |
| **Data augmentation** | Critical for Corning's scenario: high yield = few defect samples. Mosaic and CutMix directly applicable |
| **Multi-scale detection** | FPN/PANet architecture is key to detecting defects of varying sizes (micro-bubbles to large cracks) |
